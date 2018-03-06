<%
Const runMode=0	'网站运行模式（0为动态，1为静态）
Const sitePath=""	'网站总目录 例如:/cms
Const Charset="utf-8"	'模板编码 例如:gb2312、utf-8
Const adminPath="admin_aspcms"	'网站后台总目录 例如:admin_aspcms
Const accessFilePath="data/#5Dp8Gh.asp"	'access数据库文件路径
Const dbType=0  '数据库类型（0为access；1为sqlserver）
Const databaseServer=""  'sqlserver数据库地址
Const databaseName=""  'sqlserver数据库名称
Const databaseUser=""  'sqlserver数据库账号
Const databasepwd=""  'sqlserver数据库密码
Const fileExt=".html"	'生成文件扩展名（htm,html,asp）	
Const upLoadPath="upLoad"	'上传文件目录
Const textFilter=""	'文字过滤
Const tablePrefix="AspCms_"	'数据库前缀
Const upFileSize=20000	'上传文件大小限制KB
Const upFileWay=1	'上传文件方式设置(1,无组件上传,)
Const htmlDir="a"	'文档HTML默认保存路径
Const htmlOnRoot=0  '是否生成静态到根目录

'开关类
Const siteMode=1	'网站状态（0为关闭，1为运行）
Const siteHelp="本网站因程序升级关闭中!"	'网站状态（0为关闭，1为运行）
Const admincode=1  '后台登录验证码（0为关闭，1开启）

Const switchWapStatus=1  '手机网页开关
Const switchSortDefend=0  '栏目保护开关
Const switchWapDebug=0  '手机版调试
Const wapDomain="" '手机版域名绑定

Const SwitchNavEn=0	'栏目英文名称（0为关闭，1为开启）
Const switchFaq=0	'留言开关（0为关闭，1为开启）
Const switchFaqStatus=1 '留言审核开关（0为不启用，1为启用）
Const switchComments=1	'评论开关（0为关闭，1为开启）
Const switchCommentsStatus=1	'评论审核是否启用（0为不启用，1为启用）
Const waterMark=0	'水印(0,1)
Const waterType=0	'水印类型(0为文字，1图片)
Const waterMarkFont="水印示例"	'水印文字
Const waterMarkPic="/upLoad/other/month_1310/201310231721103660.jpg"	'水印图片
Const markPicWidth=80
Const markPicHeight=25
Const markPicAlpha =0.5
Const waterMarkLocation="5"	'位置

'邮件设置
Const smtp_usermail=""	'邮件地址
Const smtp_user="admin"	'邮件账号 
Const smtp_password="123456"	'邮件密码 
Const smtp_server=""	'邮件服务器

'提醒功能
Const messageAlertsEmail=""	'邮件地址
Const messageReminded=1	'留言提醒
Const orderReminded=1	'订单提醒
Const commentReminded=1	'评论提醒
Const applyReminded=1	'应聘提醒
Const sortTypes="单篇,文章,产品,下载,招聘,相册,链接,视频"
Const dirtyStr="黑车<br>传销"

'在线客服
Const serviceStatus=1	'在线客服显示状态
Const serviceStyle=1	'样式
Const serviceLocation="left"	'显示位置
Const serviceQQ="技术支持|506232687 产品咨询|8887443" 'QQ
Const serviceEmail="234324324"	'邮箱
Const servicePhone="43244324324"	'电话
Const serviceWangWang="销售一号|123456 销售2号|8887443"	'旺旺
Const serviceWeiXin=""	'微信
Const serviceWeiBo="123456"	'新浪微博
Const serviceContact="/about/?19.html"	'联系方式链接
Const servicekfStatus=1	
Const servicekf=""	'
Const service53kfStatus=0	'53KF显示状态
Const service53kf=0	'53KF申请状态
Const service53kfaccount="" '53KF帐号
Const service53workid="" '53KF工号
Const service53kfpasswd="" '53KF密码
Const slidestyle=0	'幻灯片样式
Const slideImgs="/upLoad/slide/month_1401/201401251117508159.jpg, /upLoad/slide/month_1401/201401251118044616.jpg, /upLoad/slide/month_1401/201401251118078087.jpg,"	'图片地址
Const slideLinks="http://www.asp4cms.com, http://www.asp4cms.com, http://www.asp4cms.com,"	'链接地址
Const slideTexts="ASPCMS企业网站建站平台--幻灯片1, ASPCMS企业网站建站平台--幻灯片2, ASPCMS企业网站建站平台--幻灯片3,"	'文字说明
Const slideWidth="1001"	'宽
Const slideHeight="244"	'高
Const slideTextStatus=1	'文字说明开关
Const slideNum=3	'文字说明开关
Const slidestyleB=0	'幻灯片样式
Const slideImgsB="/upLoad/slide/month_1401/201401251117508159.jpg, /upLoad/slide/month_1401/201401251118044616.jpg, /upLoad/slide/month_1401/201401251118078087.jpg,"	'图片地址
Const slideLinksB=", ,,"	'链接地址
Const slideTextsB=", ,,"	'文字说明
Const slideWidthB="960"	'宽
Const slideHeightB="263"	'高
Const slideTextStatusB=0	'文字说明开关
Const slideNumB=3	'文字说明开关
Const slidestyleC=0	'幻灯片样式
Const slideImgsC=","	'图片地址
Const slideLinksC=","	'链接地址
Const slideTextsC=","	'文字说明
Const slideWidthC="202"	'宽
Const slideHeightC="202"	'高
Const slideTextStatusC=1	'文字说明开关
Const slideNumC=1	'文字说明开关
Const slidestyleD=4	'幻灯片样式
Const slideImgsD=","	'图片地址
Const slideLinksD=","	'链接地址
Const slideTextsD=","	'文字说明
Const slideWidthD="203"	'宽
Const slideHeightD="203"	'高
Const slideTextStatusD=1	'文字说明开关
Const slideNumD=1	'文字说明开关
Const GoogleAPIKey=""
Const GoogleMapLat=30.593086
Const GoogleMapLng=114.30536
Const CNZZUSER=""
Const dirtyStrToggle=1
Const Share=0
Const isSortEnName=1
Const isInstall=1
Const CNZZPASS=""

%>