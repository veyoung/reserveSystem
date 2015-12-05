package com.reserve.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

public class ReserveQueryDto {
	private String queryName;
	
	private String queryMobile;
	
	private String queryIdNumber;
	
	private Date queryStartTime;
	
	private Date queryEndTime;
	
	private String queryStartTimeStr;
	
	private String queryEndTimeStr;
	
	public String getQueryName() {
		return queryName;
	}
	
	public void setQueryName(String queryName) {
		this.queryName = queryName;
	}
	
	public String getQueryMobile() {
		return queryMobile;
	}
	
	public void setQueryMobile(String queryMobile) {
		this.queryMobile = queryMobile;
	}
	
	public String getQueryIdNumber() {
		return queryIdNumber;
	}
	
	public void setQueryIdNumber(String queryIdNumber) {
		this.queryIdNumber = queryIdNumber;
	}
	
	public Date getQueryStartTime() {
		return queryStartTime;
	}
	
	public void setQueryStartTime(Date queryStartTime) {
		this.queryStartTime = queryStartTime;
	}
	
	public Date getQueryEndTime() {
		return queryEndTime;
	}
	
	public void setQueryEndTime(Date queryEndTime) {
		this.queryEndTime = queryEndTime;
	}

	public String getQueryStartTimeStr() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		if (queryStartTime != null) {
			return format.format(queryStartTime);
		} else {
			return "";
		}
	}

	public void setQueryStartTimeStr(String queryStartTimeStr) {
	}

	public String getQueryEndTimeStr() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		if (queryEndTime != null) {
			return format.format(queryEndTime);
		} else {
			return "";
		}
	}

	public void setQueryEndTimeStr(String queryEndTimeStr) {
	}
}
