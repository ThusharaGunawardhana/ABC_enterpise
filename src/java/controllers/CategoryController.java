package controllers;

import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.SQLException;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

@WebServlet("/CategoryController")
public class CategoryController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (null != action) {
            switch (action) {
                case "add":
                    addCategory(request, response);
                    break;
                case "update":
                    updateCategory(request, response);
                    break;
                case "delete":
                    try {
                        deleteCategory(request, response);
                    } catch (SQLException ex) {
                        Logger.getLogger(CategoryController.class.getName()).log(Level.SEVERE, null, ex);
                        response.getWriter().println("Error deleting category.");
                    }
                    break;
                default:
                    break;
            }
        }
    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryName = request.getParameter("category_name");
        String description = request.getParameter("description");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");  // Use the newer driver class
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/aspire_enterprises", "root", "");

            String query = "INSERT INTO categories (category_name, description) VALUES (?, ?)";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, categoryName);
            preparedStatement.setString(2, description);

            int result = preparedStatement.executeUpdate();

            if (result > 0) {
                response.sendRedirect("categoriesTableAdmin.jsp");  // Ensure redirect to the correct page after success
            } else {
                response.getWriter().println("Error adding category.");
            }
        } catch (IOException | ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("category_id"));
        String categoryName = request.getParameter("category_name");
        String description = request.getParameter("description");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");  // Use the newer driver class
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/aspire_enterprises", "root", "");

            String query = "UPDATE categories SET category_name = ?, description = ? WHERE category_id = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, categoryName);
            preparedStatement.setString(2, description);
            preparedStatement.setInt(3, categoryId);

            int result = preparedStatement.executeUpdate();

            if (result > 0) {
                response.sendRedirect("categoriesTableAdmin.jsp");  // Ensure redirect after successful update
            } else {
                response.getWriter().println("Error updating category.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int categoryId = Integer.parseInt(request.getParameter("category_id"));

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/aspire_enterprises", "root", "");

            String query = "DELETE FROM categories WHERE category_id = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, categoryId);

            int result = preparedStatement.executeUpdate();

            if (result > 0) {
                response.sendRedirect("categoriesTableAdmin.jsp");
            } else {
                response.getWriter().println("Error deleting category.");
            }
        } catch (ClassNotFoundException e) {
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            if (preparedStatement != null) preparedStatement.close();
            if (connection != null) connection.close();
        }
    }

}
