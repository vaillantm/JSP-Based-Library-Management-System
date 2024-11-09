<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date, java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Membership</title>
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
        button {
            padding: 10px;
            background-color: black;
            color: white;
            cursor: pointer;
        }
        .section {
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <h2>Create Membership and Membership Type</h2>

    <!-- Membership Type Section -->
    <div class="form-container section">
        <h3>Create Membership Type</h3>
        <form action="CreateMembership.jsp" method="post">
            <label for="membershipName">Membership Name:</label>
            <select id="membershipName" name="membershipName">
                <option value="Gold">Gold</option>
                <option value="Silver">Silver</option>
                <option value="Striver">Striver</option>
            </select><br>

            <label for="maxBooks">Max Books:</label>
            <input type="number" id="maxBooks" name="maxBooks" readonly><br>

            <label for="price">Price (Rwf):</label>
            <input type="number" id="price" name="price" readonly><br>

            <button type="submit" name="submitMembershipType">Submit Membership Type</button>
        </form>
    </div>

    <!-- Membership Section -->
    <div class="form-container section">
        <h3>Create Membership</h3>
        <form action="CreateMembership.jsp" method="post">
            <label for="registrationDate">Registration Date (yyyy-MM-dd):</label>
            <input type="text" id="registrationDate" name="registrationDate"><br>

            <label for="membershipCode">Membership Code:</label>
            <input type="text" id="membershipCode" name="membershipCode"><br>

            <label for="readerId">Reader ID:</label>
            <input type="text" id="readerId" name="readerId"><br>

            <label for="membershipTypeId">Membership Type ID:</label>
            <input type="text" id="membershipTypeId" name="membershipTypeId"><br>

            <button type="submit" name="submitMembership">Submit Membership</button>
        </form>
    </div>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            // Handle the Membership Type submission
            if (request.getParameter("submitMembershipType") != null) {
                String membershipName = request.getParameter("membershipName");
                int maxBooks = 0;
                int price = 0;

                if ("Gold".equals(membershipName)) {
                    maxBooks = 5;
                    price = 50;
                } else if ("Silver".equals(membershipName)) {
                    maxBooks = 3;
                    price = 30;
                } else if ("Striver".equals(membershipName)) {
                    maxBooks = 2;
                    price = 10;
                }

                try {
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/auca_library", "root", "");
                    PreparedStatement statement = connection.prepareStatement("INSERT INTO Membership_Type (membership_name, max_books, price) VALUES (?, ?, ?)");
                    statement.setString(1, membershipName);
                    statement.setInt(2, maxBooks);
                    statement.setInt(3, price);
                    int rowsInserted = statement.executeUpdate();

                    if (rowsInserted > 0) {
                        out.println("<script>alert('Membership Type saved successfully!');</script>");
                    } else {
                        out.println("<script>alert('Failed to save Membership Type.');</script>");
                    }
                } catch (Exception ex) {
                    out.println("<script>alert('Error: " + ex.getMessage() + "');</script>");
                }
            }

            // Handle the Membership submission
            if (request.getParameter("submitMembership") != null) {
                String membershipCode = request.getParameter("membershipCode");
                String readerId = request.getParameter("readerId");
                String registrationDateStr = request.getParameter("registrationDate");
                String membershipTypeId = request.getParameter("membershipTypeId");

                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date registrationDate = sdf.parse(registrationDateStr);
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(registrationDate);
                    calendar.add(Calendar.MONTH, 3);
                    Date expiringTime = calendar.getTime();

                    String membershipId = java.util.UUID.randomUUID().toString();

                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/auca_library", "root", "");
                    PreparedStatement statement = connection.prepareStatement("INSERT INTO Membership (membership_id, membership_type_id, membership_code, reader_id, registration_date, expiring_time, membership_status) VALUES (?, ?, ?, ?, ?, ?, ?)");
                    statement.setString(1, membershipId);
                    statement.setString(2, membershipTypeId);
                    statement.setString(3, membershipCode);
                    statement.setString(4, readerId);
                    statement.setDate(5, new java.sql.Date(registrationDate.getTime()));
                    statement.setDate(6, new java.sql.Date(expiringTime.getTime()));
                    statement.setString(7, "PENDING");
                    int rowsInserted = statement.executeUpdate();

                    if (rowsInserted > 0) {
                        out.println("<script>alert('Membership saved successfully!');</script>");
                    } else {
                        out.println("<script>alert('Failed to save Membership.');</script>");
                    }
                } catch (Exception ex) {
                    out.println("<script>alert('Error: " + ex.getMessage() + "');</script>");
                }
            }
        }
    %>
</body>
</html>
