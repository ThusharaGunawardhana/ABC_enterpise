package controllers;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

@WebServlet("/supplierController")
public class supplierController extends HttpServlet {

    private static final String URL = "jdbc:mysql://localhost:3306/aspire_enterprises";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.getWriter().write("Error: action parameter is null.");
            return;
        }

        switch (action) {
            case "add":
                addSupplier(request, response);
                break;
            case "update":
                updateSupplier(request, response);
                break;
            case "delete":
                deleteSupplier(request, response);
                break;
            default:
                response.getWriter().write("Invalid action: " + action);
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response); // Handle GET requests as POST
    }

    private void addSupplier(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String supplierName = request.getParameter("supplierName");
        String contact = request.getParameter("contact");

        // Validate parameters
        if (supplierName == null || supplierName.isEmpty() || contact == null || contact.isEmpty()) {
            response.getWriter().write("Error: Missing supplierName or contact.");
            return;
        }

        try (Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD)) {
            String query = "INSERT INTO suppliers (supplier_name, contact) VALUES (?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, supplierName);
                statement.setString(2, contact);
                statement.executeUpdate();
                response.sendRedirect("supplierTableAdmin.jsp"); // Redirect to supplier table page
            }
        } catch (SQLException e) {
            response.getWriter().write("Error adding supplier: " + e.getMessage());
        }
    }

    private void updateSupplier(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String supplierIdParam = request.getParameter("supplier_id");
        String supplierName = request.getParameter("supplier_name");
        String contact = request.getParameter("contact");

        // Validate parameters
        if (supplierIdParam == null || supplierIdParam.isEmpty() || supplierName == null || supplierName.isEmpty() || contact == null || contact.isEmpty()) {
            response.getWriter().write("Error: Missing supplierId, supplierName, or contact.");
            return;
        }

        int supplierId;
        try {
            supplierId = Integer.parseInt(supplierIdParam);
        } catch (NumberFormatException e) {
            response.getWriter().write("Error: Invalid supplierId.");
            return;
        }

        try (Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD)) {
            String query = "UPDATE suppliers SET supplier_name = ?, contact = ? WHERE supplier_id = ?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, supplierName);
                statement.setString(2, contact);
                statement.setInt(3, supplierId);

                int rowsUpdated = statement.executeUpdate();
                if (rowsUpdated > 0) {
                    response.sendRedirect("supplierTableAdmin.jsp");
                } else {
                    response.getWriter().write("Error updating supplier: Supplier not found.");
                }
            }
        } catch (SQLException e) {
            response.getWriter().write("Error updating supplier: " + e.getMessage());
        }
    }

    private void deleteSupplier(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String supplierIdParam = request.getParameter("supplier_id");

        // Check if the supplier_id parameter is missing or invalid
        if (supplierIdParam == null || supplierIdParam.isEmpty()) {
            response.getWriter().write("Error: Missing or invalid supplier ID.");
            return;
        }

        int supplierId;
        try {
            // Try to parse the supplier_id parameter as an integer
            supplierId = Integer.parseInt(supplierIdParam);
        } catch (NumberFormatException e) {
            // Handle the case where the supplier_id parameter is not a valid integer
            response.getWriter().write("Error: Invalid supplier ID format.");
            return;
        }

        try (Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD)) {
            String query = "DELETE FROM suppliers WHERE supplier_id = ?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, supplierId);

                int rowsDeleted = statement.executeUpdate();
                if (rowsDeleted > 0) {
                    response.sendRedirect("supplierTableAdmin.jsp");  // Redirect to supplier list after deletion
                } else {
                    response.getWriter().write("Error deleting supplier: Supplier not found.");
                }
            }
        } catch (SQLException e) {
            response.getWriter().write("Error deleting supplier: " + e.getMessage());
        }
    }
}
