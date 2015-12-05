package com.reserve.util;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import com.reserve.model.ReserveRecord;

public class SendEmailThread extends Thread {
	
	private ReserveRecord content;
	
	public SendEmailThread(ReserveRecord content) {
		this.content = content;
	}
	
	/**
	 * 线程运行
	 */
	public void run() {
		sendMail(content);
	}
	
	/**
	 * 发送邮件提醒
	 * @param record
	 */
	public void sendMail(ReserveRecord record) {
		final Properties props = new Properties();
        /*
         * 可用的属性： mail.store.protocol / mail.transport.protocol / mail.host /
         * mail.user / mail.from
         */
        // 表示SMTP发送邮件，需要进行身份验证
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.host", "smtp.163.com");
         
        // 发件人的账号
        props.put("mail.user", "qrqyy@163.com");
        // 访问SMTP服务时需要提供的密码
        props.put("mail.password", "qrqyy20082451");
 
        try {
        	// 构建授权信息，用于进行SMTP进行身份验证
            Authenticator authenticator = new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    // 用户名、密码
                    String userName = props.getProperty("mail.user");
                    String password = props.getProperty("mail.password");
                    return new PasswordAuthentication(userName, password);
                }
            };
             
            // 使用环境属性和授权信息，创建邮件会话
            Session mailSession = Session.getInstance(props, authenticator);
            // 创建邮件消息
            MimeMessage message = new MimeMessage(mailSession);
            // 设置发件人
            InternetAddress form = new InternetAddress(
                    props.getProperty("mail.user"));
            message.setFrom(form);
     
            // 设置收件人
            InternetAddress to = new InternetAddress("642479980@qq.com");
            message.setRecipient(RecipientType.TO, to);
     
            // 设置抄送
            InternetAddress cc = new InternetAddress("760518799@qq.com");
            message.setRecipient(RecipientType.CC, cc);
     
            // 设置邮件标题
            String title = "姓名:" + record.getName() + "-电话:"+record.getMobile()+"预约提醒";
            message.setSubject(title);
     
            // 设置邮件的内容体
            String content = "\"刘明亮劳模工作室 预约登记表\"有新数据，请登录后台处理。<br>姓名:"+record.getName()
            		+ "<br>手机："  + record.getMobile()
            		+ "<br>身份证号码：" + record.getIdNumber()
            		+ "<br>预约时间：" + record.getReserveTimeStr()
            		+ "<br>情况说明：" + record.getDescription();
            message.setContent(content, "text/html;charset=UTF-8");
            
            // 发送邮件
        	Transport.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
