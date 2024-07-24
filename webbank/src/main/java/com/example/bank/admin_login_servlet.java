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

@WebServlet("/admin_login")
public class admin_login_servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String admin_username = request.getParameter("admin_username");
        String admin_password = request.getParameter("admin_password");
        HttpSession session = request.getSession();
        RequestDispatcher dispatcher = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_management", "root", "Vinay123@dad");
            PreparedStatement pst = con.prepareStatement("SELECT * FROM admin_details WHERE username = ? AND admin_password = ?");

            pst.setString(1, admin_username);
            pst.setString(2, admin_password);

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                session.setAttribute("username", rs.getString("username"));
                dispatcher = request.getRequestDispatcher("admin_home.jsp");
            } else {
                request.setAttribute("status", "failed");
                dispatcher = request.getRequestDispatcher("admin.jsp");
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
