package controllers;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/SalesController") // Map the servlet to this URL
public class SalesController extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/aspire_enterprises?useSSL=false";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int saleId = Integer.parseInt(request.getParameter("sale_id"));
            deleteSale(saleId, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");
        if ("update".equals(action)) {
            updateSale(request, response);
        } else if ("add".equals(action)) {
            addSale(request, response);
        }
    }

    private void deleteSale(int saleId, HttpServletResponse response) throws IOException {
        String sql = "DELETE FROM sales WHERE sale_id = ?";
        try (
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            Class.forName("com.mysql.jdbc.Driver");
            stmt.setInt(1, saleId);
            stmt.executeUpdate();
            response.sendRedirect("salesTableAdmin.jsp");
        } catch (ClassNotFoundException | SQLException e) {
            handleError(response, "Error deleting sale: " + e.getMessage());
        }
    }

    private void updateSale(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String sql = "UPDATE sales SET product_name = ?, quantity_sold = ?, price_per_unit = ?, total_sale_amount = ? WHERE sale_id = ?";
        try (
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            Class.forName("com.mysql.jdbc.Driver");

            int saleId = Integer.parseInt(request.getParameter("sale_id"));
            String productName = request.getParameter("product_name");
            int quantitySold = Integer.parseInt(request.getParameter("quantity_sold"));
            double pricePerUnit = Double.parseDouble(request.getParameter("price_per_unit"));
            double totalSaleAmount = quantitySold * pricePerUnit;

            stmt.setString(1, productName);
            stmt.setInt(2, quantitySold);
            stmt.setDouble(3, pricePerUnit);
            stmt.setDouble(4, totalSaleAmount);
            stmt.setInt(5, saleId);

            stmt.executeUpdate();
            response.sendRedirect("salesTableAdmin.jsp");
        } catch (ClassNotFoundException | SQLException | NumberFormatException e) {
            handleError(response, "Error updating sale: " + e.getMessage());
        }
    }

    private void addSale(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String sql = "INSERT INTO sales (date, product_name, quantity_sold, price_per_unit, total_sale_amount) VALUES (?, ?, ?, ?, ?)";
        try (
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            Class.forName("com.mysql.jdbc.Driver");

            String date = request.getParameter("date");
            String productName = request.getParameter("product_name");
            int quantitySold = Integer.parseInt(request.getParameter("quantity_sold"));
            double pricePerUnit = Double.parseDouble(request.getParameter("price_per_unit"));
            double totalSaleAmount = quantitySold * pricePerUnit;

            stmt.setString(1, date);
            stmt.setString(2, productName);
            stmt.setInt(3, quantitySold);
            stmt.setDouble(4, pricePerUnit);
            stmt.setDouble(5, totalSaleAmount);

            stmt.executeUpdate();
            response.sendRedirect("salesTableAdmin.jsp");
        } catch (ClassNotFoundException | SQLException | NumberFormatException e) {
            handleError(response, "Error adding sale: " + e.getMessage());
        }
    }

    private void handleError(HttpServletResponse response, String errorMessage) throws IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html><head><title>Error</title></head><body>");
        out.println("<h3 style='color:red;'>" + errorMessage + "</h3>");
        out.println("<a href='salesTableAdmin.jsp'>Back to Sales Table</a>");
        out.println("</body></html>");
    }
}
