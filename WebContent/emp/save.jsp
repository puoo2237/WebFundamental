<%@page import="kr.co.acorn.dao.DeptDao"%>
<%@page import="kr.co.acorn.dto.DeptDto"%>
<%@ page pageEncoding = "utf-8" %>
<%
	request.setCharacterEncoding("utf-8"); // 한글이 깨지는 것을 방지
	int no = Integer.parseInt(request.getParameter("no"));
	String name = request.getParameter("name");
	String loc = request.getParameter("loc");
	
	DeptDto dto = new DeptDto(no, name, loc);
	DeptDao dao = DeptDao.getInstance();
	boolean isSuccess = dao.insert(dto);
	
	if(isSuccess){
%>
<script>
	alert('부서가 등록되었습니다.');
	location.href="list.jsp?page=1";
</script>
<%}else{ %>
<script>
	alert('DB Error');
	history.back(-1);
</script>

<%} %>
