<%@ page language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #1e3a8a; /* Dark Blue Background */
            color: white; /* White Text */
            margin: 0;
            padding: 0;
        }

        h2 {
            color: white;
            text-align: center;
            margin-top: 50px;
            font-size: 30px;
        }

        /* Container for Buttons */
        .button-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 50px;
        }

        /* Input Fields */
        input[type="text"], input[type="password"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            color: white;
            background-color: #555; /* Dark Gray Background for Inputs */
            margin-bottom: 20px;
            width: 250px;
        }

        /* Button Styles */
        input[type="submit"] {
            padding: 12px 20px;
            background-color: black; /* Black Button */
            border: none;
            color: white; /* White Text */
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #444; /* Darker Button Hover */
        }

        /* Links */
        a {
            color: #007bff;
            text-decoration: none;
            transition: color 0.3s;
        }

        a:hover {
            color: #0056b3;
        }

        /* Additional Styling */
        hr {
            border: none;
            border-top: 1px solid #555;
            margin: 20px 0;
        }

        /* Table Style */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid black; /* Black Table Borders */
        }

        th, td {
            padding: 10px;
            text-align: left;
            color: white; /* White Text for Table */
        }

        th {
            background-color: #444; /* Dark Gray for Header Cells */
        }

        tr:nth-child(even) {
            background-color: #555; /* Alternate Row Colors */
        }

        tr:hover {
            background-color: #666; /* Hover Effect for Rows */
        }
    </style>
</head>
<body>
    <h2>Welcome to the Library Home Page</h2>

    <!-- Buttons to navigate to SignIn and SignUp -->
    <div class="button-container">
        <form action="SignIn.jsp" method="get">
            <input type="submit" value="Sign In">
        </form>

        <form action="SignUp.jsp" method="get">
            <input type="submit" value="Sign Up">
        </form>
    </div>

    <hr>

    <!-- Additional Content (e.g., Table or Features) -->
    <!-- Add any extra sections or tables as needed below -->
</body>
</html>
