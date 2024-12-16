package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.dbHelper; // Import your dbHelper class

@WebServlet(name = "signincontroller", urlPatterns = {"/signincontroller"})
public class signincontroller extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Retrieve user credentials from the request
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (PrintWriter out = response.getWriter()) {
            // Using dbHelper to establish a database connection
            try (Connection conn = dbHelper.connectToDB()) {
                // SQL query to check if the user exists and fetch their role
                String sql = "SELECT firstname, role FROM user WHERE email = ? AND password = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, email);
                    stmt.setString(2, password); // Ideally, hash the password and verify

                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            // Retrieve the user's details
                            String firstname = rs.getString("firstname");
                            String role = rs.getString("role");

                            // Create a session for the user
                            HttpSession session = request.getSession();
                            session.setAttribute("firstname", firstname);
                            session.setAttribute("email", email);
                            session.setAttribute("role", role);

                            // Redirect based on the role
                            if ("admin".equalsIgnoreCase(role)) {
                                response.sendRedirect("adminhome.jsp");
                            } else if ("user".equalsIgnoreCase(role)) {
                                response.sendRedirect("home.jsp");
                            } else {
                                out.println("<h1>Error: Unknown role.</h1>");
                            }
                        } else {
                            // Invalid credentials
                            out.println("<h1>Error: Invalid email or password. Please try again.</h1>");
                        }
                    }
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace(); // Debugging purpose
                out.println("<h1>Error: Unable to connect to the database or execute the query.</h1>");
                out.println("<p>" + e.getMessage() + "</p>");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("signin.jsp");
    }
}


