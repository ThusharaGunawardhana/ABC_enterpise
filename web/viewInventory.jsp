<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Inventory</title>
    <style>
        /* Add some form styling */
        .container {
            margin: 20px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        label, input {
            margin: 10px 0;
            padding: 10px;
            width: 100%;
            box-sizing: border-box;
        }
        button[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <jsp:include page="adminNav.jsp" />

    <div class="container">
        <h1>Edit Inventory Item</h1>
        <form action="InventoryController" method="post">
            <% 
                // Get the product_id from the query string
                int productId = Integer.parseInt(request.getParameter("product_id"));
                Connection connection = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/aspire_enterprises", "root", "");
                    String query = "SELECT * FROM inventory WHERE product_id = ?";
                    stmt = connection.prepareStatement(query);
                    stmt.setInt(1, productId);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        String productName = rs.getString("product_name");
                        String categoryId = rs.getString("category_id");
                        int stockQuantity = rs.getInt("stock_quantity");
                        String supplierName = rs.getString("supplier_name");
            %>
        
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="product_id" value="<%= productId %>">
            <label for="product_name">Product Name:</label>
            <input type="text" name="product_name" value="<%= productName %>">
            
            <label for="category_id">Category ID:</label>
            <input type="text" name="category_id" value="<%= categoryId %>">
            
            <label for="stock_quantity">Stock Quantity:</label>
            <input type="number" name="stock_quantity" value="<%= stockQuantity %>">
            
            <label for="supplier_name">Supplier Name:</label>
            <input type="text" name="supplier_name" value="<%= supplierName %>">

            <button type="submit">Save Changes</button>
        
            <% 
                    }
                } catch (SQLException e) {
                    out.println("Error fetching data: " + e.getMessage());
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (connection != null) connection.close();
                    } catch (SQLException ex) {
                        out.println("Error closing resources: " + ex.getMessage());
                    }
                }
            %>
        </form>
    </div>
</body>
</html>
