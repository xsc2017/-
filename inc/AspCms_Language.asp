<%
dim err_01, err_02, err_03, err_04, err_05, err_06, err_07, err_08, err_09, err_10, err_11, err_12, err_13, err_14, err_15, err_16, err_17
dim channellistInfo(1),searchlistInfo(1),pageRunStr(2),topicpageInfo(0),newspageInfo(0)
dim str_01, str_02, str_03, str_04, str_05, str_06, str_07, str_08, str_09, str_10, str_11, str_12, str_13, str_14, str_15, str_16,str_17

if setting.Alias="cn" then	
	err_01="数据库连接错误"
	err_02="语言别名设置错误"
	err_03="执行SQL语句错误"
	err_04="st"&"ream对象实例创建失败"
	err_05="F"&"SO对象实例创建失败" 
	err_06="加载文件失败"
	err_07="数据列表未指定主键"
	err_08="数据列表未指定表"
	err_09="写入文件失败"	
	err_10="创建文件夹失败"
	err_11="删除文件夹失败"	
	err_12="删除文件失败"	
	err_13="文件夹不存在"
	err_14="移动文件夹失败"
	err_15="请设置默认语言"
	err_16="模板文件不存在"
	err_17="您当前所在用户组无查看权限！"
		
	str_01="首页"
	str_02="尾页"
	str_03="上一页"
	str_04="下一页"
	str_05="页次" 
	str_06="共"
	str_07="页"
	str_08="对不起，该分类无任何记录"
	str_09="对不起，关键字"	
	str_10=" 无任何记录"
	str_11="您当前所在用户组无查看权限！"	
	str_12=""	
	str_13=""
	str_14=""
	str_15=""
	str_16=""
	str_17="转到"
	
	newspageInfo(0)="<font color='red'> 对不起，无任何内容 </font>"
	channellistInfo(0)="<font color='red'> 对不起，该分类无记录任何记录 </font>":channellistInfo(1)="指定分类错误"
	searchlistInfo(0)="对不起，没有找到任何记录"
	pageRunStr(0)="页面执行时间: ":pageRunStr(1)="秒&nbsp;":pageRunStr(2)="次数据查询"
	
else
	err_01="Database Connection Error!"
	err_02="Language alias setting error!"
	err_03="Execute SQL statement error!"
	err_04="St"&"ream object instance creation failed!"
	err_05="F"&"SO object instance creation failed!" 
	err_06="Load file failed!"
	err_07="Data list the primary key is not specified!"
	err_08="Data list table is not specified!"
	err_09="Write to file failed!"	
	err_10="Failed to create the folder!"
	err_11="Failed to delete folder!"	
	err_12="Delete file failed!"	
	err_13="Folder does not exist!"
	err_14="Move Folder fails!"
	err_15="请设置默认语言"
	err_16="模板文件不存在"
	err_17="您当前所在用户组无查看权限！"
	
	
	str_01="Home page"
	str_02="Last page"
	str_03="Previous page"
	str_04="Next page"
	str_05="Page"
	str_06="Total"
	str_07="Page"
	str_08="Sorry, no records of the category"
	str_09="Sorry, the keyword "
	str_10="no record"
	
	newspageInfo(0)="<font color='red'> Sorry, no content! </font>"
	channellistInfo(0)="<font color='red'> Sorry, no content! </font>":channellistInfo(1)="Specifies the classification error!"
	searchlistInfo(0)="Sorry, did not find any records"
	pageRunStr(0)="Page execution time ":pageRunStr(1)=" seconds,&nbsp;":pageRunStr(2)=" Data Query!"

end if

%>