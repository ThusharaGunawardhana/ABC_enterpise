<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Categories Table</title>
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

        <!-- Categories Table Content -->
        <div class="container">
            <h1>Categories Table</h1>
            <%
                // Database connection setup
                Connection connection = null;
                Statement statement = null;
                ResultSet resultSet = null;
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/aspire_enterprises", "root", "");
                    statement = connection.createStatement();
                    resultSet = statement.executeQuery("SELECT * FROM categories");
            %>
            <!-- Categories Data Table -->
            <table>
                <tr>
<!--                    <th>Category ID</th>-->
                    <th>Category Name</th>
                    <th>Description</th>
                </tr>
                <%
                    boolean dataAvailable = false;
                    while (resultSet.next()) {
                        dataAvailable = true;
                %>
                <tr>
<!--                    <td><%= resultSet.getInt("category_id") %></td>-->
                    <td><%= resultSet.getString("category_name") %></td>
                    <td><%= resultSet.getString("description") %></td>
                </tr>
                <%
                    }
                    if (!dataAvailable) {
                %>
                <tr>
                    <td colspan="3">No category data available.</td>
                </tr>
                <%
                    }
                } catch (Exception e) {
                    out.println("<p class='message'>Error: " + e.getMessage() + "</p>");
                } finally {
                    if (resultSet != null) resultSet.close();
                    if (statement != null) statement.close();
                    if (connection != null) connection.close();
                }
                %>
            </table>
        </div>
    </body>
</html>
