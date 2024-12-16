<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Download Business Report</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
        }
        .container {
            width: 50%;
            margin: auto;
            text-align: center;
            background: #fff;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        h1 {
            color: #333;
        }
        p {
            color: #555;
            font-size: 16px;
            margin: 20px 0;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            border-radius: 5px;
        }
        button:hover {
            background-color: #45a049;
        }
        input[type="month"] {
            font-size: 16px;
            padding: 10px;
            margin: 10px 0;
            width: 200px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
    </style>
</head>
<body>
    <jsp:include page="adminNav.jsp" />
    <div class="container">
        <h1>Download Business Report</h1>
        <p>Select the month to generate the report:</p>
        
        <!-- Form to select the month and submit -->
        <form action="DownloadReportServlet" method="get">
            <!-- Month input field, the 'required' ensures user must select a month -->
            <input type="month" name="reportMonth" required />
            <button type="submit">Download Report</button>
        </form>
    </div>
</body>
</html>
