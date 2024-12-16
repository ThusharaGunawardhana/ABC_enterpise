<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <style>
            /* Navbar CSS */
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
                position: relative;
            }
            .navbar .nav-links a {
                margin-right: 15px;
                text-decoration: none;
                color: white;
                font-size: 16px;
            }
            .navbar .nav-links a:hover {
                text-decoration: underline;
                background-color: #66ccff;
                padding: 5px 10px;
                border-radius: 5px;
            }
            /* Dropdown CSS */
            .dropdown {
                position: relative;
                display: inline-block;
            }
            .dropdown .dropbtn {
                background-color: #333333;
                color: white;
                border: none;
                cursor: pointer;
                font-size: 16px;
                padding: 10px;
                margin-right: 15px;
                text-align: center;
            }
            .dropdown .dropbtn:hover {
                background-color: #66ccff;
                padding: 5px 10px;
                border-radius: 5px;
            }
            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #333333;
                min-width: 150px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
                z-index: 1;
                border-radius: 5px;
            }
            .dropdown-content a {
                color: black;
                padding: 10px;
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
            /* Logout Button */
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
        </style>

        <script>
            // Function to confirm logout action
            function confirmLogout(event) {
                event.preventDefault(); // Prevent the form from submitting immediately
                if (confirm("Are you sure you want to log out?")) {
                    document.getElementById('logoutForm').submit(); // Submit the form if confirmed
                }
            }
        </script>
    </head>
    <body>
        <div class="navbar">
            <div class="logo">Aspire Enterprises</div>
            <div class="nav-links">
                <a href="home.jsp">Home</a>
                
                <!-- Dropdown Menu -->
                <div class="dropdown">
                    <button class="dropbtn">Reports</button>
                    <div class="dropdown-content">
                        <a href="salesTable.jsp">Sales</a>
                        <a href="inventoryTable.jsp">Inventory</a>
                        <a href="categoriesTable.jsp">Categories</a>
                        <a href="supplierTable.jsp">Suppliers</a>
                    </div>
                </div>

                <% 
                    // Use the implicit `session` object to check for user data
                    String email = (String) session.getAttribute("email");
                    if (email != null) { 
                %>
                    <span>Welcome, <%= email %></span>
                    <!-- Form for logout with confirmation -->
                    <form id="logoutForm" action="logoutcontroller" method="post" style="display: inline;">
                        <button type="button" class="logout-btn" onclick="confirmLogout(event)">Logout</button>
                    </form>
                <% } else { %>
                    <a href="signin.jsp">Sign In</a>
                <% } %>
            </div>
        </div>
    </body>
</html>
