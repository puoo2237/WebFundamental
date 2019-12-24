<%@ page pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<!-- breadcrumb start-->
<nav aria-label="breadcrumb">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="#">Home</a></li>
		<li class="breadcrumb-item active" aria-current="page">Library</li>
	</ol>
</nav>
<!-- breadcrumb end-->

<!-- main start-->
<div class="container">
	<div class="row">
		<div class="col-lg-12">

			<!-- forms -->
			<%-- 파일 업로드할 때 form 엘리머트에 enctype 속성을 반드시 추가해야한다. --%>
			<h3>파일업로드</h3>
			<form name="f" method="post" enctype="multipart/form-data"
				action="upload.jsp">
				<div class="form-group row">
					<label for="name" class="col-sm-2 col-form-label">이름</label>
					<div class="col-sm-12">
						<input type="text" class = "form-control" placeholder = "이름을 입력하세요." id="name" name="name">
					</div>
				</div>
				<div class="form-group">
				<div class="col-sm-12">
					<input type="file" class="form-control" id = "file" name= "file">
				</div>
			</form>

			<!-- bottons -->
			<div class="text-right">
				<%if(memberDto != null){ %>
				<button type="button" id="uploadFile" class="btn btn-outline-success">저장</button>
				<%} %>
			</div>

		</div>
	</div>
</div>
<!--main end-->
<%@ include file="../inc/footer.jsp"%>

<script>
	$(function(){
		$("#uploadFile").click(function(){
			f.submit();
		});
	});
</script>



