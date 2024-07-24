<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Account</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #FFA500;
            margin: 0;
            padding: 20px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        form {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 80%; /* Adjusted width */
            margin: 0 auto;
            max-width: 600px; /* Maximum width to ensure it doesn't get too wide */
        }
        form label {
            display: block;
            margin-bottom: 8px;
        }
        form input[type="text"],
        form input[type="email"],
        form input[type="date"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        form input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        form input[type="submit"]:hover {
            background-color: #45a049;
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
            background-color: #f2f2f2;
            color: #333;
        }
    </style>
</head>
<body>
<h2>Edit an Account</h2>
<form method="post" action="">
    <label>Enter the Account Number:</label>
    <input type="text" name="user_acc_no" required/>
    <input type="submit" value="Get"/>
</form>
<%
String user_acc_no = request.getParameter("user_acc_no");
if (user_acc_no != null && !user_acc_no.isEmpty()) {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_management", "root", "Vinay123@dad");
        PreparedStatement pst = con.prepareStatement("SELECT * FROM user_details WHERE account_number = ?");
        pst.setString(1, user_acc_no);
        ResultSet rs = pst.executeQuery();
        if (rs.next()) {
            %>
            <table>
                <tr>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Address</th>
                    <th>Phone Number</th>
                    <th>Email</th>
                    <th>Account Type</th>
                    <th>Date of Birth</th>
                    <th>Account Number</th>
                </tr>
                <tr>
                    <td><%= rs.getString("u_id") %></td>
                    <td><%= rs.getString("u_name") %></td>
                    <td><%= rs.getString("address") %></td>
                    <td><%= rs.getString("phone_number") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("account_type") %></td>
                    <td><%= rs.getDate("date_of_birth") %></td>
                    <td><%= rs.getString("account_number") %></td>
                </tr>
            </table><br><br>
            <form action="admin_edit_user" method="post">
                <input type="hidden" name="user_acc_no" value="<%= user_acc_no %>"/>
                <label>Name</label>
                <input type="text" name="new_name" value="<%= rs.getString("u_name") %>" required/><br><br>
                <label>Address</label>
                <input type="text" name="new_address" value="<%= rs.getString("address") %>" required/><br><br>
                <label>Phone Number</label>
                <input type="text" name="new_ph_no" value="<%= rs.getString("phone_number") %>" required/><br><br>
                <label>Email</label>
                <input type="email" name="new_email" value="<%= rs.getString("email") %>" required/><br><br>
                <label>Date of Birth</label>
                <input type="date" name="new_dob" value="<%= rs.getDate("date_of_birth") %>" required/><br><br>
                <input type="submit" value="Update">
            </form>
            <%
        } else {
            out.println("<p>No account found with the provided account number.</p>");
        }
        rs.close();
        pst.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error occurred: " + e.getMessage() + "</p>");
    }
}
%>
</body>
</html>
