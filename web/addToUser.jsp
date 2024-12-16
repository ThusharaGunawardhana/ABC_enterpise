<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add User</title>
    <style>
        .container {
            margin: 20px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            width: 400px;
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
        <h1>Add User</h1>
        <form action="userController" method="post">
            <input type="hidden" name="action" value="add">
            
            <label for="email">Email:</label>
            <input type="email" name="email" required>
            
            <label for="firstname">First Name:</label>
            <input type="text" name="firstname" required>
            
            <label for="lastname">Last Name:</label>
            <input type="text" name="lastname" required>
            
            <label for="password">Password:</label>
            <input type="password" name="password" required>
            
            <label for="contact">Contact:</label>
            <input type="number" name="contact" required>
            
            <label for="role">Role:</label>
            <input type="text" name="role" required>
            
            <button type="submit">Add User</button>
        </form>
    </div>
</body>
</html>
