<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.acorn.dao.DeptDao"%>
<%@page import="kr.co.acorn.dto.DeptDto"%>
<%@ page pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
	<%
		int len = 3;
		int pageLength = 2;

		int start = 0;
		int totalRows = 0;
		int totalPage = 0;
		int startPage = 0;
		int endPage = 0;
		int pageNum = 0;
		int cPage = 0;
		
		String tempPage = request.getParameter("page");

		if(tempPage == null || tempPage.length() == 0){
			cPage = 1;
		}
		
		try{
			cPage = Integer.parseInt(tempPage);
		}catch(NumberFormatException e){
			cPage = 1;
		}

		// An = a1 + (n - 1)*d
		DeptDao dao = DeptDao.getInstance();
		totalRows = dao.getTotalRows();	
		totalPage = totalRows % len  == 0? totalRows/len : totalRows/len + 1;
		if(totalPage == 0){
			totalPage = 1;
		}
		if(cPage > totalPage){
			response.sendRedirect("list.jsp?page=1");
			return;
		}
		start = (cPage - 1)*len;
		pageNum = (totalRows) - (cPage - 1)*len;
		ArrayList<DeptDto> list = dao.select(start, len);
		
		/*
			totalRows = 132;
			len = 5;
			pageLength = 10;
			  cPage			startPage 	    endPage
				1 				 1			  10		
			   14 				11		      20	
			   22 				21			  27		
			  
			 => startPage = 1 + (currentBlock - 1)* pageLength
			 => endPage = currentBlock*pageLength
			 => currentBlock?
		*/
		
		int currentBlock = cPage % pageLength == 0 ? (cPage/pageLength) : (cPage/pageLength + 1);
		int totalBlock = totalPage % pageLength == 0 ? (totalPage/pageLength) : (totalPage/pageLength + 1);
		startPage = 1 + (currentBlock - 1)* pageLength;
		endPage = currentBlock*pageLength;
		if(currentBlock == totalBlock){
			endPage = totalPage;
		}
		
		
	%>

<!--breadcrumb start-->
<nav aria-label="breadcrumb">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="/index.jsp">Home</a></li>
		<li class="breadcrumb-item active" aria-current="page">부서관리</li>
	</ol>
</nav>
<!--breadcrumb end-->

<!--main start-->
<div class="container">
	<div class="row">
		<div class="col-lg-12">
		
			<!-- table -->
			<h3>부서리스트(<%=totalRows %>)</h3>
			<div class="table-responsive-lg">
			<table class="table table-hover">
				
				<colgroup>
					<col width="10%" />
					<col width="20%" />
					<col width="60%" />
					<col width="20%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col">부서번호</th>
						<th scope="col">부서이름</th>
						<th scope="col">부서위치</th>
					</tr>
				</thead>
				<tbody>
				<%
				if(list.size() != 0){
				%>
				<% for(DeptDto dto:list){ %>
					<tr>
						<td><%=pageNum-- %></td>
						<td><a href = "view.jsp?page=<%=cPage%>&no=<%=dto.getNo()%>"><%=dto.getNo() %></a></td>
						<td><%=dto.getName()%></td>
						<td><%=dto.getLoc() %></td>
					</tr>
					<%} %>
					<%}else{ %>
					<tr>
						<td colspan = "3">데이터가 존재하지 않습니다.</td>
					</tr>
					<%} %>
				</tbody>
			</table>
			</div>

			<!-- pagination -->
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
					<% if(currentBlock == 1){ %>
					<li class="page-item disabled">
					<a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
					</li>
					<%}else{ %>
					<li class="page-item">
					<a class="page-link" href=list.jsp?page=<%=startPage-1 %>>Previous</a>
					</li>
					<%} %>
										
					
					<%for(int i = startPage; i <= endPage; i++){ %>
					<li class="page-item <%if(cPage == i){ %>active<%} %>"><a class="page-link" href=list.jsp?page=<%=i %>><%=i %></a>
					</li>
					<%} %>
					
					
					<%if(currentBlock == totalBlock){ %>
					<li class="page-item disabled">
					<a class="page-link" href="#" tabindex="-1" aria-disabled="true">Next</a>
					</li>
					<%}else{ %>
					<li class="page-item">
					<a class="page-link" href=list.jsp?page=<%=endPage+1 %>>Next</a>
					<%} %>
					</li>
				</ul>
			</nav>

			<!-- bottons -->
			<div class="text-right">
				<a href="write.jsp?page=<%=cPage %>" class="btn btn-outline-secondary">부서등록</a>
			</div>


		</div>
	</div>
</div>
<!--main end-->

<%@ include file="../inc/footer.jsp"%>