<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Inventory Table</title>
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
        function confirmDelete(productId) {
            if (confirm("Are you sure you want to delete this row?")) {
                // If confirmed, navigate to delete action with product_id
                window.location.href = "InventoryController?action=delete&product_id=" + productId;
            }
        }
    </script>

</head>
<body>
    <!-- Include navbar -->
    <jsp:include page="adminNav.jsp" />
    
    <!-- Inventory Table Content -->
    <div class="container">
        <!-- Header with "Sales Table" and "Add Product" button -->
        <div class="header">
            <h1>Inventory Table</h1>
            <a href="addToInventory.jsp" class="add-btn">Add data</a>
        </div><br>

<!--     Inventory Table Content 
    <div class="container">
        <h1>Inventory Table</h1>-->
        <% 
            // Initialize variables for database connection
            Connection connection = null;
            Statement statement = null;
            ResultSet resultSet = null;

            try {
                // Load JDBC Driver and connect to database
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/aspire_enterprises", "root", "");

                // Query to fetch inventory data
                String query = "SELECT * FROM inventory";
                statement = connection.createStatement();
                resultSet = statement.executeQuery(query);

        %>
        <table>
            <tr>
                <th>Product ID</th>
                <th>Product Name</th>
                <th>Category ID</th>
                <th>Stock Quantity</th>
                <th>Supplier Name</th>
                <th>Actions</th>
            </tr>
            <%
                boolean dataAvailable = false;
                while (resultSet.next()) {
                    dataAvailable = true;
            %>
            <tr>
                <td><%= resultSet.getInt("product_id") %></td>
                <td><%= resultSet.getString("product_name") %></td>
                <td><%= resultSet.getString("category_id") %></td>
                <td><%= resultSet.getInt("stock_quantity") %></td>
                <td><%= resultSet.getString("supplier_name") %></td>
                <td>
                    <!-- Edit Button -->
                    <a href="viewInventory.jsp?product_id=<%= resultSet.getInt("product_id") %>">
                        <button class="action-btn">Edit</button>
                    </a>
                    <!-- Delete Button -->
                    <button class="action-btn delete-btn" onclick="confirmDelete(<%= resultSet.getInt("product_id") %>)">
                        Delete
                    </button>
                </td>
            </tr>
            <%
                }
                if (!dataAvailable) {
            %>
            <tr>
                <td colspan="6">No inventory data available.</td>
            </tr>
            <%
                }
            } catch (Exception e) {
                out.println("<p class='message'>Error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (resultSet != null) resultSet.close();
                    if (statement != null) statement.close();
                    if (connection != null) connection.close();
                } catch (SQLException ex) {
                    out.println("<p class='message'>Error closing resources: " + ex.getMessage() + "</p>");
                }
            }
            %>
        </table>
    </div>
</body>
</html>
