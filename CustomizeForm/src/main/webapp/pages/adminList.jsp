<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<link rel="stylesheet" href="css/font-awesome.css"/>
<link rel="stylesheet" href="css/distributorlist.css"/>
<style>
html {-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;}
body {font-family: 'Microsoft Yahei', '微软雅黑', '宋体', \5b8b\4f53, Tahoma, Arial, Helvetica, STHeiti;margin: 0;width:100%;height:100%;background-color:#e9e9e9;}

.wrapper{background: none repeat scroll 0 0 #e9e9e9;}
	.admin-wrapper{width:960px;margin:0 auto;background-color:#ffffff;}
		.header{height:50px;background-color:#eeeeee;}
		.front{margin:0 20px 15px 20px;border-bottom:1px dashed #eee;}
			.front p{font-size:95%;color: #555;}
		.require{color:red;}
</style>
</head>
<body>
<div class="wrapper">
	<div class="admin-wrapper">
		<h4 class="header">
			<b>后台查询</b>
		</h4>
		<form id="searchForm" class="form-horizontal" role="form" action="admin" method="get">
         <div class="form-group">
		    <label class="col-sm-2 control-label">姓名</label>
		    <div class="col-sm-3">
				<input name="queryName" type="text" class="form-control">
		    </div>
		 </div> 
		 <div class="form-group">
		    <label class="col-sm-2 control-label">手机号</label>
		    <div class="col-sm-3">
				<input name="queryMobile" type="text" class="form-control">
		    </div>
		 </div>
		 <div class="form-group">
		    <label class="col-sm-2 control-label">时间范围</label>
		    <div class="col-sm-3">
				<input id="queryStartTime" name="queryStartTime" type="text" class="form-control">
				<input id="queryEndTime" name="queryEndTime" type="text" class="form-control">
		    </div>
		 </div>
		 
		 <div class="form-group">
		    <div class="col-sm-offset-2">
		    	<button type="submit" class="btn btn-primary btn-primary">查询&nbsp;&nbsp;<i class="glyphicon glyphicon-search"></i></button>
		    	<button id="export" class="btn btn-primary btn-success">导出excel</button>
		    </div>
		 </div> 
    	</form>
		
		<table class="table table-striped table-hover">
			<tr class="table-title-blue">
				<td width="10%">序号</td>
				<td width="10%">姓名</td>
				<td width="15%">手机号</td>
				<td width="25%">身份证号</td>
				<td width="25%">预约时间</td>
			</tr>
			<c:forEach var="item" items="${page.content}" varStatus="status">
				<tr>
					<td>${status.index+1}</td>
					<td>${item.name}</td>
					<td>${item.mobile}</td>
					<td>${item.idNumber}</td>
					<td>${item.reserveTime}</td>
				</tr>
			</c:forEach>
		</table>
		<div style="float:right">
			<ul class="pagination">
	  			<li class="disabled"><a href="#">&laquo;</a></li>
	  			<li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>
	  			<li><a href="#">2</a></li>
	  			<li><a href="#">3</a></li>
	  			<li><a href="#">4</a></li>
	  			<li><a href="#">&raquo;</a></li>
			</ul>
		</div>
	</div>
</div>
<script src="js/jquery-1.9.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-datepicker.js"></script>
<script type="text/javascript">
$(function(){
	$('#queryStartTime').datepicker();
	$('#queryEndTime').datepicker();
	
	$('#export').on('click',function(){
		
		return false;
	})
})
</script>
</body>
</html>