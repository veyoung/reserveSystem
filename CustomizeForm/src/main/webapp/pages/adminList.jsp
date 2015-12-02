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
			<b>分销商列表</b>
			<div class="pull-right action-group">               
				<button class="btn btn-success" data-toggle="modal" data-target="#myModal">
  					<i class="ace-icon fa fa-plus-circle"></i>添加分销商
				</button>                     
			</div>
		</h4>
		
		<table class="table table-striped table-hover">
			<tr class="table-title-blue"><td width="10%" class="distributor-font">分销商姓名</td><td width="15%">ID</td><td width="20%">等级</td><td width="15%">所属会员</td><td width="20%">下属会员</td><td width="20%">操作</td></tr>
			<tr><td class="distributor-font">&nbsp;余扬</td><td>56235123</td><td>钻石会员</td><td>李斯</td><td><a href="distributorsubmember.html">查看</a></td>
				<td>
					<a class="blue" href="distributoredit.html"><i class="ace-icon fa fa-pencil"></i>编辑&nbsp;&nbsp;</a>
					<a class="orange"><i class="ace-icon fa fa-pencil"></i>删除</a>
				</td>
			</tr>
			<tr><td class="distributor-font">&nbsp;余扬</td><td>56235123</td><td>钻石会员</td><td>李斯</td><td><a href="distributorsubmember.html">查看</a></td>
				<td>
					<a class="blue" href="distributoredit.html"><i class="ace-icon fa fa-pencil"></i>编辑&nbsp;&nbsp;</a>
					<a class="orange"><i class="ace-icon fa fa-pencil"></i>删除</a>
				</td>
			</tr>			
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
</body>
</html>