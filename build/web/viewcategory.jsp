<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Category</title>
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
        .header h1 {
            margin: 0;
        }
        label {
            font-size: 18px;
            margin-bottom: 10px;
            display: block;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            margin: 5px 0 15px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .submit-btn {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: black;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .submit-btn:hover {
            background-color: #4CAF50;
        }
    </style>
</head>
<body>
    <jsp:include page="adminNav.jsp" />
    
    <div class="container">
        <div class="header">
            <h1>Edit Category</h1>
        </div>

        <% 
            String categoryId = request.getParameter("category_id");
            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/aspire_enterprises", "root", "");
                String query = "SELECT * FROM categories WHERE category_id = ?";
                statement = connection.prepareStatement(query);
                statement.setInt(1, Integer.parseInt(categoryId));
                resultSet = statement.executeQuery();
                
                if (resultSet.next()) {
                    String categoryName = resultSet.getString("category_name");
                    String description = resultSet.getString("description");
        %>
        
        <form action="CategoryController" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="category_id" value="<%= categoryId %>">
            
            <label for="category_name">Category Name:</label>
            <input type="text" id="category_name" name="category_name" value="<%= categoryName %>" required>
            
            <label for="description">Description:</label>
            <textarea id="description" name="description" required><%= description %></textarea>
            
            <button type="submit" class="submit-btn">Save Changes</button>
        </form>

        <% 
                } else {
                    out.println("<p>Category not found!</p>");
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (resultSet != null) resultSet.close();
                    if (statement != null) statement.close();
                    if (connection != null) connection.close();
                } catch (SQLException ex) {
                    out.println("<p>Failed to close resources: " + ex.getMessage() + "</p>");
                }
            }
        %>
    </div>
</body>
</html>
