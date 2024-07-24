package com.example.bank;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin_delete_user")
public class admin_delete_user extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user_acc_no = request.getParameter("user_acc_no");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_management", "root", "Vinay123@dad");
            PreparedStatement pst = con.prepareStatement("DELETE FROM user_details WHERE account_number = ?");
            pst.setString(1, user_acc_no);

            int rowsDeleted = pst.executeUpdate();
            if (rowsDeleted > 0) {
                response.getWriter().write("User account deleted successfully.");
            } else {
                response.getWriter().write("Failed to delete user account.");
            }

            pst.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error occurred: " + e.getMessage());
        }
    }
}
