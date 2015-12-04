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
		
		td.day,td.day.old{cursor:pointer;}
		td.day.new,td.day.old{color:#cccccc;}
		
</style>
</head>
<body>
<div class="wrapper">
	<div class="admin-wrapper">
		<h4 class="header">
			<b>后台查询</b>
		</h4>
		<form class="form-inline">
		  <input type="hidden" id="page" name="page"/>
          <input type="hidden" name="totalPages" value="${page.totalPages}">
	      <input type="hidden" name="currentPage" value="${page.number}">
		  <div class="form-group">
		    <label>姓名</label>
		    <input type="text" class="form-control" style="width:80px;">
		  </div>
		  
		  <div class="form-group">
		    <label>手机号</label>
		    <input type="text" class="form-control" style="width:120px;">
		  </div>
		  
		  <div class="form-group">
		  	  <label>起止日期：</label>
	          <div class="input-group">
	              <input type="text" name="queryStartTime" class="form-control queryTime" placeholder="请选择起始日期" data-date-format="yyyy-mm-dd" value="${feedbackQueryDto.queryStartTimeStr}" style="width:150px;"/>
	              <span class="input-group-addon">-</span>
	              <input type="text" name="queryEndTime" class="form-control queryTime" placeholder="请选择截止日期" data-date-format="yyyy-mm-dd" value="${feedbackQueryDto.queryEndTimeStr}" style="width:150px;"/>
	          </div>
          </div>
		  <button type="submit" id="btn-query" class="btn btn-primary btn-primary">查询&nbsp;&nbsp;<i class="glyphicon glyphicon-search"></i></button>
		  <button type="submit" id="btn-export" class="btn btn-primary btn-success">导出excel</button>
		</form>
	  
	  	<!--  
		<form id="searchForm" class="form-inline" role="form">
			<input type="hidden" id="page" name="page"/>
            <input type="hidden" name="totalPages" value="${page.totalPages}">
	        <input type="hidden" name="currentPage" value="${page.number}">
         <div class="form-group">
		    <label class="col-sm-3 control-label">姓名</label>
		    <div class="col-sm-1">
				<input name="queryName" type="text" class="form-control">
		    </div>
		 </div> 
		 <div class="form-group">
		    <label class="col-sm-3 control-label">手机号</label>
		    <div class="col-sm-1">
				<input name="queryMobile" type="text" class="form-control">
		    </div>
		 </div>
		 <div class="form-group">
		    <label class="col-sm-3 control-label">时间范围</label>
		    <div class="col-sm-1">
			    <input name="query" type="text" class="form-control">
			    <input name="query" type="text" class="form-control">
		    </div>
		 </div>
		 
		 <div class="form-group">
		    <div class="col-sm-offset-2">
		    	<button type="submit" id="btn-query" class="btn btn-primary btn-primary">查询&nbsp;&nbsp;<i class="glyphicon glyphicon-search"></i></button>
		    	<button type="submit" id="btn-export" class="btn btn-primary btn-success">导出excel</button>
		    </div>
		 </div> 
    	</form>
		-->
		
		<table class="table table-striped table-hover">
			<tr class="table-title-blue">
				<td width="10%">序号</td>
				<td width="10%">姓名</td>
				<td width="15%">手机号</td>
				<td width="25%">身份证号</td>
				<td width="25%">预约时间</td>
				<td width="15%">身份证照片</td>
			</tr>
			<c:forEach var="item" items="${page.content}" varStatus="status">
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
<script src="/reserve/js/bootstrap-datetimepicker.min.js"></script>
<script src="/reserve/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="/reserve/js/jquery.pagination.js"></script>
<script type="text/javascript">
$(function(){
	$('.queryTime').datetimepicker({
		format: 'yyyy-mm-dd',
        minView: 'month',
        showButtonPanel: true,
        autoclose: true,
        language: 'zh-CN',
        todayHighlight:true,
        initialDate: new Date()
    });
	
	var total = $("#total").data("total");
	//分页，PageCount是总条目数，这是必选参数，其它参数都是可选
    $('#pagination').pagination($('input[name="totalPages"]').val(), {
        callback: function (index, jq) {
            $('#page').val(index);
            $("#searchForm").attr("action","admin");
            $("#searchForm").attr("method","GET");
            $('#searchForm').submit();
            return false;
        }, 
        current_page: $('input[name="currentPage"]').val(),
        items_per_page: 1,
        num_display_entries: 4,
        num_edge_entries: 2,
        prev_text: '<<',
        next_text: '>>',
        load_first_page: false,
        show_if_single_page: true,
    });
	
	
	$('#btn-export').on('click',function(){	
		$("#searchForm").attr("action", "admin/export");
        $('#searchForm').submit();
	});
	
	$('#btn-query').on('click',function(){	
		$("#searchForm").attr("action", "admin");
        $('#searchForm').submit();
	});
	
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