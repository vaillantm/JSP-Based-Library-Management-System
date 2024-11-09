<%@ page import="java.sql.*, javax.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Manage Membership</title>
    <style>
        body {
            background-color: #001f3f; /* Dark Blue Background */
            color: #ffffff;
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        h2 {
            text-align: center;
            color: #f1c40f; /* Gold color for the heading */
        }
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .filters {
            margin-bottom: 20px;
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .filters select, .filters input, .filters button {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #0052cc;
            color: #ffffff;
        }
        .filters button:hover {
            background-color: #f39c12;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #000000;
        }
        tr:nth-child(even) {
            background-color: #000000;
        }
        td button {
            padding: 5px 10px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }
        .approve-btn {
            background-color: #27ae60;
            color: white;
        }
        .reject-btn {
            background-color: #e74c3c;
            color: white;
        }
    </style>
</head>
<body>
    <h2>Manage Membership</h2>
    <div class="container">
        <div class="filters">
            <form method="post">
                <!-- Filter Dropdown -->
                <select name="statusFilter">
                    <option value="ALL">ALL</option>
                    <option value="APPROVED">APPROVED</option>
                    <option value="REJECTED">REJECTED</option>
                    <option value="PENDING">PENDING</option>
                </select>
                <!-- Search Input -->
                <input type="text" name="searchCode" placeholder="Search by Membership Code" />
                <button type="submit" name="filter">Filter</button>
            </form>
        </div>

        <!-- Membership Table -->
        <table>
            <thead>
                <tr>
                    <th>Membership Code</th>
                    <th>Registration Date</th>
                    <th>Expiring Time</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection connection = null;
                    PreparedStatement statement = null;
                    ResultSet resultSet = null;
                    try {
                        connection = DriverManager.getConnection("jdbc:mysql://localhost/auca_library", "root", "");

                        String statusFilter = request.getParameter("statusFilter") != null ? request.getParameter("statusFilter") : "ALL";
                        String searchCode = request.getParameter("searchCode") != null ? request.getParameter("searchCode") : "";

                        // Construct query with filter and search functionality
                        String query = "SELECT membership_code, registration_date, expiring_time, membership_status FROM Membership";
                        if (!statusFilter.equals("ALL") || !searchCode.isEmpty()) {
                            query += " WHERE ";
                            if (!statusFilter.equals("ALL")) {
                                query += "membership_status = ? ";
                            }
                            if (!searchCode.isEmpty()) {
                                if (!statusFilter.equals("ALL")) {
                                    query += "AND ";
                                }
                                query += "membership_code LIKE ? ";
                            }
                        }

                        statement = connection.prepareStatement(query);
                        int paramIndex = 1;
                        if (!statusFilter.equals("ALL")) {
                            statement.setString(paramIndex++, statusFilter);
                        }
                        if (!searchCode.isEmpty()) {
                            statement.setString(paramIndex, "%" + searchCode + "%");
                        }

                        resultSet = statement.executeQuery();
                        while (resultSet.next()) {
                            String membershipCode = resultSet.getString("membership_code");
                            Date registrationDate = resultSet.getDate("registration_date");
                            Date expiringTime = resultSet.getDate("expiring_time");
                            String status = resultSet.getString("membership_status");
                %>
                <tr>
                    <td><%= membershipCode %></td>
                    <td><%= registrationDate %></td>
                    <td><%= expiringTime %></td>
                    <td><%= status %></td>
                    <td>
                        <!-- Approve Button -->
                        <form method="post" style="display:inline;">
                            <input type="hidden" name="membershipCode" value="<%= membershipCode %>">
                            <button type="submit" name="approve" class="approve-btn">Approve</button>
                        </form>
                        <!-- Reject Button -->
                        <form method="post" style="display:inline;">
                            <input type="hidden" name="membershipCode" value="<%= membershipCode %>">
                            <button type="submit" name="reject" class="reject-btn">Reject</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
                        if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
                        if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
                    }

                    // Handle Approval
                    if (request.getParameter("approve") != null) {
                        String membershipCode = request.getParameter("membershipCode");
                        try {
                            connection = DriverManager.getConnection("jdbc:mysql://localhost/auca_library", "root", "");
                            String updateQuery = "UPDATE Membership SET membership_status = ? WHERE membership_code = ?";
                            statement = connection.prepareStatement(updateQuery);
                            statement.setString(1, "APPROVED");
                            statement.setString(2, membershipCode);
                            statement.executeUpdate();
                            out.println("<script>alert('Membership approved successfully!'); window.location.href='ManageMembership.jsp';</script>");
                        } catch (SQLException e) {
                            out.println("<script>alert('Error approving membership: " + e.getMessage() + "');</script>");
                        } finally {
                            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
                        }
                    }

                    // Handle Rejection
                    if (request.getParameter("reject") != null) {
                        String membershipCode = request.getParameter("membershipCode");
                        try {
                            connection = DriverManager.getConnection("jdbc:mysql://localhost/auca_library", "root", "");
                            String updateQuery = "UPDATE Membership SET membership_status = ? WHERE membership_code = ?";
                            statement = connection.prepareStatement(updateQuery);
                            statement.setString(1, "REJECTED");
                            statement.setString(2, membershipCode);
                            statement.executeUpdate();
                            out.println("<script>alert('Membership rejected successfully!'); window.location.href='ManageMembership.jsp';</script>");
                        } catch (SQLException e) {
                            out.println("<script>alert('Error rejecting membership: " + e.getMessage() + "');</script>");
                        } finally {
                            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
