<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f9f9f9;
            }
            /* Navbar styles */
            .navbar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #333333;
                color: white;
                padding: 10px 20px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .navbar .logo {
                font-size: 20px;
                font-weight: bold;
            }
            .navbar .nav-links {
                display: flex;
                align-items: center;
            }
            .navbar .nav-links span {
                margin-right: 20px;
                font-size: 16px;
            }
            .navbar .logout-btn {
                padding: 8px 15px;
                font-size: 14px;
                color: #007BFF;
                background-color: white;
                border: 1px solid #007BFF;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                transition: all 0.3s;
            }
            .navbar .logout-btn:hover {
                background-color: #66ccff;
                color: white;
            }
            /* Container for the rest of the content */
            .container {
                max-width: 800px;
                margin: 50px auto;
                padding: 20px;
                background-color: #fff;
                border: 1px solid #ccc;
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                text-align: center;
            }
        </style>
    </head>
    <body>
        <% 
            // Fetch session object
            String firstname = (String) session.getAttribute("firstname");
            String email = (String) session.getAttribute("email");

            if (firstname != null && email != null) {
        %>
        <!-- Include navbar -->
        <jsp:include page="navbar.jsp" />

        <!-- Main Container -->
        <div class="container">
            <h1>Welcome, <%= firstname %>!</h1>
            <p>Your email: <%= email %></p>
            <p>Use the navigation bar above to explore features or log out.</p>
        </div>
        <% 
            } else { 
        %>
        <!-- If session is invalid -->
        <div class="container">
            <h1>Session Expired</h1>
            <p>Please <a href="signin.jsp">sign in</a> to continue.</p>
        </div>
        <% 
            } 
        %>
    </body>
</html>
