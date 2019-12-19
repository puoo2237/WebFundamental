<%@ page pageEncoding = "utf-8" %>

<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
    integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

  <title>Hello, world!</title>
</head>

<body></body>
<!--navbar start-->
<nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #563d7c;">
  <a class="navbar-brand" href="/index.jsp">Home</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav"
    aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
<%
	// /dept/list.jsp, /emp/list.jsp, /notice/list.jsp
	String uri = request.getRequestURI();
%>

  <div class="collapse navbar-collapse" id="navbarNav">
    <ul class="navbar-nav">
      <li class="nav-item <% if(uri.startsWith("/dept")){%>active<% }%>">
        <a class="nav-link" href="/dept/list.jsp">부서관리<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item <% if(uri.startsWith("/emp")){%>active<% }%>">
        <a class="nav-link" href="/emp/list.jsp">사원관리<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item <% if(uri.startsWith("/notice")){%>active<% }%>">
        <a class="nav-link" href="/notice/list.jsp">공지사항</a>
      </li>
    </ul>
  </div>
</nav>
<!--navbar end-->