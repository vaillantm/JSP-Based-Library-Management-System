<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Librarian Dashboard</title>
    <style>
        body {
            background-color: #000000; /* Black background */
            color: #ffffff; /* White text color */
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        h2 {
            text-align: center;
            color: #8B0000; /* Dark Red color for the heading */
            padding-top: 50px;
        }
        .container {
            display: flex;
            justify-content: space-around;
            margin: 50px 0;
            padding: 20px;
        }
        button {
            padding: 15px 30px;
            font-size: 16px;
            cursor: pointer;
            background-color: #8B0000; /* Dark Red background for buttons */
            border: 2px solid #8B0000; /* Matching border */
            color: white; /* White text on buttons */
            border-radius: 5px;
            transition: background-color 0.3s, border 0.3s;
        }
        button:hover {
            background-color: #d32f2f; /* Lighter Red on hover */
            border: 2px solid #d32f2f;
        }
    </style>
</head>
<body>
    <h2>Librarian Dashboard</h2>
    <div class="container">
        <form action="ManageMembership.jsp">
            <button type="submit">Manage Membership</button>
        </form>
        <form action="ManageBook.jsp">
            <button type="submit">Manage Book</button>
        </form>
        <form action="ManageShelf.jsp">
            <button type="submit">Manage Shelf</button>
        </form>
        <form action="ManageRoom.jsp">
            <button type="submit">Manage Room</button>
        </form>
        <form action="ViewBorrowed.jsp">
            <button type="submit">View Borrowed</button>
        </form>
        <form action="ViewUsers.jsp">
            <button type="submit">View Users</button>
        </form>
    </div>
</body>
</html>
