<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Borrow or Reserve Book</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #1e3a8a;
            color: white;
        }

        h2 {
            text-align: center;
            font-size: 30px;
            margin-top: 50px;
        }

        .form-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 50px;
        }

        label, input, select {
            margin: 10px;
        }

        table {
            width: 80%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #444;
        }

        tr:nth-child(even) {
            background-color: #555;
        }

        tr:hover {
            background-color: #666;
        }

        button {
            padding: 10px;
            background-color: black;
            color: white;
            cursor: pointer;
        }

        button:disabled {
            background-color: gray;
        }
    </style>
</head>
<body>
    <h2>Borrow or Reserve Book</h2>
    <div class="form-container">
        <label for="statusFilter">Filter by Status</label>
        <select id="statusFilter" name="statusFilter">
            <option value="all">All</option>
            <option value="borrowed">Borrowed</option>
            <option value="reserved">Reserved</option>
            <option value="available">Available</option>
        </select>

        <label for="bookTitleSearch">Search by Title</label>
        <input type="text" id="bookTitleSearch" name="bookTitleSearch">

        <table>
            <tr>
                <th>ISBN Code</th>
                <th>Title</th>
                <th>Edition</th>
                <th>Book Status</th>
                <th>Actions</th>
            </tr>

            <% 
                // Database connection parameters
                  Class.forName("com.mysql.jdbc.Driver");
                String jdbcURL = "jdbc:mysql://localhost:3306/auca_library";
                String jdbcUsername = "root";
                String jdbcPassword = "";
                
                Connection connection = null;
                PreparedStatement statement = null;
                ResultSet resultSet = null;

                try {
                    // Establish connection to the database
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                    
                    // Fetch books from the database
                    String sql = "SELECT * FROM book";
                    statement = connection.prepareStatement(sql);
                    resultSet = statement.executeQuery();
                    
                    // Loop through the result set and display each book
                    while (resultSet.next()) {
                        String isbnCode = resultSet.getString("isbn_code");
                        String title = resultSet.getString("title");
                        String edition = resultSet.getString("edition");
                        String bookStatus = resultSet.getString("book_status");
            %>
            <tr>
                <td><%= isbnCode %></td>
                <td><%= title %></td>
                <td><%= edition %></td>
                <td><%= bookStatus %></td>
                <td>
                    <form method="post">
                        <input type="hidden" name="isbn" value="<%= isbnCode %>" />
                        <button type="submit" name="action" value="borrow">Borrow</button>
                        <button type="submit" name="action" value="reserve">Reserve</button>
                    </form>
                </td>
            </tr>
            <% 
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (resultSet != null) resultSet.close();
                        if (statement != null) statement.close();
                        if (connection != null) connection.close();
                    } catch (SQLException se) {
                        se.printStackTrace();
                    }
                }
            %>
        </table>
    </div>

    <% 
        // Handle Borrow and Reserve actions
        String action = request.getParameter("action");
        String isbn = request.getParameter("isbn");

        if (action != null && isbn != null) {
            String newStatus = "";
            if (action.equals("borrow")) {
                newStatus = "borrowed";
            } else if (action.equals("reserve")) {
                newStatus = "reserved";
            }

            // Update the book status in the database
            if (!newStatus.isEmpty()) {
                try {
                    connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                    String updateSQL = "UPDATE book SET book_status = ? WHERE isbn_code = ?";
                    PreparedStatement updateStatement = connection.prepareStatement(updateSQL);
                    updateStatement.setString(1, newStatus);
                    updateStatement.setString(2, isbn);
                    int rowsUpdated = updateStatement.executeUpdate();
                    
                    if (rowsUpdated > 0) {
                        out.println("<script>alert('Book status updated to " + newStatus + "!');</script>");
                    }
                } catch (SQLException se) {
                    se.printStackTrace();
                } finally {
                    try {
                        if (connection != null) connection.close();
                    } catch (SQLException se) {
                        se.printStackTrace();
                    }
                }
            }
        }
    %>

    <script>
        function borrowBook() {
            alert("Book Borrowed!");
        }

        function reserveBook() {
            alert("Book Reserved!");
        }
    </script>
</body>
</html>
