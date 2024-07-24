<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>BANKING HOMEPAGE</title>
</head>
<style>
body {
    background: linear-gradient(to right, #ffecd2 0%, #fcb69f 100%);
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0;
}

h2 {
    text-align: center;
    font-family: 'Georgia', serif;
    color: #333;
    margin-top: 20px;
}

button {
    background-color: #333;
    border: 2px solid #fcb69f;
    width: 160px;
    height: 55px;
    border-radius: 12px;
    margin: 20px;
    transition: background-color 0.3s, transform 0.3s;
}

a {
    text-decoration: none;
    color: #ffecd2;
    font-size: 16px;
    display: block;
    height: 100%;
    line-height: 55px;
    text-align: center;
}

.container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 80vh;
    flex-direction: column;
}

button:hover {
    background-color: #555;
    transform: scale(1.05);
}
</style>
<body>
<br>
<br>
<br>
<h2>Welcome to Online Banking</h2>
<div class="container">
    <button><a href="customer.jsp" style="margin-right:10px;">Customer</a></button>
    <button><a href="admin.jsp">Admin</a></button>
</div>
</body>
</html>
