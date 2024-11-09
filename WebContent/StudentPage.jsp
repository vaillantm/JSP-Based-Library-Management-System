<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #1e3a8a; /* Dark Blue Background */
            color: white;
        }

        h2 {
            text-align: center;
            font-size: 30px;
            margin-top: 50px;
        }

        .button-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 50px;
        }

        input[type="submit"] {
            padding: 12px 20px;
            background-color: black; 
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #444;
        }

    </style>
</head>
<body>
    <h2>Welcome to the Student Dashboard</h2>
    <div class="button-container">
        <form action="CreateMembership.jsp" method="get">
            <input type="submit" value="Create Membership">
        </form>

        <form action="BorrowandReserve.jsp" method="get">
            <input type="submit" value="Borrow or Reserve Book">
        </form>

        <form action="ViewandReturn.jsp" method="get">
            <input type="submit" value="View Borrowed Books">
        </form>

        <form action="CreateLocation.jsp" method="get">
            <input type="submit" value="Create Location">
        </form>
    </div>
</body>
</html>
