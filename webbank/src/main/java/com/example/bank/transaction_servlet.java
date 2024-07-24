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

/**
 * Servlet implementation class transaction_servlet
 */
@WebServlet("/transaction")
public class transaction_servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long t_money = Long.parseLong(request.getParameter("t_amount"));
        String ph_no = request.getParameter("receiver_phone_number");
        String account_password = request.getParameter("account_password");
        HttpSession session = request.getSession();
        
        String username=(String)session.getAttribute("u_name");
        String account_number = (String) session.getAttribute("account_number");
        
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_management", "root", "Vinay123@dad");
            
            PreparedStatement pst_s = con.prepareStatement("UPDATE user_details SET initial_balance = initial_balance - ? WHERE account_password = ?");
            pst_s.setLong(1, t_money);
            pst_s.setString(2, account_password);
            
            PreparedStatement pst_r = con.prepareStatement("UPDATE user_details SET initial_balance = initial_balance + ? WHERE phone_number = ?");
            pst_r.setLong(1, t_money);
            pst_r.setString(2, ph_no);
            
            Timestamp currentTimestamp = new Timestamp(new Date().getTime());
            
            
            PreparedStatement pst_t = con.prepareStatement(
                    "INSERT INTO transactions (account_number, user_name, amount, transaction_type, status, receiver_phone_number, transaction_date) VALUES (?, ?, ?, ?, ?, ?, ?);"
                );
            
            pst_t.setString(1, account_number);
            pst_t.setString(2, username);
            pst_t.setLong(3, t_money);
            pst_t.setString(4, "transaction");
            pst_t.setString(5, "completed");
            pst_t.setString(6, ph_no);
            pst_t.setTimestamp(7, currentTimestamp);
            
            int rowsupdated_s = pst_s.executeUpdate();
            int rowsupdated_r = pst_r.executeUpdate(); 
            int rowsinserted_t = pst_t.executeUpdate();
            
            if (rowsupdated_s > 0 && rowsupdated_r > 0 && rowsinserted_t>0) {
                // Update successful
                response.sendRedirect("home.jsp");
            } else {
                // No rows updated, handle as per your application's logic
                request.setAttribute("status", "failed");
                request.getRequestDispatcher("home.jsp").forward(request, response);
            }
            
            pst_s.close();
            pst_r.close();
            pst_t.close();
            con.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database access error", e);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new ServletException("JDBC Driver not found", e);
        }
    }
}
