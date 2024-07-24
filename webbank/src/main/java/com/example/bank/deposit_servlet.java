package com.example.bank;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/deposit_money")
public class deposit_servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        long d_money = Long.parseLong(request.getParameter("d_money"));
        String account_password = request.getParameter("account_password");
        HttpSession session = request.getSession();
        
        String account_number = (String) session.getAttribute("account_number");
        String user_name = (String) session.getAttribute("u_name");
        

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_management", "root",
                    "Vinay123@dad");
            PreparedStatement pst_u = con.prepareStatement(
                    "UPDATE user_details SET initial_balance = initial_balance + ? WHERE account_password = ?");
            pst_u.setLong(1, d_money);
            pst_u.setString(2, account_password);
            
            Timestamp currentTimestamp = new Timestamp(new Date().getTime());
            
            PreparedStatement pst_t = con.prepareStatement(
                "INSERT INTO transactions (account_number, user_name, amount, transaction_type, status, receiver_phone_number, transaction_date) VALUES (?, ?, ?, ?, ?, ?, ?);"
            );
            pst_t.setString(1, account_number);
            pst_t.setString(2, user_name);
            pst_t.setLong(3, d_money);
            pst_t.setString(4, "deposit");
            pst_t.setString(5, "completed");
            pst_t.setString(6, "");
            pst_t.setTimestamp(7, currentTimestamp);
            
            int rowsupdated_s = pst_u.executeUpdate();
            int rowsinserted_t = pst_t.executeUpdate();
            
           
            
            if (rowsupdated_s > 0 && rowsinserted_t > 0) {
                // Update and insert successful
                response.sendRedirect("home.jsp");
            } else {
                // No rows updated, handle as per your application's logic
                request.setAttribute("status", "failed");
                request.getRequestDispatcher("home.jsp").forward(request, response);
            }
            
            pst_u.close();
            pst_t.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database access error", e);
        }
    }
}
