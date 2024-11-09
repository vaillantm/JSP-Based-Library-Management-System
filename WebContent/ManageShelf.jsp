<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Manage Shelf</title>
    <style>
        /* General Styles */
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
            background-color: #333; /* Darker Background for Form and Table */
            border-radius: 8px;
            padding: 20px;
            max-width: 800px;
            margin: auto;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
        form {
            margin-bottom: 20px;
            display: grid;
            grid-template-columns: auto 1fr;
            gap: 10px;
        }
        input[type="text"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            color: white;
            background-color: #555; /* Dark Gray Background for Inputs */
        }
        input[type="submit"] {
            padding: 10px 15px;
            background-color: black; /* Black Button */
            border: none;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #444; /* Darker Button Hover */
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
            color: white; /* White Text for Table Cells */
        }
        th {
            background-color: #444; /* Dark Gray Header Background */
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
    <div class="container">
        <h2>Manage Shelf</h2>
        <form method="post" action="ManageShelf.jsp">
            <label>Room ID:</label>
            <input type="text" name="roomId">
            <label>Category:</label>
            <input type="text" name="category">
            <label>Available Stock:</label>
            <input type="text" name="availableStock">
            <label>Borrowed Number:</label>
            <input type="text" name="borrowedNumber">
            <label>Initial Stock:</label>
            <input type="text" name="initialStock">
            <input type="submit" name="addShelf" value="Add Shelf">
            <input type="submit" name="updateShelf" value="Update Shelf">
        </form>

        <!-- Table to display shelves -->
        <table>
            <thead>
                <tr>
                    <th>Room ID</th>
                    <th>Category</th>
                    <th>Available Stock</th>
                    <th>Borrowed Number</th>
                    <th>Initial Stock</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/auca_library", "root", "");
                        Statement statement = connection.createStatement();
                        ResultSet resultSet = statement.executeQuery("SELECT * FROM shelf");

                        while (resultSet.next()) {
                            out.println("<tr>");
                            out.println("<td>" + resultSet.getInt("room_id") + "</td>");
                            out.println("<td>" + resultSet.getString("category") + "</td>");
                            out.println("<td>" + resultSet.getInt("available_stock") + "</td>");
                            out.println("<td>" + resultSet.getInt("borrowed_number") + "</td>");
                            out.println("<td>" + resultSet.getInt("initial_stock") + "</td>");
                            out.println("</tr>");
                        }
                        connection.close();
                    } catch (SQLException e) {
                        out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>

        <%
            if (request.getParameter("addShelf") != null) {
                try {
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/auca_library", "root", "");
                    String query = "INSERT INTO shelf (room_id, category, available_stock, borrowed_number, initial_stock) VALUES (?, ?, ?, ?, ?)";
                    PreparedStatement statement = connection.prepareStatement(query);
                    statement.setInt(1, Integer.parseInt(request.getParameter("roomId")));
                    statement.setString(2, request.getParameter("category"));
                    statement.setInt(3, Integer.parseInt(request.getParameter("availableStock")));
                    statement.setInt(4, Integer.parseInt(request.getParameter("borrowedNumber")));
                    statement.setInt(5, Integer.parseInt(request.getParameter("initialStock")));
                    statement.executeUpdate();
                    out.println("<p>Shelf added successfully!</p>");
                    connection.close();
                } catch (SQLException e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } catch (NumberFormatException e) {
                    out.println("<p>All numeric fields must be valid numbers.</p>");
                }
            }

            if (request.getParameter("updateShelf") != null) {
                try {
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/auca_library", "root", "");
                    String query = "UPDATE shelf SET category = ?, available_stock = ?, borrowed_number = ?, initial_stock = ? WHERE room_id = ?";
                    PreparedStatement statement = connection.prepareStatement(query);
                    statement.setString(1, request.getParameter("category"));
                    statement.setInt(2, Integer.parseInt(request.getParameter("availableStock")));
                    statement.setInt(3, Integer.parseInt(request.getParameter("borrowedNumber")));
                    statement.setInt(4, Integer.parseInt(request.getParameter("initialStock")));
                    statement.setInt(5, Integer.parseInt(request.getParameter("roomId")));
                    int rowsUpdated = statement.executeUpdate();
                    if (rowsUpdated > 0) {
                        out.println("<p>Shelf updated successfully!</p>");
                    } else {
                        out.println("<p>No shelf found with the given Room ID.</p>");
                    }
                    connection.close();
                } catch (SQLException e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } catch (NumberFormatException e) {
                    out.println("<p>All numeric fields must be valid numbers.</p>");
                }
            }
        %>
    </div>
</body>
</html>
