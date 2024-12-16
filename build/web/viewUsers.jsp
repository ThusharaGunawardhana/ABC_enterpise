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
        <form action="userController" method="post">
            <% 
                // Get the product_id from the query string
                int userId = Integer.parseInt(request.getParameter("id"));
                Connection connection = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/aspire_enterprises", "root", "");
                    String query = "SELECT * FROM user WHERE id = ?";
                    stmt = connection.prepareStatement(query);
                    stmt.setInt(1, userId);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        String useremail = rs.getString("email");
                        String Firstname = rs.getString("firstname");
                        String lastName = rs.getString("lastname");
                        int Usercontact = rs.getInt("contact");
                        String Role = rs.getString("role");
            %>
        
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= userId %>">

            <label for="email">User Email:</label>
            <input type="text" name="email" value="<%= useremail %>">

            <label for="firstname">First Name:</label>
            <input type="text" name="firstname" value="<%= Firstname %>">

            <label for="lastname">Last Name:</label>
            <input type="text" name="lastname" value="<%= lastName %>">

            <label for="password">Password:</label>
            <input type="password" name="password" value="<%= rs.getString("password") %>">

            <label for="contact">Contact:</label>
            <input type="text" name="contact" value="<%= Usercontact %>">

            <label for="role">Role:</label>
            <input type="text" name="role" value="<%= Role %>">

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
