<%@ page import="java.sql.*, java.security.MessageDigest" %>
<%
    String personMessage = "", userMessage = "";

    // Save Person Details
    if (request.getParameter("submitPerson") != null) {
        String personId = request.getParameter("personId");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        String phoneNumber = request.getParameter("phoneNumber");

        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/auca_library", "root", "");
            PreparedStatement statement = connection.prepareStatement(
                "INSERT INTO Person (person_id, first_name, last_name, gender, phone_number) VALUES (?, ?, ?, ?, ?)"
            );
            statement.setString(1, personId);
            statement.setString(2, firstName);
            statement.setString(3, lastName);
            statement.setString(4, gender);
            statement.setString(5, phoneNumber);
            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                personMessage = "Person details saved successfully!";
            } else {
                personMessage = "Failed to save person details.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            personMessage = "Error: " + e.getMessage();
        }
    }

    // Save User Details
    if (request.getParameter("submitUser") != null) {
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String villageId = request.getParameter("villageId");

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
                "INSERT INTO Users (user_name, password, role, village_id) VALUES (?, ?, ?, ?)"
            );
            statement.setString(1, userName);
            statement.setString(2, hashedPassword);
            statement.setString(3, role);
            statement.setString(4, villageId);
            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                userMessage = "User details saved successfully!";
                response.sendRedirect("SignIn.jsp");
            } else {
                userMessage = "Failed to save user details.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            userMessage = "Error: " + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>
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
        <h3>Person Details</h3>
        Person ID: <input type="text" name="personId"><br>
        First Name: <input type="text" name="firstName"><br>
        Last Name: <input type="text" name="lastName"><br>
        Gender: <input type="text" name="gender"><br>
        Phone Number: <input type="text" name="phoneNumber"><br>
        <input type="submit" name="submitPerson" value="Submit Person"><br>
        <p><%= personMessage %></p>

        <h3>User Details</h3>
        User Name: <input type="text" name="userName"><br>
        Password: <input type="password" name="password"><br>
        Role: 
        <select name="role">
            <option value="STUDENT">STUDENT</option>
            <option value="MANAGER">MANAGER</option>
            <option value="TEACHER">TEACHER</option>
            <option value="DEAN">DEAN</option>
            <option value="HOD">HOD</option>
           
        </select><br>
        Village ID: <input type="text" name="villageId"><br>
        <input type="submit" name="submitUser" value="Submit User"><br>
        <p><%= userMessage %></p>
    </form>
</body>
</html>