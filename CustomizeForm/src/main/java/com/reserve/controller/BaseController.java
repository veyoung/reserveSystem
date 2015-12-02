package com.reserve.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import com.reserve.util.StringConst;


public abstract class BaseController {
	
	
    /**
     * 返回成功（不带任何结果值）
     * @return {"success": true}
     */
    protected Map<String, Object> success() {
		Map<String, Object> rt = new HashMap<String, Object>();
        rt.put(StringConst.SUCCESS, true);
        rt.put(StringConst.RESULT, true);	//兼容遗留代码
        return rt;
    }

	/**
	 * 返回请求成功后带相关内容的Map对象
	 * 
	 * @param obj
	 * @return {<br>"success": true<br>"content": obj<br>}
	 */
	protected Map<String, Object> success(Object obj){
		Map<String, Object> rt = success();
		if(obj != null){
			rt.put("content", obj);
		}
		return rt;
	}

	/**
	 * 返回失败
	 * @return
	 */
	protected Map<String, Object> fail() {
		Map<String, Object> rt = new HashMap<String, Object>();
        rt.put(StringConst.SUCCESS, false);
        return rt;
    }
	
	/**
     * 返回失败，并带相关失败消息
	 * @param response  用于设置status=299,不需要时可设置传null
	 * @param code 错误编号，如：20001
	 * @param message 错误消息key,如:account.password.incorrect
	 * @param description 页面显示错误消息：如：password is incorrect
	 * @param cause 调试信息：如：suiteId=1
     * @return {<br>"success": false<br>"result": false<br>"code": 错误编号<br>"error": 错误消息<br>"description": 页面显示错误消息<br>"cause": 调试信息<br>}
	 */
	protected Map<String, Object> fail(HttpServletResponse response, Integer code, String message, String description, String cause){
		Map<String, Object> rt = new HashMap<String, Object>();
		rt.put(StringConst.SUCCESS, false);
        rt.put(StringConst.RESULT, false);//兼容遗留代码
		if(code != null){
			rt.put(StringConst.CODE, code);//api
		}
		if(message != null){
			rt.put(StringConst.ERROR, message);//老api
			rt.put(StringConst.MESSAGE, message);//新api
		}
		if(description != null){
			rt.put(StringConst.DESCRIPTION, description);//老api规范
		}
		if(cause != null){
			rt.put(StringConst.CAUSE, cause);
		}
		if(response != null){
			response.setStatus(299);
		}
		return rt;
	}
    
    protected String filterXss(String str){
    	if(StringUtils.isBlank(str)){
    		return str;
    	}
    	
    	str = str.replace("<", "&lt;");
    	str = str.replace(">", "&gt;");
    	return str;
    }

}
