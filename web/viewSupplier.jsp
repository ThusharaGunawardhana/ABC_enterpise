<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Supplier</title>
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
        input[type="text"], input[type="number"] {
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
            <h1>Edit Supplier</h1>
        </div>

        <% 
            String supplierId = request.getParameter("supplier_id");
            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/aspire_enterprises", "root", "");
                String query = "SELECT * FROM suppliers WHERE supplier_id = ?";
                statement = connection.prepareStatement(query);
                statement.setInt(1, Integer.parseInt(supplierId));
                resultSet = statement.executeQuery();
                
                if (resultSet.next()) {
                    String supplierName = resultSet.getString("supplier_name");
                    String contact = resultSet.getString("contact");
        %>
        
        <form action="supplierController" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="supplier_id" value="<%= supplierId %>">
            
            <label for="supplier_name">Supplier Name:</label>
            <input type="text" id="supplier_name" name="supplier_name" value="<%= supplierName %>" required>
            
            <label for="contact">Contact:</label>
            <input type="number" id="contact" name="contact" value="<%= contact %>" required>
            
            <button type="submit" class="submit-btn">save changes</button>
        </form>

        <% 
                } else {
                    out.println("<p>Supplier not found!</p>");
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
