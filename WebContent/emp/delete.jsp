<%@page import="kr.co.acorn.dao.DeptDao"%>
<%@page import="kr.co.acorn.dto.DeptDto"%>
<%@ page pageEncoding = "utf-8" %>

<%
	request.setCharacterEncoding("utf-8"); // 한글이 깨지는 것을 방지
	int no = Integer.parseInt(request.getParameter("no"));
	String tempPage = request.getParameter("page");
	
	DeptDao dao = DeptDao.getInstance();
	boolean isSuccess = dao.delete(no);
	if(isSuccess){
%>
<script>
	alert('부서가 삭제되었습니다.');
	location.href="list.jsp?page=<%=tempPage%>";
</script>
<%}else{ %>
<script>
	alert('DB Error');
	history.back(-1);
</script>

<%} %>