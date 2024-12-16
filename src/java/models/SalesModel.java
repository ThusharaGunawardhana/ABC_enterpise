package models;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SalesModel {

    // Method to retrieve monthly sales data and convert it to JSON
    public String getMonthlySalesData() {
        List<String> months = new ArrayList<>();
        List<Double> totalSales = new ArrayList<>();

        try {
            // Database connection details
            String url = "jdbc:mysql://localhost:3306/aspire_enterprises";
            String username = "root";
            String password = "";

            // SQL query to group sales by month and sum total sale amounts
            try (Connection conn = DriverManager.getConnection(url, username, password)) {
                String query = "SELECT DATE_FORMAT(date, '%Y-%m') AS month, SUM(total_sale_amount) AS total_sales " +
                               "FROM sales GROUP BY DATE_FORMAT(date, '%Y-%m') ORDER BY month";

                PreparedStatement ps = conn.prepareStatement(query);
                ResultSet rs = ps.executeQuery();

                // Add query results to lists
                while (rs.next()) {
                    months.add(rs.getString("month"));
                    totalSales.add(rs.getDouble("total_sales"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Convert data to JSON using Gson
        JsonArray jsonArray = new JsonArray();
        for (int i = 0; i < months.size(); i++) {
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("month", months.get(i));
            jsonObject.addProperty("totalSales", totalSales.get(i));
            jsonArray.add(jsonObject);
        }

        return jsonArray.toString();
    }
}
