<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Supplier</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            margin: 20px auto;
            max-width: 500px;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .submit-btn {
            background-color: #66ffff;
            color: black;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .submit-btn:hover {
            background-color: #0099ff;
        }
    </style>
</head>
<body>
    <!-- Include navbar -->
    <jsp:include page="adminNav.jsp" />
    
    <div class="container">
        <h1>Add New Supplier</h1>
        <form action="supplierController?action=add" method="POST">
            <div class="form-group">
                <label for="supplierName">Supplier Name</label>
                <input type="text" id="supplierName" name="supplierName" required />
            </div>
            <div class="form-group">
                <label for="contact">Contact</label>
                <input type="number" id="contact" name="contact" required />
            </div>
            <button type="submit" class="submit-btn">Add Supplier</button>
        </form>
    </div>
</body>
</html>
