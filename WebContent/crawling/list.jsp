<%@page import="java.util.Locale"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="java.io.IOException"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.Jsoup"%>
<%@ page pageEncoding = "utf-8" %>
<%@ include file = "../inc/header.jsp" %>
<%
	int startDate = 0;
	int endDate = 0;
	String typeCoin = null;
	Calendar calendar = new GregorianCalendar(Locale.KOREA);
	int year = calendar.get(Calendar.YEAR);
%>	
		
<!--breadcrumb start-->
<nav aria-label="breadcrumb">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="#">Home</a></li>
      <li class="breadcrumb-item active" aria-current="page">Library</li>
    </ol>
  </nav>    
<!--breadcrumb end-->

<!--main start-->
<div class = "container">
  <div class = "row">
    <div class = "col-lg-12">
    
			<h3>Crawling</h3>
				<form name="f" method="post" action="list.jsp">
		  <div class="form-group row">
		    <label for="no" class="col-sm-3 col-form-label">코인선택</label>
		    <div class="form-group col-sm-9">
		      <select id="coin" name="coin" class="form-control">
		        <option selected>Coin...</option>
		        <option value="bitcoin" selected>비트코인</option>
		        <option value="ethereum" >이더리움</option>
		        <option value="xrp" >리플</option>
		        <option value="bitcoin-cash" >비트코인캐쉬</option>
		        <option value="litecoin" >라이트코인</option>
		      </select>
		    </div>
		    
		  </div>
		  <div class="form-group row">
		    <label for="no" class="col-sm-3 col-form-label">시작날짜</label>
		    <div class="form-group col-sm-3">
		      <select id="startYear" name="startYear" class="form-control">
		        <option selected>Year...</option>
		         <%for(int i = 2010; i <= year; i++){ %>
		        <option value="<%=i %>" ><%=i %></option>
		        <%} %>
		        

		      </select>
		    </div>
		    <div class="form-group col-sm-3">
		      <select id="startMonth" name="startMonth" class="form-control">
		        <option selected>Month...</option>
               <%for(int i = 1; i <= 12; i++){ %>
		        <option value="<%=i %>" ><%=i %></option>
		        <%} %>
	
		        
		      </select>
		    </div>
		    <div class="form-group col-sm-3">
		      <select id="startDay" name="startDay"  class="form-control">
		        <option selected>Day...</option>
               <%for(int i = 1; i <= 31; i++){ %>
		        <option value="<%=i %>" ><%=i %></option>
		        <%} %>      </select>
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="endYear" class="col-sm-3 col-form-label">끝날짜</label>
		    <div class="form-group col-sm-3">
		      <select id="endYear" name="endYear" class="form-control">
		      	<option selected>Year...</option>
		        <%for(int i = 2010; i <= year; i++){ %>
		        <option value="<%=i %>" ><%=i %></option>
		        <%} %>
		      </select>
		    </div>
		    <div class="form-group col-sm-3">
		      <select id="endMonth" name="endMonth" class="form-control">
		        <option selected>Month...</option>
               <%for(int i = 1; i <= 12; i++){ %>
		        <option value="<%=i %>" ><%=i %></option>
		        <%} %>
		        
		      </select>
		    </div>
		    <div class="form-group col-sm-3">
		      <select id="endDay" name="endDay"  class="form-control">
		        <option selected>Day...</option>
		        <%for(int i = 1; i <= 31; i++){ %>
		        <option value="<%=i %>" ><%=i %></option>
		        <%} %>
		      </select>
		    </div>
		  </div>
		  
		</form>			
			
			
			
      <!-- table -->
			<div class="table-responsive-lg">
			<table class="table table-hover">
				
				<colgroup>
					<col width="10%" />
					<col width="15%" />
					<col width="15%" />
					<col width="15%" />
					<col width="15%" />
					<col width="15%" />
					<col width="15%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">Date</th>
						<th scope="col">Open</th>
						<th scope="col">High</th>
						<th scope="col">Low</th>
						<th scope="col">Close</th>
						<th scope="col">Volume</th>
						<th scope="col">Market Cap</th>
					</tr>
				</thead>
				<tbody>
				<%
				
				
				//String url = "https://coinmarketcap.com/currencies/"+ typeCoin + "/historical-data/?start=" + startDate+ "&end=" + endDate;
				String url = "https://coinmarketcap.com/currencies/bitcoin/historical-data/?start=20171101&end=20191203";
				Document doc = null;
				doc = Jsoup.connect(url).get();
				Elements elements = doc.select(".cmc-table__table-wrapper-outer table tbody tr");
				
				for(int i = 0; i <= elements.size(); i++){
					Element element = elements.get(i);	
					String date = element.child(0).text();
					String open = element.child(1).text();
					String high = element.child(2).text();
					String low = element.child(3).text();
					String close = element.child(4).text();
					String volume = element.child(5).text();
					String market = element.child(6).text();
				
					%>
		
					<tr>
						<td><%=date %></td>
						<td><%=open %></td>
						<td><%=high %></td>
						<td><%=low %></td>
						<td><%=close %></td>
						<td><%=volume %></td>
						<td><%=market %></td>
						
					</tr>
				<%}%>
					<tr>
						<td colspan = "6">데이터가 존재하지 않습니다.</td>
					</tr>
		
				</tbody>
			</table>
			</div>
    </div>
  </div>
</div>
<!--main end-->

<%@ include file = "../inc/footer.jsp" %>