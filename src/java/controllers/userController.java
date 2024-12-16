package controllers;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/userController")
public class userController extends HttpServlet {

    private static final String URL = "jdbc:mysql://localhost:3306/aspire_enterprises";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addUser(request, response);
        } else if ("update".equals(action)) {
            updateUser(request, response);
        } else if ("delete".equals(action)) {
            deleteUser(request, response);
        } else {
            response.getWriter().write("Invalid action: " + action);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response); // Handle GET requests as POST
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String password = request.getParameter("password");
        String contact = request.getParameter("contact");
        String role = request.getParameter("role");

        try (Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD)) {
            String query = "INSERT INTO user (email, firstname, lastname, password, contact, role) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, email);
                statement.setString(2, firstname);
                statement.setString(3, lastname);
                statement.setString(4, password);
                statement.setString(5, contact);
                statement.setString(6, role);

                statement.executeUpdate();
                response.sendRedirect("usersTable.jsp"); // Redirect to user table page
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Error adding user: " + e.getMessage());
        }
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String email = request.getParameter("email");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String password = request.getParameter("password");
        String contact = request.getParameter("contact");
        String role = request.getParameter("role");

        // Debugging: Check all parameters
        System.out.println("Updating User - ID: " + id + ", Password: " + password);

        try (Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD)) {
            String query = "UPDATE user SET email = ?, firstname = ?, lastname = ?, password = ?, contact = ?, role = ? WHERE id = ?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, email);
                statement.setString(2, firstname);
                statement.setString(3, lastname);
                statement.setString(4, password);
                statement.setString(5, contact);
                statement.setString(6, role);
                statement.setInt(7, id);

                int rowsUpdated = statement.executeUpdate();
                if (rowsUpdated > 0) {
                    response.sendRedirect("usersTable.jsp");
                } else {
                    response.getWriter().write("Error updating user: User not found.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Error updating user: " + e.getMessage());
        }
    }


    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try (Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD)) {
            String query = "DELETE FROM user WHERE id = ?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, id);

                int rowsDeleted = statement.executeUpdate();
                if (rowsDeleted > 0) {
                    response.sendRedirect("usersTable.jsp");
                } else {
                    response.getWriter().write("Error deleting user: User not found.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Error deleting user: " + e.getMessage());
        }
    }
}
