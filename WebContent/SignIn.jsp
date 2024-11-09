<%@ page import="java.sql.*, java.security.MessageDigest" %>
<%
    String message = "";
    if (request.getParameter("submit") != null) {
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");

        // Hashing the password using MD5
        String hashedPassword = "";
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            hashedPassword = hexString.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/auca_library", "root", "");
            PreparedStatement statement = connection.prepareStatement(
                "SELECT role FROM Users WHERE user_name = ? AND password = ?"
            );
            statement.setString(1, userName);
            statement.setString(2, hashedPassword);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String role = resultSet.getString("role");
                switch (role) {
                    case "LIBRARIAN": response.sendRedirect("LibrarianPage.jsp"); break;
                    case "STUDENT": response.sendRedirect("StudentPage.jsp"); break;
                    case "MANAGER": response.sendRedirect("ManagerPage.jsp"); break;
                    case "TEACHER": response.sendRedirect("TeacherPage.jsp"); break;
                    case "DEAN": response.sendRedirect("DeanPage.jsp"); break;
                    case "HOD": response.sendRedirect("HODPage.jsp"); break;
                    default: message = "Invalid Role!";
                }
            } else {
                message = "Invalid user name or password!";
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Database error: " + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Sign In</title>
    <style>
   
        body {
            font-family: Arial, sans-serif;
            background-color: #1e3a8a; /* Dark Blue Background */
            color: white; /* White Text */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        /* Container */
        .container {
            background-color: #333; /* Darker Background for the Container */
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            padding: 30px;
            max-width: 500px;
            width: 100%;
            text-align: center;
        }

        /* Headings */
        h1 {
            color: white;
            margin-bottom: 20px;
        }

        /* Form Styles */
        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        /* Input Fields */
        input[type="text"], input[type="password"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            color: white;
            background-color: #555; /* Dark Gray Background for Inputs */
        }

        /* Button Styles */
        button {
            padding: 12px 20px;
            background-color: black; /* Black Button */
            border: none;
            color: white; /* White Text */
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
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

    <form method="post">
        User Name: <input type="text" name="userName"><br>
        Password: <input type="password" name="password"><br>
        <input type="submit" name="submit" value="Sign In">
    </form>
    <p><%= message %></p>
</body>
</html>