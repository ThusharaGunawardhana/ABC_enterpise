package controllers;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class InventoryController extends HttpServlet {

    // JDBC URL, username, and password
    private static final String DB_URL = "jdbc:mysql://localhost:3306/aspire_enterprises";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    // Handle GET requests (for delete, edit, and fetching data)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        // Handle delete action
        if ("delete".equals(action)) {
            String productIdParam = request.getParameter("product_id");

            if (productIdParam != null && !productIdParam.isEmpty()) {
                try {
                    int productId = Integer.parseInt(productIdParam);
                    deleteProduct(productId, response);
                } catch (NumberFormatException e) {
                    response.getWriter().println("Error: Invalid product ID.");
                }
            } else {
                response.getWriter().println("Error: Product ID not found.");
            }
        }

        // Handle edit action (fetch product details for editing)
        if ("edit".equals(action)) {
            String productIdParam = request.getParameter("product_id");
            if (productIdParam != null && !productIdParam.isEmpty()) {
                try {
                    int productId = Integer.parseInt(productIdParam);
                    editProduct(productId, request, response);
                } catch (NumberFormatException e) {
                    response.getWriter().println("Error: Invalid product ID.");
                }
            } else {
                response.getWriter().println("Error: Product ID not found.");
            }
        }
    }

    // Handle POST requests (for updating product details and adding a new product)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("update".equals(action)) {
            try {
                int productId = Integer.parseInt(request.getParameter("product_id"));
                String productName = request.getParameter("product_name");
                String categoryId = request.getParameter("category_id");
                int stockQuantity = Integer.parseInt(request.getParameter("stock_quantity"));
                String supplierName = request.getParameter("supplier_name");

                updateProduct(productId, productName, categoryId, stockQuantity, supplierName, response);
            } catch (NumberFormatException e) {
                response.getWriter().println("Error: Invalid input for product data.");
            }
        } else if ("add".equals(action)) {
            addProduct(request, response);
        }
    }

    // Delete a product
    private void deleteProduct(int productId, HttpServletResponse response) throws IOException {
        Connection conn = null;
        Statement stmt = null;
        try {
            // Connect to the database
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            stmt = conn.createStatement();
            String deleteQuery = "DELETE FROM inventory WHERE product_id = " + productId;
            int result = stmt.executeUpdate(deleteQuery);

            if (result > 0) {
                // Redirect back to the inventory table page
                response.sendRedirect("inventoryTableAdmin.jsp");
            } else {
                response.getWriter().println("Error: Could not delete the product.");
            }
        } catch (SQLException e) {
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                response.getWriter().println("Error closing resources: " + ex.getMessage());
            }
        }
    }

    // Fetch product details for editing
    private void editProduct(int productId, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            // Connect to the database
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String query = "SELECT * FROM inventory WHERE product_id = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, productId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // Set product details as request attributes to display in viewInventory.jsp
                request.setAttribute("product_id", rs.getInt("product_id"));
                request.setAttribute("product_name", rs.getString("product_name"));
                request.setAttribute("category_id", rs.getString("category_id"));
                request.setAttribute("stock_quantity", rs.getInt("stock_quantity"));
                request.setAttribute("supplier_name", rs.getString("supplier_name"));
                // Forward to the viewInventory.jsp form for editing
                RequestDispatcher dispatcher = request.getRequestDispatcher("viewInventory.jsp");
                dispatcher.forward(request, response);
            } else {
                response.getWriter().println("Product not found.");
            }
        } catch (SQLException e) {
            response.getWriter().println("Error fetching product: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                response.getWriter().println("Error closing resources: " + ex.getMessage());
            }
        }
    }

    // Update product details
    private void updateProduct(int productId, String productName, String categoryId, int stockQuantity, String supplierName, HttpServletResponse response) throws IOException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Connect to the database
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String updateQuery = "UPDATE inventory SET product_name = ?, category_id = ?, stock_quantity = ?, supplier_name = ? WHERE product_id = ?";
            stmt = conn.prepareStatement(updateQuery);
            stmt.setString(1, productName);
            stmt.setString(2, categoryId);
            stmt.setInt(3, stockQuantity);
            stmt.setString(4, supplierName);
            stmt.setInt(5, productId);

            int result = stmt.executeUpdate();

            if (result > 0) {
                // Redirect to inventory table after updating
                response.sendRedirect("inventoryTableAdmin.jsp");
            } else {
                response.getWriter().println("Error: Could not update the product.");
            }
        } catch (SQLException e) {
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                response.getWriter().println("Error closing resources: " + ex.getMessage());
            }
        }
    }

    // Add a new product to the inventory
    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String sql = "INSERT INTO inventory (product_name, category_id, stock_quantity, supplier_name) VALUES (?, ?, ?, ?)";
        try (
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            // Set the parameters for the new product
            String productName = request.getParameter("product_name");
            String categoryId = request.getParameter("category_id");
            int stockQuantity = Integer.parseInt(request.getParameter("stock_quantity"));
            String supplierName = request.getParameter("supplier_name");

            stmt.setString(1, productName);
            stmt.setString(2, categoryId);
            stmt.setInt(3, stockQuantity);
            stmt.setString(4, supplierName);

            // Execute the insert query
            int result = stmt.executeUpdate();

            if (result > 0) {
                // Redirect to inventory table after adding the product
                response.sendRedirect("inventoryTableAdmin.jsp");
            } else {
                response.getWriter().println("Error: Could not add the product.");
            }
        } catch (SQLException | NumberFormatException e) {
            response.getWriter().println("Error adding product: " + e.getMessage());
        }
    }
}
