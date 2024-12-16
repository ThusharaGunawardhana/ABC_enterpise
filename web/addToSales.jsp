<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Sale</title>
    <style>
        /* Reuse the CSS styles from viewSales.jsp */
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
        h1 {
            margin: 0;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
        .form-group input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        .form-group input[type="submit"]:hover {
            background-color: #45a049;
        }
        .form-group input[type="button"] {
            background-color: #f44336;
            color: white;
            border: none;
            cursor: pointer;
        }
        .form-group input[type="button"]:hover {
            background-color: #e53935;
        }
    </style>
</head>
<body>
    <!-- Include navbar -->
    <jsp:include page="adminNav.jsp" />

    <!-- Add Sale Form -->
    <div class="container">
        <h1>Add Sale</h1>
        <form action="SalesController?action=add" method="POST">
            <div class="form-group">
                <label for="date">Date</label>
                <!-- Set the minimum date to the current date -->
                <input type="date" id="date" name="date" required min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" />
            </div>
            <div class="form-group">
                <label for="product_name">Product Name</label>
                <input type="text" id="product_name" name="product_name" required />
            </div>
            <div class="form-group">
                <label for="quantity_sold">Quantity Sold</label>
                <input type="number" id="quantity_sold" name="quantity_sold" required />
            </div>
            <div class="form-group">
                <label for="price_per_unit">Price Per Unit</label>
                <input type="number" id="price_per_unit" name="price_per_unit" required />
            </div>
            <div class="form-group">
                <input type="submit" value="Save" />
                <input type="button" value="Cancel" onclick="window.location.href='salesTableAdmin.jsp'" />
            </div>
        </form>
    </div>
</body>
</html>
