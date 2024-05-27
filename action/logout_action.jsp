<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%
HttpSession userAccount = request.getSession();
userAccount.invalidate();
%>
<script>
alert('로그아웃 되셨습니다.')
location.href = "../index.jsp";
</script>