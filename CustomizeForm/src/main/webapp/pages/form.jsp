<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
<title>刘明亮劳模工作室 预约登记表</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<link rel="stylesheet" href="css/font-awesome.css"/>
<style>
html {-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;}
body {font-family: 'Microsoft Yahei', '微软雅黑', '宋体', \5b8b\4f53, Tahoma, Arial, Helvetica, STHeiti;margin: 0;width:100%;height:100%;background-color:#e9e9e9;}

.wrapper{background: none repeat scroll 0 0 #e9e9e9;}
	.form-wrapper{width:640px;margin:0 auto;background-color:#ffffff;}
		.header{height:50px;background-color:#eeeeee;}
		.front{margin:0 20px 15px 20px;border-bottom:1px dashed #eee;}
			.front p{font-size:95%;color: #555;}
		.require{color:red;}
	.hidden{display:none;}
	.show{dispaly:block;}
</style>
</head>
<body>
<div class="wrapper">
	<div class="form-wrapper">
		<div class="header"></div>
		<div class="front">
			<h3><b>刘明亮劳模工作室 预约登记表</b></h3>
			<p>请认真正确的填写您的预约信息和联系方式，以方便我们与您联系。我们的工作时间是9:00--18:00，请在工作时间内预约，方便我们更好的为您提供服务。</p>
		</div>

		<form name="myForm" class="form-horizontal" action="form" method="post" enctype="multipart/form-data">
		  <div class="form-group"> 
			<label for="name" class="col-sm-3 control-label"><span class="require">*</span>姓名</label>
			<div class="col-sm-8">
			  <input type="text" name="name" class="form-control" id="name">
			  <div id="name-alert" class="alert alert-danger help-block hidden">姓名不能为空</div>
			</div>
		  </div>
		  <div class="form-group">
			<label for="mobile" class="col-sm-3 control-label"><span class="require">*</span>手机号</label>
			<div class="col-sm-8">
			  <input type="text" name="mobile" class="form-control" id="mobile">
			  <div id="mobile-empty-alert" class="alert alert-danger help-block hidden">手机号不能为空 </div>
			  <div id="mobile-wrong-alert" class="alert alert-danger help-block hidden">手机号格式不正确</div>			  
			</div>
		  </div>
		  <div class="form-group">
			<label for="idNumber" class="col-sm-3 control-label">身份证号</label>
			<div class="col-sm-8">
			  <input type="text" name="idNumber" class="form-control" id="idNumber">
			</div>
		  </div>
		  <div class="form-group">
			<label for="upload" class="col-sm-3 control-label">请上传身份证</label>
			<div class="col-sm-8">
			  <input type="file" name="file" class="form-control" id="upload">
			</div>
		  </div>
		  <div class="form-group">
			<label for="reserveTime" class="col-sm-3 control-label"><span class="require">*</span>预约时间</label>
			<div class="col-sm-8">
			  <input type="text" name="reserveTime" class="form-control" id="reserveTime" style="cursor:pointer;">
			  <div id="reserveTime-alert" class="alert alert-danger help-block hidden">预约时间不能为空</div>
			</div>
		  </div>
		  <div class="form-group">
			<label for="description" class="col-sm-3 control-label">情况说明</label>
			<div class="col-sm-8">
			  <textarea name="description" id="description" class="form-control" rows="5"></textarea>
			</div>
		  </div>
		  <div class="form-group">
			<div class="col-sm-offset-3 col-sm-8">
			  <button id="btn-submit" class="btn btn-primary" style="width:80px;">提交</button>
			</div>
		  </div>
		</form>
		<br><br>
	</div>
</div>

<script src="js/jquery-1.9.1.min.js"></script>
<script src="js/angular.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-datepicker.js"></script>
<script src="js/form.js"></script>
<script type="text/javascript">
$(function(){
	$('#reserveTime').datepicker();
	
	$('#btn-submit').on('click',function(){
		var name = $('#name').val();
		var mobile = $('#mobile').val();
		var reserveTime = $('#reserveTime').val();
		
		if (name === '') {
			$('#name-alert').removeClass('hidden');
			return false;
		} else {
			$('#name-alert').addClass('hidden');
		}
		
		if (mobile === '') {
			$('#mobile-empty-alert').removeClass('hidden');
			return false;
		} else {
			$('#mobile-empty-alert').addClass('hidden');
		}
		
		if (reserveTime === '') {
			$('#reserveTime-alert').removeClass('hidden');
			return false;
		} else {
			$('#reserveTime-alert').addClass('hidden');
		}
		
		return true;
	})
	
	
})
</script>
</body>
</html>