package com.example.bank;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class registration_servlet
 */
@WebServlet("/register")
public class registration_servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String u_name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone_number = request.getParameter("phone");
        String email = request.getParameter("email");
        String account_type = request.getParameter("account_type");
        double initial_balance = Double.parseDouble(request.getParameter("iamount"));
        String date_of_birth = request.getParameter("dob");
        String proof = request.getParameter("id_proof");
        String password = request.getParameter("password");

        String account_number = generate_account_number();
        String account_password = generate_account_password();

        RequestDispatcher dispatcher = null;
        Connection con1 = null;
        PreparedStatement pst = null;

        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection to the database
            con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_management", "root", "Vinay123@dad");

            // Prepare the SQL statement
            String sql = "INSERT INTO user_details (u_name, address, phone_number, email, account_type, initial_balance, date_of_birth, proof, password, account_number, account_password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pst = con1.prepareStatement(sql);

            // Set the parameters for the SQL statement
            pst.setString(1, u_name);
            pst.setString(2, address);
            pst.setString(3, phone_number);
            pst.setString(4, email);
            pst.setString(5, account_type);
            pst.setDouble(6, initial_balance);
            pst.setString(7, date_of_birth);
            pst.setString(8, proof);
            pst.setString(9, password);
            pst.setString(10, account_number);
            pst.setString(11, account_password);

            // Execute the SQL statement
            int rowcount = pst.executeUpdate();
            dispatcher = request.getRequestDispatcher("login.jsp");
            if (rowcount > 0) {
                request.setAttribute("status", "success");
            } else {
                request.setAttribute("status", "failed");
            }
            dispatcher.forward(request, response);
        } catch (Exception e) {
            // Log the exception
            e.printStackTrace();
            request.setAttribute("status", "exception: " + e.getMessage());
            dispatcher = request.getRequestDispatcher("customer.jsp");
            dispatcher.forward(request, response);
        } finally {
            if (pst != null) {
                try {
                    pst.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (con1 != null) {
                try {
                    con1.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private String generate_account_number() {
        return "user" + new Random().nextInt(999999999);
    }

    private String generate_account_password() {
        return String.valueOf(new Random().nextInt(999999));
    }
}
