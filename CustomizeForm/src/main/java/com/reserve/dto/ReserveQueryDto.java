package com.reserve.dto;

import java.util.Date;

public class ReserveQueryDto {
	private String queryName;
	
	private String queryMobile;
	
	private String queryIdNumber;
	
	private Date queryStartTime;
	
	private Date queryEndTime;
	
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
}
