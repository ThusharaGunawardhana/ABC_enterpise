<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Check if session exists and retrieve role
    String role = (session != null) ? (String) session.getAttribute("role") : null;
    String firstname = (session != null) ? (String) session.getAttribute("firstname") : null;

    // Redirect to login page if session is invalid
    if (firstname == null) {
        response.sendRedirect("signin.jsp");
    }
%>
<nav>
    <style>
        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #333333;
            color: white;
            padding: 15px 30px;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin-right: 20px;
            font-size: 16px;
        }

        nav a:hover {
            background-color: #66ccff;
            padding: 5px 10px;
            border-radius: 5px;
        }

        nav .welcome {
            font-size: 18px;
            font-weight: bold;
        }

        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
            min-width: 150px;
            z-index: 1;
            border-radius: 5px;
            right: 0;
        }

        .dropdown-content a {
            color: black;
            padding: 10px 15px;
            text-decoration: none;
            display: block;
            font-size: 14px;
        }

        .dropdown-content a:hover {
            background-color: #ddd;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .dropdown:hover > a {
            background-color: #66ccff;
            border-radius: 5px;
        }
    </style>
    <div>
        <a href="home.jsp">Home</a>
        <% if ("admin".equalsIgnoreCase(role)) { %>
            <a href="adminhome.jsp">Admin Home</a>
        <% } %>
        <!-- Dropdown Menu for Sales and Inventory -->
        <div class="dropdown">
            <a href="#">Tables</a>
            <div class="dropdown-content">
                <a href="salesTableAdmin.jsp">Sales</a>
                <a href="inventoryTableAdmin.jsp">Inventory</a>
                <a href="supplierTableAdmin.jsp">Suppliers</a>
                <a href="categoriesTableAdmin.jsp">categories</a>
            </div>
        </div>
        <div class="dropdown">
            <a href="#">Charts</a>
            <div class="dropdown-content">
                <a href="salesChart.jsp">Total Amount of Sales</a>
<!--                <a href="lineChart.jsp">Business progress</a>-->
            </div>
        </div>
    </div>
    <div>
        <span class="welcome">Welcome, <%= firstname %>!</span>
        <a href="logoutcontroller">Logout</a>
    </div>
</nav>
