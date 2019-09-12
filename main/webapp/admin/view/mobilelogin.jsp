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
								<div class="item-title label">账号</div>
								<div class="item-input">
									<input type="text" id="loginname" placeholder="请输入您的账号">
								</div>
							</div>
						</div>
					</li>
					<li>
						<div class="item-content">
							<div class="item-media"><i class="icon icon-form-password"></i></div>
							<div class="item-inner">
								<div class="item-title label">密码</div>
								<div class="item-input">
									<input type="password" id="password" placeholder="请输入您的密码" class="">
								</div>
							</div>
						</div>
					</li>
					<li>
						<div class="item-content">
							<div class="item-media"><i class="icon icon-form-toggle"></i></div>
							<div class="item-inner">
								<div class="item-title label">记住密码</div>
								<div class="item-input">
									<label class="label-switch">
										<input id="rememberme" type="checkbox">
										<div class="checkbox"></div>
									</label>
								</div>
							</div>
						</div>
					</li>
				</ul>
			</div>
			<div class="content-block">
				<div class="row">
					<div class="col-50"><a href="/admin/admin/view/mobileforgetpassword.jsp" class="button button-big button-fill button-danger">忘记密码</a></div>
					<div class="col-50"><a href="javascript:login();" class="button button-big button-fill button-success">登录</a></div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
<script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.cookie.min.js' charset='utf-8'></script>
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
	$('#rememberme')[0].checked = getCookie('rememberme') == "true";
	$('#loginname')[0].value = getCookie('loginname');
	$('#password')[0].value = getCookie('password');
	$.init();
	function login(){
		$.ajax({
			type:
					'POST',
			url:
					'../control/usermanager.jsp',
			// data to be added to query string:
			data:{
				action:'login',
				password:$('#password')[0].value,
				loginname:$('#loginname')[0].value,
				redirect_url: '<%=redirect_url%>'
			},
			// type of data we are expecting in return:
			dataType:
					'json',
			timeout: 3000,
			context:{redirect_url: '<%=redirect_url%>'},
			success:function(data){
				if(data.success){
					location.href=this.redirect_url+"?token=" + data.token;
					if($('#rememberme')[0].checked){
						setCookie('loginname', $('#loginname')[0].value, { expires: 999999 });
						setCookie('password', $('#password')[0].value, { expires: 999999 });
					}
					else{
						delCookie('loginname', $('#loginname')[0].value, { expires: 999999 });
						delCookie('password', $('#password')[0].value, { expires: 999999 });
					}
					setCookie('rememberme', $('#rememberme')[0].checked);
				}
				else{
					$.toast("用户名或密码错误！");
				}
			},
			error:function(data){
				if(data.success){
					location.href=this.redirect_url+"?token=" + data.token;
				}
				else{
					$.toast("提示","用户名或密码错误！");
				}
			}
		});
	}
</script>
</body>
</html>
