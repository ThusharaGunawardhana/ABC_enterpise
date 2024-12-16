<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sales Table</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            margin: 20px auto;
            max-width: 900px;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h1 {
            margin: 0;
        }
        .add-btn {
            padding: 10px 15px;
            background-color: #66ffff;
            color: black;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .add-btn:hover {
            background-color: #0099ff;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        .message {
            color: red;
            font-weight: bold;
        }
        .action-btn {
            padding: 5px 10px;
            margin: 5px;
            background-color: blue;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .delete-btn {
            background-color: #f44336;
        }
    </style>
    <script>
        // Function to confirm deletion
        function confirmDelete(saleId) {
            if (confirm("Are you sure you want to delete this row?")) {
                // If confirmed, navigate to delete action
                window.location.href = "SalesController?action=delete&sale_id=" + saleId;
            }
        }
    </script>
</head>
<body>
    <!-- Include navbar -->
    <jsp:include page="adminNav.jsp" />

    <!-- Sales Table Content -->
    <div class="container">
        <!-- Header with "Sales Table" and "Add Product" button -->
        <div class="header">
            <h1>Sales Table</h1>
            <a href="addToSales.jsp" class="add-btn">Add Product</a>
        </div><br>
        
        <%
            // Database connection setup
            Connection connection = null;
            Statement statement = null;
            ResultSet resultSet = null;
            try {
                Class.forName("com.mysql.jdbc.Driver"); // Ensure you're using the latest driver
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/aspire_enterprises", "root", "");
                statement = connection.createStatement();
                resultSet = statement.executeQuery("SELECT * FROM sales");
        %>
        <!-- Sales Data Table -->
        <table>
            <tr>
                <th>Sale ID</th>
                <th>Date</th>
                <th>Product Name</th>
                <th>Quantity Sold</th>
                <th>Price Per Unit</th>
                <th>Total Sale Amount</th>
                <th>Actions</th>
            </tr>
            <%
                boolean dataAvailable = false;
                while (resultSet.next()) {
                    dataAvailable = true;
            %>
            <tr>
                <td><%= resultSet.getInt("sale_id") %></td>
                <td><%= resultSet.getDate("date") %></td>
                <td><%= resultSet.getString("product_name") %></td>
                <td><%= resultSet.getInt("quantity_sold") %></td>
                <td><%= resultSet.getDouble("price_per_unit") %></td>
                <td><%= resultSet.getDouble("total_sale_amount") %></td>
                <td>
                    <!-- Edit Button -->
                    <a href="viewSales.jsp?sale_id=<%= resultSet.getInt("sale_id") %>">
                        <button class="action-btn">Edit</button>
                    </a>
                    <!-- Delete Button with Confirmation -->
                    <button class="action-btn delete-btn" onclick="confirmDelete(<%= resultSet.getInt("sale_id") %>)">
                        Delete
                    </button>
                </td>
            </tr>
            <%
                }
                if (!dataAvailable) {
            %>
            <tr>
                <td colspan="7">No sales data available.</td>
            </tr>
            <%
                }
            } catch (Exception e) {
                out.println("<p class='message'>Error: " + e.getMessage() + "</p>");
            } finally {
                // Close resources
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            }
            %>
        </table>
    </div>
</body>
</html>
