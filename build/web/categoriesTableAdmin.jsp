<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Category Table</title>
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
        function confirmDelete(categoryId) {
            if (confirm("Are you sure you want to delete this category?")) {
                // If confirmed, submit the form with the category_id
                document.getElementById('deleteForm' + categoryId).submit();
            }
        }
    </script>
</head>
<body>
    <!-- Include navbar -->
    <jsp:include page="adminNav.jsp" />
    
    <!-- Category Table Content -->
    <div class="container">
        <div class="header">
            <h1>Category Table</h1>
            <a href="addToCategory.jsp" class="add-btn">Add data</a>
        </div><br>

        <% 
            // Initialize variables for database connection
            Connection connection = null;
            Statement statement = null;
            ResultSet resultSet = null;

            try {
                // Load JDBC Driver and connect to database
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/aspire_enterprises", "root", "");

                // Query to fetch categories data
                String query = "SELECT * FROM categories";
                statement = connection.createStatement();
                resultSet = statement.executeQuery(query);

        %>
        <table>
            <tr>
                <th>Category ID</th>
                <th>Category Name</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
            <%
                boolean dataAvailable = false;
                while (resultSet.next()) {
                    dataAvailable = true;
                    int categoryId = resultSet.getInt("category_id");
            %>
            <tr>
                <td><%= categoryId %></td>
                <td><%= resultSet.getString("category_name") %></td>
                <td><%= resultSet.getString("description") %></td>
                <td>
                    <!-- Edit Button -->
                    <a href="viewcategory.jsp?category_id=<%= categoryId %>">
                        <button class="action-btn">Edit</button>
                    </a>

                    <!-- Delete Button (using POST inside form) -->
                    <form id="deleteForm<%= categoryId %>" action="CategoryController" method="POST" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="category_id" value="<%= categoryId %>">
                        <button type="button" class="action-btn delete-btn" onclick="confirmDelete(<%= categoryId %>)">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                }
                if (!dataAvailable) {
            %>
            <tr>
                <td colspan="6">No categories available.</td>
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
