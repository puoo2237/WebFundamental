<%@ page pageEncoding="utf-8" %>
<%@ include file="../inc/header.jsp" %>  
<%
	if(memberDto != null){
		response.sendRedirect("/index.jsp");
		return;
	}
%>
  <!-- breadcrumb start-->
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="/index.jsp">Home</a></li>
      <li class="breadcrumb-item active" aria-current="page">회원관리</li>
    </ol>
  </nav>
  <!-- breadcrumb end-->
  <%
  	int cPage = 0;
	String tempPage = request.getParameter("page");
	if(tempPage == null || tempPage.length()==0){
		cPage = 1;
	}
	try{
		cPage = Integer.parseInt(tempPage);
	}catch(NumberFormatException e){
		cPage = 1;
	}
  %>
  <!-- main start-->
  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <h3>
		  로그인
		</h3>
		<form name="f" method="post" action="check_login.jsp">
		  
		  <div class="form-group row">
		    <label for="name" class="col-sm-2 col-form-label">이메일</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="email" name="email">
		      <div id="nameMessage"></div>
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="password" class="col-sm-2 col-form-label">비밀번호</label>
		    <div class="col-sm-10">
		      <input type="password" class="form-control" id="password" name="password">
		      <div id="passwordMessage"></div>
		    </div>
		  </div>
		</form>
		<div class="text-right">
			<button type="button" id="loginMember" class="btn btn-outline-success">로그인</button>
        </div>
      </div>
    </div>
  </div>
  <!-- main end-->
  <%@ include file="../inc/footer.jsp" %> 
  
  <script>
  $(function(){
	  $("#email").focus();
	  $("#loginMember").click(function(){
		  //자바스크립트 유효성 검사
		  if(("#email").val().length==0){
			  $("#email").addClass("is-invalid");
			  $("#emailMessage").html("<span class='text-danger'>이메일을 입력하세요.</span>");
			  $("#email").focus();
			  return;
		  }
		  if($("#password").val().length==0){
			  $("#password").addClass("is-invalid");
			  $("#passwordMessage").html("<span class='text-danger'>비밀번호를 입력하세요</span>");
			  $("#password").focus();
			  return;
		  }
		  f.submit();
	  });
	  
	  $("#email").keyup(function(){
		  $("#email").removeClass("is-invalid");
		  $("#emailMessage").html('');
		  
	  });
	  
	  $("#password").keyup(function(){
		  $("#password").removeClass("is-invalid");
		  $("#passwordMessage").html('');
	  });
	  
  });
  </script>
  
  
  
 
 
 
 
 
 
 
  
  