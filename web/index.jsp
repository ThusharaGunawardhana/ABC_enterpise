<%-- 
    Document   : index
    Created on : Nov 12, 2024, 9:45:30 AM
    Author     : Thushara
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <style>
            /* Basic styling for the buttons */
            .button {
                padding: 10px 20px;
                font-size: 16px;
                margin: 10px;
                color: white;
                background-color: #4CAF50;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
            }
            .button:hover {
                background-color: #45a049;
            }
            .container {
                text-align: center;
                margin-top: 50px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Welcome to the ABC Enterprise Home Page!</h1>
            <a href="signup.jsp" class="button">Sign Up</a>
            <a href="signin.jsp" class="button">Sign In</a>
        </div>
    </body>
</html>
