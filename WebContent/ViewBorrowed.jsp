<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>View Borrowed Books</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #1e3a8a; /* Dark Blue Background */
            color: white; /* White Text */
            margin: 20px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .container {
            background-color: #333; /* Darker Background */
            border-radius: 8px;
            padding: 20px;
            max-width: 800px;
            margin: auto;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #444; /* Dark Gray Borders */
            padding: 10px;
            text-align: center;
            color: white; /* White Text */
        }
        th {
            background-color: #444; /* Dark Gray Header Background */
        }
        tr:nth-child(even) {
            background-color: #555; /* Alternate Row Color */
        }
        tr:hover {
            background-color: #666; /* Row Hover Effect */
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Borrowed Books</h2>

        <!-- Table to display borrowed books -->
        <table border="1">
            <thead>
                <tr>
                    <th>Book ID</th>
                    <th>Fine</th>
                    <th>Late Charge Fees</th>
                    <th>Pickup Date</th>
                    <th>Return Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/auca_library", "root", "");
                        Statement statement = connection.createStatement();
                        ResultSet resultSet = statement.executeQuery("SELECT * FROM borrower");

                        while (resultSet.next()) {
                            out.println("<tr>");
                            out.println("<td>" + resultSet.getString("book_id") + "</td>");
                            out.println("<td>" + resultSet.getDouble("fine") + "</td>");
                            out.println("<td>" + resultSet.getDouble("late_charge_fees") + "</td>");
                            out.println("<td>" + resultSet.getDate("pickup_date") + "</td>");
                            out.println("<td>" + resultSet.getDate("return_date") + "</td>");
                            out.println("</tr>");
                        }
                        connection.close();
                    } catch (SQLException e) {
                        out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
