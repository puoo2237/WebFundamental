<%@ page pageEncoding = "utf-8" %>

<%
	/*
	HttpSession 객체를 종료하는 방법
	1. 브라우저를 종료했을 경우
	2. 해당페이지의 시간이 세션 만료시간을 경과했을 경우
	3. invalidate() 매서드를 호출하는 경우
	*/
	// session.removeAttribute("member"); // 정보만 지우고 세션 객체를 남기고 싶을 때 
	session.invalidate(); // 정보와 세션객체 모두 지우고 싶을 때
	response.sendRedirect("/index.jsp");


%>