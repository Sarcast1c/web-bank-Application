<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
   <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background:#FFA500;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center; 
            justify-content: center;
            height: 100vh; 
            color: #fff;
        }
        
        .header {
            text-align: center;
            margin-bottom: 20px;
        }
        
        .container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2); 
            width: 320px; 
        }
        
        .container form {
            display: flex;
            flex-direction: column;
        }
        
        .container label {
            margin-bottom: 10px;
            font-weight: bold;
            color: #333;
        }
        
        .container input[type="text"],
        .container input[type="password"],
        .container input[type="submit"] {
            padding: 12px;
            margin-bottom: 15px; 
            border: 1px solid #ccc;
            border-radius: 5px;
            width: calc(100% - 24px); 
            font-size: 16px;
        }
        
        .container input[type="submit"] {
            background-color: #FFA500;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        
        .container input[type="submit"]:hover {
            background-color: #FFA500;
        }
        
        .error-message {
            color: #FFA500;
            margin-top: 10px; 
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="header">
        <h2>Admin login</h2>
    </div>
    <div class="container">
        <form action="admin_login" method="post">
            <label>Username</label>
            <input type="text" name="admin_username"><br><br>
            <label>Password</label>
            <input type="password" name="admin_password"/><br><br>
            <input type="submit" value="Login"/>
        </form>
    </div>
    <% if (request.getAttribute("status") != null && request.getAttribute("status").equals("failed")) { %>
        <p class="error-message">Invalid username or password. Please try again.</p>
    <% } %>
</body>
</html>
