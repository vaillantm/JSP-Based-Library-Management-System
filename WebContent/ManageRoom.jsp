<%@ page import="java.sql.*, javax.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Manage Room</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #001f3f; /* Dark Blue Background */
            color: #000000; /* White text for readability */
            margin: 20px;
        }
        h2 {
            text-align: center;
            color: #f1c40f; /* Gold color for the heading */
            margin-bottom: 20px;
        }
        .container {
            display: flex;
        }
        .form-container {
            width: 30%;
            margin-right: 20px;
            padding: 20px;
            background-color: #0052cc; /* Light Blue Background for Form */
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
        }
        .form-container input {
            width: 100%;
            padding: 8px;
            margin: 5px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        .form-container button {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            background-color: #f39c12; /* Bright Orange Button */
            color: #ffffff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .form-container button:hover {
            background-color: #e67e22; /* Darker Orange on Hover */
        }
        .table-container {
            width: 70%;
            padding: 20px;
            background-color: #0052cc; /* Light Blue Background for Table */
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #ffffff;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #34495e; /* Dark Blue for Table Header */
            color: #ffffff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h2>Manage Room</h2>
    <div class="container">
        <div class="form-container">
            <form method="post">
                Room ID: <input type="text" name="room_id"><br>
                Room Code: <input type="text" name="room_code"><br>
                <button type="submit" name="addRoom">Add Room</button>
                <button type="submit" name="updateRoom">Update Room</button>
                <button type="reset">Clear</button>
            </form>
        </div>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Room ID</th>
                        <th>Room Code</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection connection = null;
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            connection = DriverManager.getConnection("jdbc:mysql://localhost/auca_library", "root", "");
                            Statement statement = connection.createStatement();
                            ResultSet rs = statement.executeQuery("SELECT * FROM room");
                            while (rs.next()) {
                                out.println("<tr>");
                                out.println("<td>" + rs.getInt("room_id") + "</td>");
                                out.println("<td>" + rs.getString("room_code") + "</td>");
                                out.println("</tr>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <%
        if (request.getParameter("addRoom") != null) {
            try {
                String roomId = request.getParameter("room_id");
                String roomCode = request.getParameter("room_code");
                if (roomId != null && roomCode != null && !roomId.isEmpty() && !roomCode.isEmpty()) {
                    Class.forName("com.mysql.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost/auca_library", "root", "");
                    String query = "INSERT INTO room (room_id, room_code) VALUES (?, ?)";
                    PreparedStatement statement = connection.prepareStatement(query);
                    statement.setInt(1, Integer.parseInt(roomId));
                    statement.setString(2, roomCode);
                    statement.executeUpdate();
                    out.println("<p style='color: #27ae60; text-align: center;'>Room added successfully!</p>");
                } else {
                    out.println("<p style='color: #e74c3c; text-align: center;'>Please fill in all fields.</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p style='color: #e74c3c; text-align: center;'>Error adding room: " + e.getMessage() + "</p>");
            } finally {
                if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
            }
        }

        if (request.getParameter("updateRoom") != null) {
            try {
                String roomId = request.getParameter("room_id");
                String roomCode = request.getParameter("room_code");
                if (roomId != null && roomCode != null && !roomId.isEmpty() && !roomCode.isEmpty()) {
                    Class.forName("com.mysql.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost/auca_library", "root", "");
                    String query = "UPDATE room SET room_code = ? WHERE room_id = ?";
                    PreparedStatement statement = connection.prepareStatement(query);
                    statement.setString(1, roomCode);
                    statement.setInt(2, Integer.parseInt(roomId));
                    int rowsUpdated = statement.executeUpdate();
                    if (rowsUpdated > 0) {
                        out.println("<p style='color: #27ae60; text-align: center;'>Room updated successfully!</p>");
                    } else {
                        out.println("<p style='color: #e74c3c; text-align: center;'>Room ID not found.</p>");
                    }
                } else {
                    out.println("<p style='color: #e74c3c; text-align: center;'>Please fill in all fields.</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p style='color: #e74c3c; text-align: center;'>Error updating room: " + e.getMessage() + "</p>");
            } finally {
                if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
            }
        }
    %>
</body>
</html>
