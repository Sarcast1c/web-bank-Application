<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login Page</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap">
<style>
 
    body {
        margin: 0;
        padding: 0;
        font-family: 'Poppins', sans-serif;
        background-color: #FFA500; /* Changed background color to orange */
    }

    .navbar {
        width: 100%;
        background-color: #fff;
        padding: 10px 0;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        display: flex;
        justify-content: center;
        margin-bottom: 20px;
    }

    .navbar h2 {
        margin: 0 20px;
    }

    .navbar h2 a {
        color: rgb(114, 227, 167);
        text-decoration: none;
        transition: color 0.3s ease;
    }

    .navbar h2 a:hover {
        color: rgb(90, 180, 130);
    }

    .container {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        background-color: #fff;
        padding: 20px 40px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        width: 400px;
        margin: 0 auto;
    }

    .container section {
        width: 100%;
        margin-bottom: 20px;
    }

    .container section h2 {
        text-align: center;
        color: black;
        margin-bottom: 20px;
    }

    .container form {
        display: flex;
        flex-direction: column;
    }

    .container label {
        margin-bottom: 5px;
        font-weight: bold;
    }

    .container input[type="text"],
    .container input[type="password"] {
        padding: 10px;
        border-radius: 10px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
    }

    .container input[type="submit"] {
        background-color: #FFA500; /* Changed button background color to orange */
        color: #fff;
        border: none;
        border-radius: 5px;
        padding: 10px;
        cursor: pointer;
        font-weight: bold;
        transition: background-color 0.3s ease;
    }

    .container input[type="submit"]:hover {
        background-color: #E69500; /* Slightly darker shade of orange for hover effect */
    }

    .container p {
        font-weight: bold;
        text-align: center;
    }
</style>
</head>
<body>
<input type="hidden" id="status" value="<%=request.getAttribute("status")%>"/>
<div class="navbar">
        <h2><a href="customer.jsp">Signup</a></h2>
        <h2>Login</h2>
      </div>
      
<div class="container">
    <section>
        <h2>Get Account ID</h2>
        <form action="get_account" method="post">
            <label for="phone_number">Phone Number</label>
            <input type="text" id="phone_number" name="phone_number" required/>
            
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required/>
            
            <input type="submit" value="Get"/>
        </form>
        <%-- Display retrieved account details --%>
        <%
        String accountNumber = (String) request.getAttribute("account_number");
        String accountPassword = (String) request.getAttribute("account_password");
        if (accountNumber != null && accountPassword != null) {
            out.println("<p>Account Number: " + accountNumber + "</p>");
            out.println("<p>Account Password: " + accountPassword + "</p>");
        }
        %>
    </section>

    <section>
        <h2>Account Login</h2>
        <form action="login" method="post">
            <label for="account_number">Enter Account Number</label>
            <input type="text" id="account_number" name="account_number" placeholder="Enter your Account Number" required/>
            
            <label for="account_password">Enter your Account Password</label>
            <input type="password" id="account_password" name="account_password" placeholder="Enter your Account password" required/>
            
            <input type="submit" value="Login" name="signin"/>
        </form>
    </section>
</div>
</body>
</html>
