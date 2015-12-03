<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<link rel="stylesheet" href="/reserve/css/bootstrap.min.css"/>
<link rel="stylesheet" href="/reserve/css/font-awesome.css"/>
<link rel="stylesheet" href="/reserve/css/pagination.css"/>
<style>
html {-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;}
body {font-family: 'Microsoft Yahei', '微软雅黑', '宋体', \5b8b\4f53, Tahoma, Arial, Helvetica, STHeiti;margin: 0;width:100%;height:100%;background-color:#e9e9e9;}

.wrapper{background: none repeat scroll 0 0 #e9e9e9;}
	.admin-wrapper{width:960px;margin:0 auto;background-color:#ffffff;}
		.header{height:50px;background-color:#eeeeee;}
		.front{margin:0 20px 15px 20px;border-bottom:1px dashed #eee;}
			.front p{font-size:95%;color: #555;}
		.require{color:red;}
		.photo-wrapper{width:200px;height:300px;}
			#photo{width:560px;height:300px;}
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
				<td width="15%">身份证照片</td>
			</tr>
			<c:forEach var="item" items="${reserveRecords}" varStatus="status">
				<tr>
					<td>${status.index+1}</td>
					<td>${item.name}</td>
					<td>${item.mobile}</td>
					<td>${item.idNumber}</td>
					<td>${item.reserveTimeStr}</td>
					<td>
						<c:if test="${item.idPhoto == null}">
							未上传
						</c:if>
						<c:if test="${item.idPhoto != null }">
							<a href="" class="view-photo" id="${item.id}">查看</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
		<span id="total" data-total="${total}"></span>
		<div style="background-color:#eff3f8;height:60px;margin-top:-20px">
			<div class="col-sm-3"><span id ="statics" style="line-height:60px"></span></div>
			<div class="col-sm-9"><div id="pagination" style="float:right"></div></div>
		</div>
		
		
		<!-- Modal -->
		<div class="modal" id="photoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h4 class="modal-title">身份证照片</h4>
		      </div>
		      <div class="modal-body">
		      	<div class="photo-wrapper">
		      		<img id="photo"/>
		      	</div>
		      </div>
		      <div class="modal-footer">
			        <button class="btn btn-primary" data-dismiss="modal">关闭</button>
			  </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div>
		<!-- /.modal --> 
	</div>
</div>
<script src="/reserve/js/jquery-1.9.1.min.js"></script>
<script src="/reserve/js/bootstrap.min.js"></script>
<script src="/reserve/js/bootstrap-datepicker.js"></script>
<script src="/reserve/js/jquery.pagination.js"></script>
<script type="text/javascript">
$(function(){
	$('#queryStartTime').datepicker();
	$('#queryEndTime').datepicker();
	
	var total = $("#total").data("total");
	//分页，PageCount是总条目数，这是必选参数，其它参数都是可选
    $('#pagination').pagination(total, {
        callback: PageCallback, 
        prev_text: '<<',
        next_text: '>>',
        items_per_page:10,
        num_edge_entries: 2, //两侧首尾分页条目数
        num_display_entries: 5, //连续分页主体部分分页条目数
        current_page: 0, //当前页索引
    });
	
    function PageCallback(index, jq) {
    	location.href = '/reserve/admin/' + index;
    }
	
	$('#export').on('click',function(){	
		location.href = '/reserve/admin/export';
	})
	
	$('.view-photo').on('click',function(){
		var id = $(this).attr('id');
		$.ajax({
            type:"GET",
            url:"record/" + id,
            success:function(data){
           		$("#photo").attr('src','/reserve/photo/'+id);         
            }
         });

		$('#photoModal').modal();
		return false;
	})
})
</script>
</body>
</html>