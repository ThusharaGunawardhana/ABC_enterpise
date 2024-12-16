<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Home</title>
    <style>
        /* Global styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }

        .container {
            padding: 30px;
            text-align: center;
        }

        .container h1 {
            font-size: 36px;
            color: #333;
            margin-bottom: 20px;
        }

        .container p {
            font-size: 18px;
            color: #666;
        }

        .admin-dashboard {
            display: flex;
            justify-content: space-around;
            margin-top: 30px;
        }

        .admin-dashboard .box {
            background-color: #fff;
            border: 1px solid #ddd;
            padding: 20px;
            width: 30%;
            text-align: center;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .admin-dashboard .box h3 {
            font-size: 24px;
            color: #333;
            margin-bottom: 10px;
        }

        .admin-dashboard .box p {
            font-size: 16px;
            color: #777;
        }

        .admin-dashboard .box:hover {
            box-shadow: 0px 8px 12px rgba(0, 0, 0, 0.2);
        }

        footer {
            text-align: center;
            margin-top: 40px;
            padding: 20px;
            background-color: #333333;
            color: white;
        }
    </style>
</head>
<body>
    <!-- Include the navigation bar -->
    <jsp:include page="adminNav.jsp" />

    <div class="container">
        <h1>Admin Dashboard</h1>
        <p>Manage and control the platform as an admin.</p>

        <div class="admin-dashboard">
            <div class="box">
                <h3>Manage Users</h3>
                <p>View and manage user accounts.</p>
                <a href="usersTable.jsp">Go to Users</a>
            </div>
            <div class="box">
                <h3>System Settings</h3>
                <p>Update platform settings.</p>
                <a href="settings.jsp">Go to Settings</a>
            </div>
            <div class="box">
                <h3>Reports</h3>
                <p>Generate platform reports.</p>
                <a href="downloadReport.jsp">View Reports</a>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 Aspire Enterprises. All Rights Reserved.</p>
    </footer>
</body>
</html>
