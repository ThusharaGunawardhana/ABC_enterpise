<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Category</title>
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
            <h1>Add New Category</h1>
        </div>

        <form action="CategoryController" method="post">
            <input type="hidden" name="action" value="add">
            
            <label for="category_name">Category Name:</label>
            <input type="text" id="category_name" name="category_name" required>
            
            <label for="description">Description:</label>
            <textarea id="description" name="description" required></textarea>
            
            <button type="submit" class="submit-btn">Add Category</button>
        </form>
    </div>
</body>
</html>
