package models;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReportGenerator {

    // Inner class for Sales Data
    public static class SalesData {
        public String productName;
        public int quantitySold;
        public int totalSaleAmount;
        public String date;
    }

    // Inner class for Inventory Data
    public static class InventoryData {
        public String productName;
        public int stockQuantity;
        public String supplierName;
    }

    // Method to fetch sales data
    public List<SalesData> getSalesData() {
        List<SalesData> salesDataList = new ArrayList<>();
        try {
            // Establish a database connection
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/aspire_enterprises", "root", ""
            );

            // Query to fetch all sales data
            String query = "SELECT product_name, quantity_sold, total_sale_amount, date FROM sales";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            // Process result set
            while (rs.next()) {
                SalesData data = new SalesData();
                data.productName = rs.getString("product_name");
                data.quantitySold = rs.getInt("quantity_sold");
                data.totalSaleAmount = rs.getInt("total_sale_amount");
                data.date = rs.getString("date");
                salesDataList.add(data);
            }
        } catch (SQLException e) {
        }
        return salesDataList;
    }

    // Method to fetch inventory data
    public List<InventoryData> getInventoryData() {
        List<InventoryData> inventoryDataList = new ArrayList<>();
        try {
            // Establish a database connection
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/aspire_enterprises", "root", ""
            );

            // Query to fetch all inventory data
            String query = "SELECT product_name, stock_quantity, supplier_name FROM inventory";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            // Process result set
            while (rs.next()) {
                InventoryData data = new InventoryData();
                data.productName = rs.getString("product_name");
                data.stockQuantity = rs.getInt("stock_quantity");
                data.supplierName = rs.getString("supplier_name");
                inventoryDataList.add(data);
            }
        } catch (SQLException e) {
        }
        return inventoryDataList;
    }
}
