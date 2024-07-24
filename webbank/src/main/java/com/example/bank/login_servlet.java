package com.example.bank;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class login_servlet
 */
@WebServlet("/login")
public class login_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String account_number = request.getParameter("account_number");
        String account_password = request.getParameter("account_password");
        HttpSession session = request.getSession();
        RequestDispatcher dispatcher = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_management", "root", "Vinay123@dad");
            PreparedStatement pst = con.prepareStatement("SELECT * FROM user_details WHERE account_number = ? AND account_password = ?");

            pst.setString(1, account_number);
            pst.setString(2, account_password);

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                session.setAttribute("u_name", rs.getString("u_name"));
                session.setAttribute("account_number", rs.getString("account_number"));
                dispatcher = request.getRequestDispatcher("home.jsp");
            } else {
                request.setAttribute("status", "failed");
                dispatcher = request.getRequestDispatcher("login.jsp");
            }
            dispatcher.forward(request, response);

            rs.close();
            pst.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Database access error", e);
        }
	}

}
