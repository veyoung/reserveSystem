<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="feedback-container" >
<h4 class="header"><b></b></h4>
<div class="row">
    <div class="col-xs-12">
        <form class="form-horizontal col-xs-8 mod-orders-search" id="feedbackForm" action="" method="get">
        	<input type="hidden" id="page" name="page"/>
            <input type="hidden" name="totalPages" value="${page.totalPages}">
	        <input type="hidden" name="currentPage" value="${page.number}">
            <input type="hidden" id=context name="context" value="<% request.getContextPath(); %>">
            <div class="form-group">
                <label class="col-sm-3 control-label" for="time">起止日期：</label>
                <div id="time" class="col-sm-5">
                    <div class="input-group input-daterange col-sm-12">
                        <input type="text" id="startTime" name="queryStartTime" class="form-control" placeholder="请选择起始日期" data-date-format="yyyy-mm-dd" value="${feedbackQueryDto.queryStartTimeStr}"/>
                        <span class="input-group-addon">-</span>
                        <input type="text" id="endTime" name="queryEndTime" class="form-control" placeholder="请选择截止日期" data-date-format="yyyy-mm-dd" value="${feedbackQueryDto.queryEndTimeStr}"/>
                    </div>
                </div>
            </div>
            <div class="form-group">
               <label class="col-sm-3 control-label">反馈状态：</label>
	          	<div class="col-sm-6">
		            <div class="btn-group" data-toggle="buttons">
		              <label class="btn btn-white btn-default btn-sm <c:if test='${feedbackQueryDto.queryStatus eq null}'>active</c:if>" >
		                <input type="radio" name="queryStatus" value="" <c:if test='${feedbackQueryDto.queryStatus eq null}'>checked</c:if>>全部</input>
		              </label>
		              <label class="btn btn-white btn-default btn-sm <c:if test='${feedbackQueryDto.queryStatus eq 1}'>active</c:if>" >
		                <input type="radio" name="queryStatus" value="1" <c:if test='${feedbackQueryDto.queryStatus eq 1}'>checked</c:if> >待处理</input>
		              </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${feedbackQueryDto.queryStatus eq 2}'>active</c:if>" >
		                <input type="radio" name="queryStatus" value="2" <c:if test='${feedbackQueryDto.queryStatus eq 2}'>checked</c:if>>处理中</input>
		              </label>
		              <label class="btn btn-white btn-default btn-sm <c:if test='${feedbackQueryDto.queryStatus eq 3}'>active</c:if>" >
		                <input type="radio" name="queryStatus" value="3" <c:if test='${feedbackQueryDto.queryStatus eq 3}'>checked</c:if>>已处理</input>
		              </label>
		            </div>
          		</div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-3 col-sm-6">
                    <span><button type="submit" class="btn btn-sm btn-primary btn-query">查询 <i></i></button></span>
                </div>
            </div>
        </form>
    </div>
</div>
<div class="row">
    <div class="col-xs-12 dataTables_wrapper">
    	<span>共${page.totalElements}条记录</span>
        <table class="table table-hover table-striped table-bordered dataTable mod-search-orderlist">
            <thead>
                <tr>
                    <th class="col-1" width="3%">序号</th>
                    <th class="col-2" width=10%>反馈时间</th>
                    <th class="col-3" width="18%">问题描述</th>
                    <th class="col-4" width="10%">邮箱</th>
                    <th class="col-5" width="5%">手机</th>
                    <th class="col-6" width="5%">状态</th>
                    <th class="col-7" width="10%">备注</th>
                    <th class="col-8" width="3%">详情</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach items="${page.content}" var="feedback" varStatus="st">
                <tr>
                	<td class="index">
                        <div>
                           ${st.count} 
                        </div>
                    </td>
                    <td class="createTime">
                        <div>
                           <fmt:formatDate value="${feedback.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </div>
                    </td>
                    <td>
                        <div>
                           ${feedback.feedbackContent} 
                        </div>
                    </td>
                    <td>
                        <div>
                           ${feedback.feedbackUserEmail} 
                        </div>
                    </td>
                    <td>
                        <div>
                           ${feedback.feedbackUserMobile} 
                        </div>
                    </td>
                    <td>
                        <div>
	                        <c:if test="${feedback.status == 1}">
	                        	<span style="color:red">待处理</span>
	                        </c:if>
	                        <c:if test="${feedback.status == 2}">
	                        	<span style="color:blue">处理中</span>
	                        </c:if>
	                        <c:if test="${feedback.status == 3}">
	                        	<span>处理完成</span>
	                        </c:if>
                        </div>
                    </td>
                    <td>
                        <div>
                           ${feedback.operateContent} 
                        </div>
                    </td>
                    <td>
                        <div>
                           	<a data-toggle="modal" class="edit" data-target="#feedback-modal" style="cursor:pointer" data-id="${feedback.id}">详情</a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty page.content}">
                <tr>
                    <td colspan="8"><span class="empty-info">无反馈信息!</span></td>
                </tr>
            </c:if>
            </tbody>
        </table>
        <div class="row">
           <div class="col-xs-6">
               <div class="dataTables_info"></div>
           </div>
        	<c:if test="${not empty page.content}">
           		<div class="page-panel" id="page-panel"></div>
           </c:if>
        </div>
    </div>
</div>
<div class="row">
	<div class="modal fade" id="feedback-modal" tabindex="-1" role="dialog"  aria-labelledby="order-modalLabel" aria-hidden="true" data-backdrop="static">
	    <div class="modal-dialog">
	        <div class="modal-content" style="width: 100%;">
	            <div class="modal-header">
	                <button type="button" class="close modal-close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <div class="" id="order-modalLabel" style="font-size: 16px;color:#428bca;">
	                    <strong>详情</strong>
	                </div>
	            </div>
	            <div class="modal-body modal-detail">
	            <form class="form-horizontal" id="feedbackEditForm" method="post">
	            	<div class="form-group">
		                <label class="col-sm-3 control-label" for="time">反馈问题：</label>
		                <div id="time" class="col-sm-8">
		                    <div class="input-group input-daterange col-sm-12">
		                    	<input name="id" type="hidden" class="form-control" readonly="true"/>
		                        <textarea id ="description" cols ="50" rows = "3" readonly="true"></textarea>
		                    </div>
		                </div>
	            	</div>
	            	<div class="form-group">
		                <label class="col-sm-3 control-label" for="time">反馈人邮箱：</label>
		                <div id="time" class="col-sm-8">
		                    <div class="input-group input-daterange col-sm-12">
		                        <input name="email" type="text" class="form-control" readonly="true"/>
		                    </div>
		                </div>
	            	</div>
	            	<div class="form-group">
		                <label class="col-sm-3 control-label" for="time">反馈人手机：</label>
		                <div id="time" class="col-sm-8">
		                    <div class="input-group input-daterange col-sm-12">
		                        <input name="mobile" type="text" class="form-control" readonly="true"/>
		                    </div>
		                </div>
	            	</div>
	            	<div class="form-group">
		                <label class="col-sm-3 control-label" for="time">管理员备注：</label>
		                <div id="time" class="col-sm-8">
		                    <div class="input-group input-daterange col-sm-12">
		                        <textarea id="remark" name="operateContent" cols ="50" rows = "5"></textarea>
		                    </div>
		                </div>
	            	</div>
	            	<div class="form-group">
		                <label class="col-sm-3 control-label" for="time">状态：</label>
		                <div id="time" class="col-sm-5">
		                    <div class="input-group input-daterange col-sm-12">
		                        <select id="status" name="status" style="margin-top:5px;height:25px;width: 375px;">
		                        	<option value="1">待处理</option>
		                        	<option value="2">处理中</option>
		                        	<option value="3">处理完成</option>
		                        </select>
		                    </div>
		                </div>
	            	</div>
	            </form>
	            </div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-primary btn-close btn-save" data-dismiss="modal">保存</button>
	                <button type="button" class="btn btn-default btn-close" data-dismiss="modal">关闭</button>
	            </div>
	        </div>
	    </div>
	</div>
</div>
</div>
