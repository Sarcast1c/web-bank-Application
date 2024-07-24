<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.annotation.WebServlet" %>
<%@ page import="javax.servlet.http.HttpServlet" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Home</title>
    <style>
        body {
            font-family: 'Helvetica Neue', Arial, sans-serif;
            background: linear-gradient(to right, #ff7e5f, #feb47b);
            margin: 0;
            padding: 0;
            color: #333;
        }
.header {
display: flex;
justify-content: space-between;
background-color: #fff;
padding: 20px;
border-radius: 8px;
box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
text-align: center;
margin: 20px;
align-items: center;
}
.side-header {
display: flex;
justify-content: space-around;
align-items: center;
width: 40%;
}
.logout-button {
background-color: #ff4d4d;
color: #fff;
padding: 10px 20px;
border: none;
border-radius: 5px;
text-decoration: none;
display: inline-block;
transition: background-color 0.3s;
}
.logout-button
{
background-color: #cc0000;
}
.balance-section, .deposit-section, .withdraw-section, .transaction-section, .transaction-history {
margin: 20px;
padding: 20px;
background-color: #fff;
border-radius: 8px;
box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
h2 {
font-size: 1.5em;
margin-bottom: 15px;
}
form {
display: flex;
flex-direction: column;
align-items: center;
}
label {
font-weight: bold;
margin-bottom: 5px;
display: block;
}
input[type="text"], input[type="password"], input[type="submit"] {
padding: 10px;
margin-bottom: 10px;
border: 1px solid #ccc;
border-radius: 5px;
width: 300px;
}
input[type="submit"] {
background-color: #28a745;
color: #fff;
border: none;
cursor: pointer;
transition: background-color 0.3s;
}
input[type="submit"]
{
background-color: #218838;
}
.error-message {
color: #ff4d4d;
}
table {
width: 100%;
border-collapse: collapse;
margin-top: 20px;
}
table th, table td {
border: 1px solid #ddd;
padding: 8px;
text-align: center;
}
table th {
background-color: #f8f9fa;
color: #333;
}
</style>
    <script>
        function updateTime() {
            var now = new Date();
            var formattedTime = now.getFullYear() + '-' + 
                                ('0' + (now.getMonth() + 1)).slice(-2) + '-' + 
                                ('0' + now.getDate()).slice(-2) + ' ' + 
                                ('0' + now.getHours()).slice(-2) + ':' + 
                                ('0' + now.getMinutes()).slice(-2) + ':' + 
                                ('0' + now.getSeconds()).slice(-2);
            document.getElementById('current-time').innerText = formattedTime;
        }

        setInterval(updateTime, 1000);
    </script>
</head>
<body onload="updateTime()">
    <div class="header">
        <%
            String username = (String) session.getAttribute("u_name");
            if (username != null) {
                out.println("<h2>Welcome, " + username + "</h2>");
            } else {
                out.println("Username not found");
            }
        %>
        <div class="side-header">
            <p>Time: <span id="current-time"></span></p>
            <a class="logout-button" href="login.jsp">Logout</a>
        </div>
    </div>
    
    <div class="balance-section">
        <h2>Balance Check</h2>
        <form action="balance" method="post">
            <label>Check your Balance</label>
            <input type="password" placeholder="Enter your Account Password" name="account_password"/>
            <input type="submit" value="View Balance"/>
        </form>
        <%
            String initial_balance = (String) request.getAttribute("initial_balance");
            if (initial_balance != null) {
                out.println("<p>Your balance is ₹" + initial_balance + "</p>");
            }
        %>
    </div>
    
    <hr>
    
    <div class="deposit-section">
        <h2>Deposit Money</h2>
        <form action="deposit_money" method="post">
            <label>Enter the amount you want to deposit</label><br/>
            <input type="text" name="d_money"/><br/><br/>
            <label>Enter your Account Password</label><br/>
            <input type="password" name="account_password"/><br/><br/>
            <input type="submit" value="Deposit"/>
        </form>
    </div>
    
    
    <div class="withdraw-section">
        <h2>Withdraw Money</h2>
        <form action ="withdraw_money" method="post">
            <label>Enter the amount you want to withdraw</label><br/>
            <input type="text" name="w_money"/><br/><br/>
            <label>Enter your Account Password</label><br/>
            <input type="password" name="account_password"/><br/><br/>
            <input type="submit" value="Withdraw"/>
        </form>
    </div>

    
    <div class="transaction-section">
        <h2>Transaction</h2>
        <form action="transaction" method="post">
            <label>Enter Receiver's Phone Number</label><br/>
            <input type="text" name="receiver_phone_number"/><br/><br/>
            <label>Enter Amount</label><br/>
            <input type="text" name="t_amount"/><br/><br/>
            <label>Enter Your Account Password</label><br/>
            <input type="password" name="account_password"/><br/><br/>
            <input type="submit" value="Make Transaction"/>
        </form>
    </div>
    
    <hr>
    
    <div class="transaction-history">
        <h2>Transaction History</h2>
        <form method="post">
            <table>
                <tr>
                    <th>Transaction ID</th>
                    <th>Transaction Amount</th>
                    <th>Transaction Type</th>
                    <th>Status</th>
                    <th>Receiver's Phone Number</th>
                    <th>Transaction Date</th>
                </tr>
                <% 
                    String user_name = (String) session.getAttribute("u_name");
                    
                    
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_management", "root", "Vinay123@dad");
                            PreparedStatement pst = con.prepareStatement("SELECT transaction_id, user_name, amount, transaction_type, status, receiver_phone_number, transaction_date FROM transactions WHERE user_name=?");
                            pst.setString(1, user_name);
                            
                            ResultSet rs = pst.executeQuery();
                            
                            while (rs.next()) {
                            	
                %>
                <tr>
                    <td><%= rs.getString("transaction_id") %></td>
                    <td><%= rs.getLong("amount") %></td>
                    <td><%= rs.getString("transaction_type") %></td>
                    <td><%= rs.getString("status") %></td>
                    <td><%= rs.getString("receiver_phone_number") %></td>
                    <td><%= rs.getTimestamp("transaction_date") %></td>

                </tr>
                <% 
                            }
                            
                            rs.close();
                            pst.close();
                            con.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    
                %>
            </table>
        </form>
    </div>
</body>
</html>
