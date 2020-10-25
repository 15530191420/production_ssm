<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<link href="js/kindeditor-4.1.10/themes/default/default.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="js/kindeditor-4.1.10/kindeditor-all-min.js"></script>
<script type="text/javascript" charset="utf-8" src="js/kindeditor-4.1.10/lang/zh_CN.js"></script>

<table class="easyui-datagrid" id="branchList" title="机构列表" data-options="singleSelect:false,collapsible:true,
	pagination:true,rownumbers:true,url:'branch/list',method:'get',pageSize:10,fitColumns:true,toolbar:toolbar_branch">
    <thead>
        <tr>
			<th data-options="field:'ck',checkbox:true"></th>
			<th data-options="field:'branchId',align:'center',width:100">机构编号</th>
			<th data-options="field:'name',align:'center',width:100">机构编号</th>
			<th data-options="field:'short_name',align:'center',width:100">机构编号</th>
    </thead>
</table> 

<div  id="toolbar_branch" style=" height: 22px; padding: 3px 11px; background: #fafafa;">  
	
	<c:forEach items="${sessionScope.sysPermissionList}" var="per" >
		<c:if test="${per=='branch:add' }" >
		    <div style="float: left;">  
		        <a href="#" class="easyui-linkbutton" plain="true" icon="icon-add" onclick="branch_add()">新增</a>  
		    </div>  
		</c:if>
		<c:if test="${per=='branch:edit' }" >
		    <div style="float: left;">  
		        <a href="#" class="easyui-linkbutton" plain="true" icon="icon-edit" onclick="branch_edit()">编辑</a>  
		    </div>  
		</c:if>
		<c:if test="${per=='branch:delete' }" >
		    <div style="float: left;">  
		        <a href="#" class="easyui-linkbutton" plain="true" icon="icon-cancel" onclick="branch_delete()">删除</a>  
		    </div>  
		</c:if>
	</c:forEach>
	
	<div class="datagrid-btn-separator"></div>  
	
	<div style="float: left;">  
		<a href="#" class="easyui-linkbutton" plain="true" icon="icon-reload" onclick="branch_reload()">刷新</a>  
	</div>  
	
    <div id="search_branch" style="float: right;">
        <input id="search_text_branch" class="easyui-searchbox"  
            data-options="searcher:doSearch_branch,prompt:'请输入...',menu:'#menu_branch'"  
            style="width:250px;vertical-align: middle;">
        </input>
        <div id="menu_branch" style="width:120px"> 
			<div data-options="name:'branchId'">机构编号</div> 
			<div data-options="name:'branchCustom'">机构名称</div>
			<div data-options="name:'branchProduct'">机构名称</div> 
		</div>     
    </div>  
</div>  

<div id="branchEditWindow" class="easyui-window" title="编辑机构" data-options="modal:true,closed:true,resizable:true,
	iconCls:'icon-save',href:'branch/edit'" style="width:65%;height:80%;padding:10px;">
</div>
<div id="branchAddWindow" class="easyui-window" title="添加机构" data-options="modal:true,closed:true,resizable:true,
	iconCls:'icon-save',href:'branch/add'" style="width:65%;height:80%;padding:10px;">
</div>

<div id="branchCustomInfo" class="easyui-dialog" title="客户信息" data-options="modal:true,closed:true,resizable:true,
	iconCls:'icon-save'" style="width:65%;height:80%;padding:10px;">
	<form id="branchCustomEditForm" method="post">
		<input type="hidden" name="customId"/>
	    <table cellpadding="5">
	        <tr>
	            <td>客户名称:</td>
	            <td><input class="easyui-textbox" type="text" name="customName" data-options="required:true"/></td>
	        </tr>
	        <tr>
	            <td>客户全称:</td>
	            <td><input class="easyui-textbox" type="text" name="fullName" style="width: 280px;"/></td>
	        </tr>
	        <tr>
	            <td>地址:</td>
	            <td><input class="easyui-textbox" type="text" name="address" style="width: 280px;"/></td>
	        </tr>
	        <tr>
	            <td>传真:</td>
	            <td><input class="easyui-textbox" type="text" name="fax"/></td>
	        </tr>
	        <tr>
	            <td>邮箱:</td>
	            <td><input class="easyui-textbox" type="text" name="email"/></td>
	        </tr>
	        <tr>
	            <td>经理姓名:</td>
	            <td><input class="easyui-textbox" type="text" name="ownerName"/></td>
	        </tr>
	        <tr>
	            <td>联系电话:</td>
	            <td><input class="easyui-textbox" type="text" name="ownerTel"/></td>
	        </tr>
	        <tr>
	            <td>客户状态:</td>
	            <td>
		            <select class="easyui-combobox" name="status" style="width:200px;" data-options="width:150">
						<option value="1">有效客户</option>
						<option value="2">无效客户</option>
					</select>
				</td>
	        </tr>
	        <tr>
	            <td>备注:</td>
	            <td><textarea style="width:800px;height:300px;visibility:hidden;" name="note"></textarea></td>
	        </tr>
	    </table>
	</form>
	<div style="padding:5px">
	    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitBranchCustomEditForm()">提交</a>
	</div>
</div>
<div id="branchProductInfo" class="easyui-dialog" title="产品信息" data-options="modal:true,closed:true,resizable:true,
		iconCls:'icon-save'" style="width:65%;height:80%;padding:10px;">
	<form id="branchProductEditForm" method="post">
		<input type="hidden" name="productId"/>
	    <table cellpadding="5">
	        <tr>
	            <td>产品名称:</td>
	            <td><input class="easyui-textbox" type="text" name="productName" data-options="required:true"/></td>
	        </tr>
	        <tr>
	            <td>产品种类:</td>
	            <td><input class="easyui-textbox" type="text" name="productType" data-options="required:true"/></td>
	        </tr>
	        <tr>
	            <td>产品状态:</td>
	            <td>
		            <select id="cc" class="easyui-combobox" name="status" data-options="required:true,width:150">
						<option value="1">有效产品</option>
						<option value="2">停产</option>
					</select>
				</td>
	        </tr>
	        <tr>
	            <td>相关图片:</td>
	            <td>
	            <div style="padding-top: 12px"><span id="branchProductPicSpan"></span></div>
	                 <input type="hidden" class="easyui-linkbutton branchProductPic" name="image"/>
	            </td>
	        </tr>
	        <tr>
	            <td>产品介绍:</td>
	            <td><textarea style="width:800px;height:300px;visibility:hidden;" name="note"></textarea></td>
	        </tr>
	    </table>
	</form>
	<div style="padding:5px">
	    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitBranchProductEditForm()">提交</a>
	</div>
</div>
<div id="branchNoteDialog" class="easyui-dialog" title="机构要求" data-options="modal:true,closed:true,resizable:true,
		iconCls:'icon-save'" style="width:55%;height:65%;padding:10px">
	<form id="branchNoteForm" class="itemForm" method="post">
		<input type="hidden" name="branchId"/>
	    <table cellpadding="5" >
	        <tr>
	            <td>备注:</td>
	            <td><textarea style="width:800px;height:450px;visibility:hidden;" name="note"></textarea></td>
	        </tr>
	    </table>
	</form>
	<div style="padding:5px">
	    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="updateBranchNote()">保存</a>
	</div>
</div>
<script>
function doSearch_branch(value,name){ //用户输入用户名,点击搜素,触发此函数  
	if(value == null || value == ''){
		
		$("#branchList").datagrid({
	        title:'机构列表', singleSelect:false, collapsible:true, pagination:true, rownumbers:true, method:'get',
			nowrap:true, toolbar:"toolbar_branch", url:'branch/list', method:'get', loadMsg:'数据加载中......',
			fitColumns:true,//允许表格自动缩放,以适应父容器
	        columns : [ [ 
				{field : 'ck', checkbox:true },
				{field : 'branchId', width : 100, align:'center', title : '机构编号'},
				{field : 'custom', width : 100, align : 'center', title : '订购客户', formatter:formatCustom},
				{field : 'product', width : 100, align : 'center', title : '订购产品', formatter:formatProduct},
				{field : 'quantity', width : 100, title : '订购数量', align:'center'},
				{field : 'unitPrice', width : 70, title : '税前单价', align:'center'},
				{field : 'unit', width : 70, title : '单位', align:'center'},
				{field : 'status', width : 60, title : '状态', align:'center', formatter:TAOTAO.formatBranchStatus},
				{field : 'branchDate', width : 130, title : '订购日期', align:'center', formatter:TAOTAO.formatDateTime},
				{field : 'requestDate', width : 130, title : '要求日期', align:'center',
					formatter:TAOTAO.formatDateTime},
				{field : 'note', width : 100, title : '机构要求', align:'center', formatter:formatBranchNote},
				{field : 'image', width : 100, title : '相关图片', align:'center', formatter:formatImg},
				{field : 'file',  width : 100, title : '机构附件', align:'center', formatter:formatFile}
	        ] ],  
	    });
	}else{
		$("#branchList").datagrid({  
	        title:'机构列表', singleSelect:false, collapsible:true, pagination:true, rownumbers:true, method:'get',
			nowrap:true, toolbar:"toolbar_branch", url:'branch/search_branch_by_'+name+'?searchValue='+value,
			loadMsg:'数据加载中......', fitColumns:true,//允许表格自动缩放,以适应父容器
	        columns : [ [ 
	             	{field : 'ck', checkbox:true }, 
	             	{field : 'branchId', width : 100, title : '机构编号', align:'center'},
	             	{field : 'custom', width : 100, align : 'center', title : '订购客户', formatter:formatCustom},
	             	{field : 'product', width : 100, title : '订购产品', formatter:formatProduct}, 
	             	{field : 'quantity', width : 100, title : '订购数量', align:'center'}, 
	             	{field : 'unitPrice', width : 70, title : '税前单价', align:'center'}, 
	            	{field : 'unit', width : 70, title : '单位', align:'center'}, 
	             	{field : 'status', width : 60, title : '状态', align:'center', formatter:TAOTAO.formatBranchStatus}, 
	             	{field : 'branchDate', width : 130, title : '订购日期', align:'center',
						formatter:TAOTAO.formatDateTime},
	             	{field : 'requestDate', width : 130, title : '要求日期', align:'center',
						formatter:TAOTAO.formatDateTime},
	             	{field : 'note', width : 100, title : '机构要求', align:'center', formatter:formatBranchNote}, 
	             	{field : 'image', width : 100, title : '相关图片', align:'center', formatter:formatImg}, 
	             	{field : 'file',  width : 100, title : '机构附件', align:'center', formatter:formatFile}
	        ] ],  
	    });
	}
}
	var branchNoteEditor ;
	
	var branchProductEditor;
	
	var branchCustomEditor;
	
	//格式化客户信息
	function formatCustom(value, row, index){ 
		if(value !=null && value != ''){
			var row = onBranchClickRow(index); 
			return "<a href=javascript:openBranchCustom("+index+")>"+value.customName+"</a>";
		}else{
			return "无";
		}
	};  
	
	//格式化产品信息
	function  formatProduct(value, row, index){ 
		if(value !=null && value != ''){
			return "<a href=javascript:openBranchProduct("+index+")>"+value.productName+"</a>";
		}else{
			return "无";
		}
	};
	
	//格式化机构要求
	function formatBranchNote(value, row, index){ 
		if(value !=null && value != ''){
			return "<a href=javascript:openBranchNote("+index+")>"+"机构要求"+"</a>";
		}else{
			return "无";
		}
	}

	//根据index拿到该行值
	function onBranchClickRow(index) {
		var rows = $('#branchList').datagrid('getRows');
		return rows[index];
		
	}
	
	//打开客户信息对话框
	function  openBranchCustom(index){ 
		var row = onBranchClickRow(index);
		$("#branchCustomInfo").dialog({
    		onOpen :function(){
    			$.get("custom/get/"+row.custom.customId,'',function(data){
    				branchCustomEditor = TAOTAO.createEditor("#branchCustomEditForm [name=note]");	
		    		//回显数据
		    		$("#branchCustomEditForm").form("load", data);
		    		branchCustomEditor.html(data.note);
		    		
		    		TAOTAO.init({
        				"pics" : data.image,
        			});
    	    	});
    		},
			onBeforeClose: function (event, ui) {
				// 关闭Dialog前移除编辑器
			   	KindEditor.remove("#branchCustomEditForm [name=note]");
			}
    	}).dialog("open");
	};
	
	function submitBranchCustomEditForm(){
		$.get("custom/edit_judge",'',function(data){
    		if(data.msg != null){
    			$.messager.alert('提示', data.msg);
    		}else{
    			if(!$('#branchCustomEditForm').form('validate')){
    				$.messager.alert('提示','表单还未填写完成!');
    				return ;
    			}
    			//同步文本框中的备注
    			branchCustomEditor.sync();
    			$.post("custom/update_all",$("#branchCustomEditForm").serialize(), function(data){
    				if(data.status == 200){
    					$.messager.alert('提示','修改客户成功!','info',function(){
    						$("#branchCustomInfo").dialog("close");
    						$("#branchList").datagrid("reload");
    					});
    				}else{
    					$.messager.alert('提示',data.msg);
    				}
    			});
    		}
    	});
	}
	
	//打开产品信息对话框
	function  openBranchProduct(index){ 
		var row = onBranchClickRow(index);
		$("#branchProductInfo").dialog({
    		onOpen :function(){
    			$.get("product/get/"+row.product.productId,'',function(data){
    				
    				branchProductEditor = TAOTAO.createEditor("#branchProductEditForm [name=note]");	
		    		//回显数据
		    		$("#branchProductEditForm").form("load", data);
		    		branchProductEditor.html(data.note);
		    		
		    		//加载图片
 	        		initBranchProductPic({
           				"pics" : data.image,
           			});
    	    	});
    		},
			onBeforeClose: function (event, ui) {
				// 关闭Dialog前移除编辑器
			   	KindEditor.remove("#branchProductEditForm [name=note]");
			   	clearManuSpan();
			}
    	}).dialog("open");
	};
	
	// 加载图片
    function initBranchProductPic(data){
    	$(".branchProductPic").each(function(i,e){
    		var _ele = $(e);
    		_ele.siblings("div.pics").remove();
    		_ele.after('\
    			<div class="pics">\
        			<ul></ul>\
        		</div>');
    		// 回显图片
    		var j = false;
        	if(data && data.pics){
        		var imgs = data.pics.split(",");
        		for(var i in imgs){
        			if($.trim(imgs[i]).length > 0){
        				_ele.siblings(".pics").find("ul").append("<li><a id='img"+i+"' href='"+imgs[i]+"' target='_blank'>" +
        						"<img src='"+imgs[i]+"' width='80' height='50' /></a> ");
        				j = true;
        			}
        		}
        	}
        	if(!j){
    			$("#branchProductPic").html("<span style='font-size: 12px;font-family: Microsoft YaHei;'>无</span>");
    		}
    	});
    }
	
    function clearManuSpan(){
		$("#branchProductPic").html('');
	}
    
	function submitBranchProductEditForm(){
		$.get("product/edit_judge",'',function(data){
    		if(data.msg != null){
    			$.messager.alert('提示', data.msg);
    		}else{
    			if(!$('#branchProductEditForm').form('validate')){
    				$.messager.alert('提示','表单还未填写完成!');
    				return ;
    			}
    			branchProductEditor.sync();
    			
    			$.post("product/update_all",$("#branchProductEditForm").serialize(), function(data){
    				if(data.status == 200){
    					$.messager.alert('提示','修改产品成功!','info',function(){
    						$("#branchProductInfo").dialog("close");
    						$("#branchList").datagrid("reload");
    					});
    				}else{
    					$.messager.alert('提示',data.msg);
    				}
    			});
    		}
    	});
	}
	
	//打开机构要求富文本编辑器对话框
	function  openBranchNote(index){ 
		var row = onBranchClickRow(index);
		$("#branchNoteDialog").dialog({
    		onOpen :function(){
    			$("#branchNoteForm [name=branchId]").val(row.branchId);
    			branchNoteEditor = TAOTAO.createEditor("#branchNoteForm [name=note]");
    			branchNoteEditor.html(row.note);
    		},
		
			onBeforeClose: function (event, ui) {
				// 关闭Dialog前移除编辑器
			   	KindEditor.remove("#branchNoteForm [name=note]");
			}
    	}).dialog("open");
		
	};
	
	//更新机构要求
	function updateBranchNote(){
		$.get("branch/edit_judge",'',function(data){
    		if(data.msg != null){
    			$.messager.alert('提示', data.msg);
    		}else{
    			branchNoteEditor.sync();
    			$.post("branch/update_note",$("#branchNoteForm").serialize(), function(data){
    				if(data.status == 200){
    					$("#branchNoteDialog").dialog("close");
    					$("#branchList").datagrid("reload");
    					$.messager.alert("操作提示", "更新机构要求成功！");
    				}else{
    					$.messager.alert("操作提示", "更新机构要求失败！");
    				}
    			});
    		}
    	});
	}
	
    function getBranchSelectionsIds(){
    	var branchList = $("#branchList");
    	var sels = branchList.datagrid("getSelections");
    	var ids = [];
    	for(var i in sels){
    		ids.push(sels[i].branchId);
    	}
    	ids = ids.join(","); 
    	
    	return ids;
    }
    
    function branch_add(){
    	$.get("branch/add_judge",'',function(data){
       		if(data.msg != null){
       			$.messager.alert('提示', data.msg);
       		}else{
       			$("#branchAddWindow").window("open");
       		}
       	});
    }
    
    function branch_edit(){
    	$.get("branch/edit_judge",'',function(data){
       		if(data.msg != null){
       			$.messager.alert('提示', data.msg);
       		}else{
       			var ids = getBranchSelectionsIds();
               	
               	if(ids.length == 0){
               		$.messager.alert('提示','必须选择一个机构才能编辑!');
               		return ;
               	}
               	if(ids.indexOf(',') > 0){
               		$.messager.alert('提示','只能选择一个机构!');
               		return ;
               	}
               	
               	$("#branchEditWindow").window({
               		onLoad :function(){
               			//回显数据
               			var data = $("#branchList").datagrid("getSelections")[0];
               			data.customId = data.custom.customId; 
               			data.productId = data.product.productId; 
               			data.branchDate = TAOTAO.formatDateTime(data.branchDate);
               			data.requestDate = TAOTAO.formatDateTime(data.requestDate);
               			$("#branchEditForm").form("load", data);
               			branchEditEditor.html(data.note);
               			
               			TAOTAO.init({
               				"pics" : data.image,
               			});
               			
               			//加载文件上传插件
               			initBranchEditFileUpload();
               			//加载上传过的文件
               			initUploadedFile();
               		}
               	}).window("open");
       		}
       	});
    }
    
    function branch_delete(){
    	$.get("branch/delete_judge",'',function(data){
      		if(data.msg != null){
      			$.messager.alert('提示', data.msg);
      		}else{
      			var ids = getBranchSelectionsIds();
              	if(ids.length == 0){
              		$.messager.alert('提示','未选中机构!');
              		return ;
              	}
              	$.messager.confirm('确认','确定删除ID为 '+ids+' 的机构吗？',function(r){
              	    if (r){
              	    	var params = {"ids":ids};
                      	$.post("branch/delete_batch",params, function(data){
                  			if(data.status == 200){
                  				$.messager.alert('提示','删除机构成功!',undefined,function(){
                  					$("#branchList").datagrid("reload");
                  				});
                  			}
                  		});
              	    }
              	});
      		}
      	});
    }
    
    function branch_reload(){
    	$("#branchList").datagrid("reload");
    }
</script>
</script>