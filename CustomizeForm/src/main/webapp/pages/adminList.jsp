<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
<title>刘明亮劳模工作室 后台管理</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<link rel="stylesheet" href="/reserve/css/bootstrap.min.css"/>
<link rel="stylesheet" href="/reserve/css/font-awesome.css"/>
<link rel="stylesheet" href="/reserve/css/pagination.css"/>
<style>
html {-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;}
body {font-family: "Lantinghei SC", "Hiragino Sans GB",'Microsoft Yahei', '微软雅黑', '宋体', \5b8b\4f53, Tahoma, Arial, Helvetica, STHeiti;margin: 0;width:100%;height:100%;}

.wrapper{}
	.navi{height:54px;width:100%;border-bottom:2px solid #478DCD;background-image:url(images/header.png);background-repeat:repeat-x;}
		.navi-content{width:960px;margin:0 auto;}
	.admin-wrapper{width:960px;margin:0 auto;background-color:#ffffff;}
		.header{height:50px;background-color:#401ffb;color:white;}
		.front{margin:0 20px 15px 20px;border-bottom:1px dashed #eee;}
			.front p{font-size:95%;color: #555;}
		.form-box{margin:15px 0 10px 0;border:1px solid #478DCD;padding:20px 5px 20px 5px;border-radius:5px;background-color:#EEF1F8;}
		
		.require{color:red;}
		.photo-wrapper{width:200px;height:300px;}
			#photo{width:560px;height:300px;}
		
		td.day,td.day.old{cursor:pointer;}
		td.day.new,td.day.old{color:#cccccc;}
		tr.table-content td{font-size:15px;}
		tr.table-title td{font-weight:bold;color:white;background-color:#2D90D0;}
		.orange{color:orange;cursor:pointer;}
		
</style>
</head>
<body>
<div class="wrapper">
	<div class="navi">
		<div class="navi-content">
			<h4>
				<b style="line-height:40px;">刘明亮劳模工作室——管理中心</b>
			</h4>
		</div>
	</div>
	<div class="admin-wrapper">
		<div class="form-box">
			<form class="form-inline" id="searchForm">
			  <input type="hidden" id="page" name="page"/>
	          <input type="hidden" name="totalPages" value="${page.totalPages}">
		      <input type="hidden" name="currentPage" value="${page.number}">
		      <input type="hidden" name="total" value="${total}">
			  <div class="form-group" style="margin-left:10px;">
			    <label>姓名</label>
			    <input type="text" name="queryName" class="form-control" style="width:100px;" placeholder="请输入姓名" value="${reserveQueryDto.queryName}">
			  </div>
			  
			  <div class="form-group" style="margin-left:10px;">
			    <label>手机号</label>
			    <input type="text" name="queryMobile" class="form-control" style="width:120px;"  placeholder="请输入手机号" value="${reserveQueryDto.queryMobile}">
			  </div>
			  
			  <div class="form-group" style="margin-left:10px;margin-right:10px;">
			  	  <label>预约日期：</label>
		          <div class="input-group">
		              <input type="text" name="queryStartTime" class="form-control queryTime" placeholder="请选择起始日期" data-date-format="yyyy-mm-dd" value="${reserveQueryDto.queryStartTimeStr}" style="width:150px;"/>
		              <span class="input-group-addon">-</span>
		              <input type="text" name="queryEndTime" class="form-control queryTime" placeholder="请选择截止日期" data-date-format="yyyy-mm-dd" value="${reserveQueryDto.queryEndTimeStr}" style="width:150px;"/>
		          </div>
	          </div>
			  <button type="submit" id="btn-query" class="btn btn-primary btn-primary">查询&nbsp;&nbsp;<i class="glyphicon glyphicon-search"></i></button>
			  <button type="submit" id="btn-export" class="btn btn-primary btn-success">导出excel</button>
			</form>
		</div>
	  
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
		
		<table class="table table-striped table-hover" style="border:1px solid #478DCD;">
			<tr class="table-title">
				<td width="5%">序号</td>
				<td width="8%">姓名</td>
				<td width="10%">手机号</td>
				<td width="15%">预约时间</td>
				<td width="15%">身份证号</td>
				<td width="10%">身份证照片</td>
				<td width="10%">操作</td>
			</tr>
			<c:forEach var="item" items="${page.content}" varStatus="status">
				<tr class="table-content">
					<td>${status.index+1}</td>
					<td><span style="font-weight:600">${item.name}</span></td>
					<td>${item.mobile}</td>
					<td>${item.reserveTimeStr}</td>
					<td>
						<c:if test="${item.idNumber == ''}">
							未填写
						</c:if>
						<c:if test="${item.idNumber != ''}">
							${item.idNumber}
						</c:if>
					
					</td>
					<td>
						<c:if test="${not item.hasPhoto}">
							未上传
						</c:if>
						<c:if test="${item.hasPhoto}">
							<a href="" class="view-photo" id="${item.id}"><i class="glyphicon glyphicon-search"></i>&nbsp;查看</a>
						</c:if>
					</td>
					<td>
						<a class="orange btn-delete" data-id="${item.id}"><i class="ace-icon fa fa-trash-o"></i>&nbsp;删除</a>
					</td>
				</tr>
			</c:forEach>
		</table>
		<span id="total" data-total="${total}"></span>
		<div style="background-color:#F5F5F5;height:60px;margin-top:-20px">
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
		
		<!-- Modal -->
		<div class="modal" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h4 class="modal-title">提示</h4>
		      </div>
		      <div class="modal-body">
		      	<div class="delete-tip">
		      		<span style="font-size:17px;margin-left:60px;">你确定要删除该条记录吗？</span>
		      	</div>
		      </div>
		      <div class="modal-footer">
		      	<form id="deleteForm">
			      	<input id="delete-id" name="id" type="hidden"/>
			      	<button class="btn btn-danger btn-delete-confirm" data-dismiss="modal">立即删除</button>
				    <button class="btn btn-default" data-dismiss="modal">取消</button>
			    </form>
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
    $('#pagination').pagination($('input[name="total"]').val(), {
        callback: function (index, jq) {
            $('#page').val(index);
            $("#searchForm").attr("action","admin");
            $("#searchForm").attr("method","GET");
            $('#searchForm').submit();
        }, 
        current_page: $('input[name="currentPage"]').val(),
        items_per_page: 10,
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
	
	$('.btn-delete').on('click',function(){
		var id = $(this).data('id');
		$('#delete-id').val(id);
        $('#deleteModal').modal();
	});
	
	$('.btn-delete-confirm').on('click',function(){	
		var id = $('#delete-id').val();
		$.ajax({
            type:"GET",
            url:"record/delete/" + id,
            success:function(data){
            	location.reload();
            }
         });
		return false;
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