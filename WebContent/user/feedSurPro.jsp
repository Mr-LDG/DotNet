<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>feedSurPro</title>
	</head>
	<body>
		<script type="text/javascript">
		var result = ${result};
		if(result) {
			location.href = "myFeed.do";
		} else {
			alert("feed설문 등록 실패");
		}
		</script>
	</body>
</html>