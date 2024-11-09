<%@ page import="java.sql.*, javax.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Manage Book</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #001f3f; /* Dark Blue Background */
            color: #000000; /* White text color for readability */
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
            background-color: #0052cc; /* Lighter Blue for form container */
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
        }
        .form-container input, .form-container textarea {
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
            background-color: #f39c12; /* Bright orange button color */
            color: #ffffff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .form-container button:hover {
            background-color: #e67e22; /* Darker orange on hover */
        }
        .table-container {
            width: 70%;
            padding: 20px;
            background-color: #0052cc; /* Lighter Blue for table container */
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
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #34495e; /* Darker Blue for table headers */
            color: #ffffff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h2>Manage Book</h2>
    <div class="container">
        <div class="form-container">
            <form method="post" action="ManageBook.jsp">
                ISBN Code: <input type="text" name="isbn_code" value="<%= request.getParameter("isbn_code") != null ? request.getParameter("isbn_code") : "" %>"><br>
                Title: <input type="text" name="title" value="<%= request.getAttribute("title") != null ? request.getAttribute("title").toString() : "" %>"><br>
                Edition: <input type="text" name="edition" value="<%= request.getAttribute("edition") != null ? request.getAttribute("edition").toString() : "" %>"><br>
                Publication Year: <input type="text" name="publication_year" value="<%= request.getAttribute("publication_year") != null ? request.getAttribute("publication_year").toString() : "" %>"><br>
                Publisher: <input type="text" name="publisher" value="<%= request.getAttribute("publisher") != null ? request.getAttribute("publisher").toString() : "" %>"><br>
                Shelf ID: <input type="text" name="shelf_id" value="<%= request.getAttribute("shelf_id") != null ? request.getAttribute("shelf_id").toString() : "" %>"><br>
                Book Status: <textarea name="book_status"><%= request.getAttribute("book_status") != null ? request.getAttribute("book_status").toString() : "AVAILABLE" %></textarea><br>
                <button type="submit" name="addBook">Add Book</button>
                <button type="submit" name="getDetails">Get Book Details</button>
                <button type="submit" name="updateBook">Update Book</button>
                <button type="reset">Clear</button>
            </form>
        </div>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ISBN</th>
                        <th>Title</th>
                        <th>Edition</th>
                        <th>Year</th>
                        <th>Publisher</th>
                        <th>Shelf ID</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection connection = null;
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            connection = DriverManager.getConnection("jdbc:mysql://localhost/auca_library", "root", "");
                            Statement statement = connection.createStatement();
                            ResultSet rs = statement.executeQuery("SELECT * FROM book");
                            while (rs.next()) {
                                out.println("<tr>");
                                out.println("<td>" + rs.getString("isbn_code") + "</td>");
                                out.println("<td>" + rs.getString("title") + "</td>");
                                out.println("<td>" + rs.getString("edition") + "</td>");
                                out.println("<td>" + rs.getInt("publication_year") + "</td>");
                                out.println("<td>" + rs.getString("publisher") + "</td>");
                                out.println("<td>" + rs.getInt("shelf_id") + "</td>");
                                out.println("<td>" + rs.getString("book_status") + "</td>");
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

    <!-- Handle form submissions -->
    <%
        if (request.getParameter("addBook") != null) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost/auca_library", "root", "");
                String query = "INSERT INTO book (isbn_code, title, edition, publication_year, publisher, shelf_id, book_status) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, request.getParameter("isbn_code"));
                statement.setString(2, request.getParameter("title"));
                statement.setString(3, request.getParameter("edition"));
                statement.setInt(4, Integer.parseInt(request.getParameter("publication_year")));
                statement.setString(5, request.getParameter("publisher"));
                statement.setInt(6, Integer.parseInt(request.getParameter("shelf_id")));
                statement.setString(7, request.getParameter("book_status"));
                statement.executeUpdate();
                out.println("<p style='color: #27ae60; text-align: center;'>Book added successfully!</p>");
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p style='color: #e74c3c; text-align: center;'>Error adding book: " + e.getMessage() + "</p>");
            }
        }

        if (request.getParameter("getDetails") != null) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost/auca_library", "root", "");
                String query = "SELECT * FROM book WHERE isbn_code = ?";
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, request.getParameter("isbn_code"));
                ResultSet rs = statement.executeQuery();
                if (rs.next()) {
                    request.setAttribute("title", rs.getString("title"));
                    request.setAttribute("edition", rs.getString("edition"));
                    request.setAttribute("publication_year", rs.getInt("publication_year"));
                    request.setAttribute("publisher", rs.getString("publisher"));
                    request.setAttribute("shelf_id", rs.getInt("shelf_id"));
                    request.setAttribute("book_status", rs.getString("book_status"));
                } else {
                    out.println("<p style='color: #e74c3c; text-align: center;'>No book found with the given ISBN code.</p>");
                }
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p style='color: #e74c3c; text-align: center;'>Error fetching book details: " + e.getMessage() + "</p>");
            }
        }

        if (request.getParameter("updateBook") != null) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost/auca_library", "root", "");
                String query = "UPDATE book SET title = ?, edition = ?, publication_year = ?, publisher = ?, shelf_id = ?, book_status = ? WHERE isbn_code = ?";
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, request.getParameter("title"));
                statement.setString(2, request.getParameter("edition"));
                statement.setInt(3, Integer.parseInt(request.getParameter("publication_year")));
                statement.setString(4, request.getParameter("publisher"));
                statement.setInt(5, Integer.parseInt(request.getParameter("shelf_id")));
                statement.setString(6, request.getParameter("book_status"));
                statement.setString(7, request.getParameter("isbn_code"));
                int rowsUpdated = statement.executeUpdate();
                if (rowsUpdated > 0) {
                    out.println("<p style='color: #27ae60; text-align: center;'>Book updated successfully!</p>");
                } else {
                    out.println("<p style='color: #e74c3c; text-align: center;'>No book found to update with the given ISBN code.</p>");
                }
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p style='color: #e74c3c; text-align: center;'>Error updating book: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
