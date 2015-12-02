package com.reserve.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.reserve.dto.ReserveQueryDto;
import com.reserve.mapper.ReserveRecordMapper;
import com.reserve.model.ReserveRecord;
import com.reserve.util.IdGenerator;

@Controller
public class AdminController extends BaseController{
	@Autowired
	ReserveRecordMapper reserveRecordMapper;
	
	private final int EXPORT_BATCH_SIZE = 1000;
	
	@RequestMapping(value = "/go",  method = RequestMethod.GET)
	@ResponseBody
	public String go() {
		return "go";
	}
	
	@RequestMapping(value = "/form",  method = RequestMethod.GET)
	public String form() {
		return "form";
	}
	
	/**
	 * 表单提交
	 * @param reserveRecord
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/form",  method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> reserve(
			ReserveRecord record,
			HttpServletRequest request,
			HttpServletResponse response) {
		try {
			record.setId(IdGenerator.getInstance().nextId());
			reserveRecordMapper.insertSelective(record);
			sendMail(record);
			return success();
		} catch (Exception e) {
			e.printStackTrace();
			return fail();
		}
	}
	
	/**
	 * 后台查询所有数据
	 * @param reserveQueryDto
	 * @param model
	 * @param request
	 * @param response
	 * @param pageable
	 * @return
	 */
	@RequestMapping(value = "/admin",  method = RequestMethod.GET)
	public String adminList(
			ReserveQueryDto reserveQueryDto,
			Model model,
			HttpServletRequest request,
			HttpServletResponse response,
			@PageableDefault(page=0, size=10, sort="create_time", direction = Sort.Direction.DESC) Pageable pageable) {
		try {
			
			Map<String, Object> param = createParam(reserveQueryDto);
			List<ReserveRecord> reserveRecords = reserveRecordMapper.selectSelective(param);
			int total = reserveRecordMapper.countSelectSelective(param);
			 
			Page<?> page = new PageImpl<ReserveRecord>(reserveRecords, pageable, total);
			model.addAttribute("page", page);
			model.addAttribute("reserveQueryDto", reserveQueryDto);
			return "adminList";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
	
	/**
	 * 导出到excel中
	 * @param reserveQueryDto
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "/admin/export")
    public void exportOrderRecords(
    		ReserveQueryDto reserveQueryDto,
    		HttpServletResponse response) throws IOException {
        
        OutputStream out = response.getOutputStream();
    	response.setHeader("Content-Disposition", "attachment; filename=\"" + "data.xls\"");
    	exportReserveRecords(reserveQueryDto, out);
        out.flush();
    }

	/**
	 * 构造参数
	 * @param reserveQueryDto
	 * @return
	 */
	private Map<String, Object> createParam(ReserveQueryDto reserveQueryDto) {
		Map<String, Object> param = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(reserveQueryDto.getQueryName())) {
			param.put("name", reserveQueryDto.getQueryName());
		}
		if (StringUtils.isNotBlank(reserveQueryDto.getQueryMobile())) {
			param.put("mobile", reserveQueryDto.getQueryMobile());
		}
		param.put("startTime", reserveQueryDto.getQueryStartTime());
		param.put("endTime", reserveQueryDto.getQueryEndTime());
		return param;
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
            		+ "<br>身份证号码：" + record.getMobile() 
            		+ "<br>预约时间：" + record.getReserveTime()
            		+ "<br>情况说明：" + record.getDescription();
            message.setContent(content, "text/html;charset=UTF-8");
            
            // 发送邮件
        	Transport.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 导出excel
	 * @return
	 */
	public void exportReserveRecords(ReserveQueryDto reserveQueryDto, OutputStream out) throws IOException{
		long begin = System.currentTimeMillis();
        int cell = 0;
        Workbook wb = new HSSFWorkbook();
        Sheet sheet = wb.createSheet("new sheet");
        Row row = sheet.createRow((short)0);
        row.createCell(cell++).setCellValue("序号");
        row.createCell(cell++).setCellValue("姓名");
        row.createCell(cell++).setCellValue("手机号");
        row.createCell(cell++).setCellValue("身份证号码");
        row.createCell(cell++).setCellValue("预约时间");
        row.createCell(cell++).setCellValue("情况说明");
        row.createCell(cell++).setCellValue("提交时间");
        
        Map<String, Object> param = createParam(reserveQueryDto);
        List<ReserveRecord> reserveRecords = reserveRecordMapper.selectSelective(param);
		int total = reserveRecordMapper.countSelectSelective(param);
		
//        Map<String, Object> param = addParam(dto,  null);
//        Integer total = orderRecordMapper.countOrdersSelective(param);
//        int rowIndex = 0;
//        for(int i = 0; i < (total/ EXPORT_BATCH_SIZE + 1); i++) {//小批量处理，放在内存开销太大
//            Pageable pageable = new PageRequest(i, EXPORT_BATCH_SIZE, new Sort(Direction.DESC,"createTime"));
//            Page<OrderRecord> page = getOrderList(dto,  pageable);
//            List<OrderRecord> orders = page.getContent();
//            for(int j = 0; j < orders.size(); j++) {
//            	cell = 0;
//            	OrderRecord orderRecord = orders.get(j);
//            	if(orderRecord != null){
//            		row = sheet.createRow(++rowIndex);
//                    row.createCell(cell++).setCellValue(rowIndex);
//                    row.createCell(cell++).setCellValue(orderRecord.getId() != null ? orderRecord.getId().toString() : "");
//                    row.createCell(cell++).setCellValue(orderRecord.getUserId() == null ? "" : orderRecord.getUserId().toString());
//                    if(Objects.equal(orderRecord.getChannelId(), '1')){
//                    	row.createCell(cell++).setCellValue("购买");
//                    }else if(Objects.equal(orderRecord.getChannelId(), '2')){
//                    	row.createCell(cell++).setCellValue("邀请码");
//                    }else if(Objects.equal(orderRecord.getChannelId(), '3')){
//                    	row.createCell(cell++).setCellValue("申请试用");
//                    }else if(Objects.equal(orderRecord.getChannelId(), '4')){
//                    	row.createCell(cell++).setCellValue("预授权");
//                    }else if(Objects.equal(orderRecord.getChannelId(), '5')){
//                    	row.createCell(cell++).setCellValue("应用内购买");                	
//                    }else{
//                    	row.createCell(cell++).setCellValue(""); 
//                    }
//                    if(orderRecord.getItems() != null){
//                    	String suiteName = "";
//                    	String suiteId = "";
//                    	for(OrderItem orderItem : orderRecord.getItems()){
//                    		if(orderItem.getSuiteName() != null){
//                    			suiteName = suiteName + " " + orderItem.getSuiteName();
//                    		}
//                    		if(orderItem.getSuiteId() != null){
//                    			suiteId = suiteId + " " + orderItem.getSuiteId();
//                    		}
//                    	}
//                    	row.createCell(cell++).setCellValue(suiteId);  
//                    	row.createCell(cell++).setCellValue(suiteName); 
//                    }else{
//                    	row.createCell(cell++).setCellValue("");  
//                    	row.createCell(cell++).setCellValue("");
//                    }
//                    row.createCell(cell++).setCellValue(orderRecord.getOriginalPrice()  == null ? 0 : orderRecord.getOriginalPrice().doubleValue()/100);
//                    row.createCell(cell++).setCellValue(orderRecord.getPresentPrice() == null ? 0 : orderRecord.getPresentPrice().doubleValue()/100);
//                    row.createCell(cell++).setCellValue(orderRecord.getDiscountPrice() == null ? 0 : orderRecord.getDiscountPrice().doubleValue()/100);
//                    //row.createCell(cell++).setCellValue(orderRecord.getDiscountCode() == null ? "" : orderRecord.getDiscountCode());
//                    row.createCell(cell++).setCellValue(orderRecord.getDealPrice() == null ? 0 : orderRecord.getDealPrice().doubleValue()/100);
//                    if(Objects.equal(orderRecord.getPayType(), 1)){
//                    	row.createCell(cell++).setCellValue("在线支付");
//                    }else if(Objects.equal(orderRecord.getPayType(), 2)){
//                    	row.createCell(cell++).setCellValue("货到付款"); 
//                    }else if(Objects.equal(orderRecord.getPayType(), 3)){
//                    	row.createCell(cell++).setCellValue("公司转账"); 
//                    }else{
//                    	row.createCell(cell++).setCellValue(""); 
//                    }
//                    if(Objects.equal(orderRecord.getStatus(), OrderRecord.STATUS_PAYING)){
//                    	row.createCell(cell++).setCellValue("在线支付 待支付");                	
//                    }else if(Objects.equal(orderRecord.getStatus(), OrderRecord.STATUS_PAYED)){
//                    	row.createCell(cell++).setCellValue("在线支付 已支付");                	
//                    }else if(Objects.equal(orderRecord.getStatus(), OrderRecord.STATUS_NEW_ON_DELIVERY)){
//                    	row.createCell(cell++).setCellValue("货到付款 待付款");                	
//                    }else if(Objects.equal(orderRecord.getStatus(), OrderRecord.STATUS_COMPLETED_ON_DELIVERY)){
//                    	row.createCell(cell++).setCellValue("货到付款 已付款");                	
//                    }else if(Objects.equal(orderRecord.getStatus(), OrderRecord.STATUS_TRANSFERING)){
//                    	row.createCell(cell++).setCellValue("公司转账  待转账");                	
//                    }else if(Objects.equal(orderRecord.getStatus(), OrderRecord.STATUS_CONFIRMED_ON_TRANSFER)){
//                    	row.createCell(cell++).setCellValue("公司转账  已转账");                	
//                    }else if(Objects.equal(orderRecord.getStatus(), OrderRecord.STATUS_SYSTEM_CONFIRMED_ON_TRANSFER)){
//                    	row.createCell(cell++).setCellValue("公司转账  已转账");                	
//                    }else if(Objects.equal(orderRecord.getStatus(), OrderRecord.STATUS_CANCEL)){
//                    	row.createCell(cell++).setCellValue("取消");                	
//                    }else{
//                    	row.createCell(cell++).setCellValue(""); 
//                    }
//                    row.createCell(cell++).setCellValue(orderRecord.getAppKey() == null ? "" : orderRecord.getAppKey());
//                    row.createCell(cell++).setCellValue(orderRecord.getPayId() == null ? "" : orderRecord.getPayId().toString());
//                    if(Objects.equal(orderRecord.getPayProvider(), 1) || Objects.equal(orderRecord.getPayProvider(), 40000)) {
//                    	row.createCell(cell++).setCellValue("财付通");
//                    }else if(Objects.equal(orderRecord.getPayProvider(), 2) || Objects.equal(orderRecord.getPayProvider(), 30000)) {
//                    	row.createCell(cell++).setCellValue("快钱");
//                    }else  if(Objects.equal(orderRecord.getPayProvider(), 3) || Objects.equal(orderRecord.getPayProvider(), 50000)) {
//                    	row.createCell(cell++).setCellValue("支付宝");
//                    }else if(Objects.equal(orderRecord.getPayProvider(), 4) || Objects.equal(orderRecord.getPayProvider(), 60000)) {
//                    	row.createCell(cell++).setCellValue("微信支付");
//                    }else {
//                    	row.createCell(cell++).setCellValue("");
//                    }
//                    row.createCell(cell++).setCellValue(orderRecord.getPayTime() != null ? longFormat.format(orderRecord.getPayTime()) : "");
//                    row.createCell(cell++).setCellValue(orderRecord.getExpressId() == null ? "" : orderRecord.getExpressId());
//                    row.createCell(cell++).setCellValue(orderRecord.getExpressChannel() == null ? "" : orderRecord.getExpressChannel());
//                    row.createCell(cell++).setCellValue(orderRecord.getContactName() == null ? "" : orderRecord.getContactName());
//                    row.createCell(cell++).setCellValue(orderRecord.getContactPhone() == null ? "" : orderRecord.getContactPhone());
//                    row.createCell(cell++).setCellValue(orderRecord.getChargeable() == null ? "" : orderRecord.getChargeable().toString());
//                    row.createCell(cell++).setCellValue(orderRecord.getInvoiceEnable() == null ? "" : orderRecord.getInvoiceEnable().toString());
//                    row.createCell(cell++).setCellValue(orderRecord.getEffectiveDate() != null ? longFormat.format(orderRecord.getEffectiveDate()) : "");
//                    row.createCell(cell++).setCellValue(orderRecord.getSource() == null ?  "" : orderRecord.getSource());
//                    row.createCell(cell++).setCellValue(orderRecord.getRemark() == null ?  "" : orderRecord.getRemark());
//                    if(orderRecord.getItems() != null){
//                    	String branchName = "";
//                    	String crmId = "";
//                    	for(OrderItem orderItem : orderRecord.getItems()){
//                    		if(orderItem.getBranchName() != null){
//                    			branchName = branchName + " " + orderItem.getSuiteName();
//                    		}
//                    		if(orderItem.getCrmId() != null){
//                    			crmId = crmId + " " + orderItem.getSuiteId();
//                    		}
//                    	}
//                    	row.createCell(cell++).setCellValue(branchName);  
//                    	row.createCell(cell++).setCellValue(crmId); 
//                    }else{
//                    	row.createCell(cell++).setCellValue("");  
//                    	row.createCell(cell++).setCellValue("");
//                    }
//                    row.createCell(cell++).setCellValue(orderRecord.getCreateTime() != null ? longFormat.format(orderRecord.getCreateTime()) : "");
//            	}  
//            }
        wb.write(out);
    }
}
