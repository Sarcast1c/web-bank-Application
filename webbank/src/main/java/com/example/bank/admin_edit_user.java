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

@WebServlet("/admin_edit_user")
public class admin_edit_user extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acc_name = request.getParameter("new_name");
        String acc_address = request.getParameter("new_address");
        String acc_ph_no = request.getParameter("new_ph_no");
        String acc_email = request.getParameter("new_email");
        String acc_dob = request.getParameter("new_dob");
        String user_acc_no = request.getParameter("user_acc_no");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_management", "root", "Vinay123@dad");

            StringBuilder sql = new StringBuilder("UPDATE user_details SET ");
            boolean first = true;

            if (acc_name != null && !acc_name.isEmpty()) {
                sql.append("u_name = ?");
                first = false;
            }
            if (acc_address != null && !acc_address.isEmpty()) {
                if (!first) sql.append(", ");
                sql.append("address = ?");
                first = false;
            }
            if (acc_ph_no != null && !acc_ph_no.isEmpty()) {
                if (!first) sql.append(", ");
                sql.append("phone_number = ?");
                first = false;
            }
            if (acc_email != null && !acc_email.isEmpty()) {
                if (!first) sql.append(", ");
                sql.append("email = ?");
                first = false;
            }
            if (acc_dob != null && !acc_dob.isEmpty()) {
                if (!first) sql.append(", ");
                sql.append("date_of_birth = ?");
            }

            sql.append(" WHERE account_number = ?");

            PreparedStatement pst = con.prepareStatement(sql.toString());

            int index = 1;
            if (acc_name != null && !acc_name.isEmpty()) {
                pst.setString(index++, acc_name);
            }
            if (acc_address != null && !acc_address.isEmpty()) {
                pst.setString(index++, acc_address);
            }
            if (acc_ph_no != null && !acc_ph_no.isEmpty()) {
                pst.setString(index++, acc_ph_no);
            }
            if (acc_email != null && !acc_email.isEmpty()) {
                pst.setString(index++, acc_email);
            }
            if (acc_dob != null && !acc_dob.isEmpty()) {
                pst.setDate(index++, java.sql.Date.valueOf(acc_dob));
            }
            pst.setString(index, user_acc_no);

            int rowsUpdated = pst.executeUpdate();
            if (rowsUpdated > 0) {
               response.sendRedirect("admin_home.jsp");
            } else {
                response.getWriter().write("Failed to update user details.");
            }

            pst.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error occurred: " + e.getMessage());
        }
    }
}
