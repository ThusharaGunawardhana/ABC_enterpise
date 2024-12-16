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
                max-width: 800px;
                padding: 20px;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
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
        </style>
    </head>
    <body>
        <!-- Include navbar -->
        <jsp:include page="navbar.jsp" />

        <!-- Inventory Table Content -->
        <div class="container">
            <h1>Inventory Table</h1>
            <% 
                // Initialize variables for database connection
                Connection connection = null;
                Statement statement = null;
                ResultSet resultSet = null;

                try {
                    //  connect to database
                    Class.forName("com.mysql.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/aspire_enterprises", "root", "");

                    // Use the view to fetch inventory data
                    String query = "SELECT * FROM inventory_with_categories";
                    statement = connection.createStatement();
                    resultSet = statement.executeQuery(query);
            %>
            <table>
                <tr>
                    <th>Product Name</th>
                    <th>Category Name</th>
                    <th>Stock Quantity</th>
                    <th>Supplier Name</th>
                </tr>
                <%
                    boolean dataAvailable = false; // Flag to check if data exists
                    while (resultSet.next()) {
                        dataAvailable = true;
                %>
                <tr>
                    <td><%= resultSet.getString("product_name") %></td>
                    <td><%= resultSet.getString("category_name") %></td>
                    <td><%= resultSet.getInt("stock_quantity") %></td>
                    <td><%= resultSet.getString("supplier_name") %></td>
                </tr>
                <%
                    }
                    if (!dataAvailable) {
                %>
                <tr>
                    <td colspan="4">No inventory data available.</td>
                </tr>
                <%
                    }
                } catch (Exception e) {
                    out.println("<p class='message'>Error: " + e.getMessage() + "</p>");
                } finally {
                    // Close database resources
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
