<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Sale</title>
    <style>
        .container {
            margin: 20px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        label, input {
            display: block;
            margin: 10px 0;
            padding: 10px;
            width: 100%;
            box-sizing: border-box;
        }
        button[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 15px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <jsp:include page="adminNav.jsp" />

    <div class="container">
        <h1>Edit Sale</h1>
        <form action="SalesController" method="post">
            <%
                int saleId = Integer.parseInt(request.getParameter("sale_id"));
                Connection connection = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/aspire_enterprises", "root", "");
                    String query = "SELECT * FROM sales WHERE sale_id = ?";
                    stmt = connection.prepareStatement(query);
                    stmt.setInt(1, saleId);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        String productName = rs.getString("product_name");
                        int quantitySold = rs.getInt("quantity_sold");
                        double pricePerUnit = rs.getDouble("price_per_unit");
                        double totalSaleAmount = rs.getDouble("total_sale_amount");
            %>

            <input type="hidden" name="action" value="update">
            <input type="hidden" name="sale_id" value="<%= saleId %>">
            
            <label for="product_name">Product Name:</label>
            <input type="text" name="product_name" value="<%= productName %>">
            
            <label for="quantity_sold">Quantity Sold:</label>
            <input type="number" name="quantity_sold" value="<%= quantitySold %>">
            
            <label for="price_per_unit">Price Per Unit:</label>
            <input type="text" name="price_per_unit" value="<%= pricePerUnit %>">
            
            <label for="total_sale_amount">Total Sale Amount:</label>
            <input type="text" name="total_sale_amount" value="<%= totalSaleAmount %>">
            
            <button type="submit">Save Changes</button>

            <%
                    }
                } catch (SQLException e) {
                    out.println("Error fetching data: " + e.getMessage());
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (connection != null) connection.close();
                }
            %>
        </form>
    </div>
</body>
</html>
