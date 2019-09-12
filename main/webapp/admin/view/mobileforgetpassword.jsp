<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>我的摩托车</title>
	<meta name="viewport" content="initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">

	<link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/??sm.min.css,sm-extend.min.css">
</head>
<body>
<%
	String redirect_url = request.getParameter("redirect_url");
%>
<div class="page-group">
	<!-- 你的html代码 -->
	<div class="page  page-current" id="motoinfopage">
		<header class="bar bar-nav">
			<h1 class="title">我的摩托车</h1>
		</header>
		<div class="content">
			<div class="list-block" style="margin: 0px">
				<ul>
					<!-- Text inputs -->
					<li>
						<div class="item-content">
							<div class="item-media"><i class="icon icon-form-name"></i></div>
							<div class="item-inner">
								<div class="item-title label">电子信箱</div>
								<div class="item-input">
									<input type="text" id="email" placeholder="请输入您的电子信箱">
								</div>
							</div>
						</div>
					</li>
				</ul>
			</div>
			<div class="content-block">
				<div class="row">
					<div class="col-100"><a href="javascript:forgetpassword();" class="button button-big button-fill button-danger">找回密码</a></div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
<script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/??sm.min.js,sm-extend.min.js' charset='utf-8'></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=gabz9kmdTmKfj9Si2mf3NmWMmsFTE9oy"></script>
<script>
	function setCookie(name,value)
	{
		var Days = 30;
		var exp = new Date();
		exp.setTime(exp.getTime() + Days*24*60*60*1000);
		document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
	}

	//读取cookies
	function getCookie(name)
	{
		var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");

		if(arr=document.cookie.match(reg))

			return unescape(arr[2]);
		else
			return null;
	}

	//删除cookies
	function delCookie(name)
	{
		var exp = new Date();
		exp.setTime(exp.getTime() - 1);
		var cval=getCookie(name);
		if(cval!=null)
			document.cookie= name + "="+cval+";expires="+exp.toGMTString();
	}
	$.init();
	function forgetpassword(){
		$.ajax({
			type:
					'POST',
			url:
					'../control/usermanager.jsp',
			// data to be added to query string:
			data:{
				action:'forgetpassword',
				email:$('#email')[0].value
			},
			// type of data we are expecting in return:
			dataType:
					'json',
			timeout: 3000,
			context:{redirect_url: '<%=redirect_url%>'},
			success:function(data){
				if(data.success){
					$.toast("密码已经发送到您的信箱！");
				}
				else{
					$.toast(data.message);
				}
			},
			error:function(data){
			}
		});
	}
</script>
</body>
</html>
