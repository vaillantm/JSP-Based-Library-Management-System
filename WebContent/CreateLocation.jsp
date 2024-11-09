<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.UUID" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Location</title>
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
        .form-field {
            display: flex;
            margin-bottom: 15px;
        }
        .form-field label {
            width: 200px;
            text-align: right;
            margin-right: 20px;
        }
        .form-field input {
            width: 300px;
            padding: 8px;
        }
        button {
            padding: 10px;
            background-color: black;
            color: white;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h2>Create Location</h2>

    <div class="form-container">
        <form action="CreateLocation.jsp" method="post">
            <!-- Location Code -->
            <div class="form-field">
                <label for="locationCode">Location Code:</label>
                <input type="text" id="locationCode" name="locationCode" required>
            </div>

            <!-- Location ID -->
            <div class="form-field">
                <label for="locationId">Location ID:</label>
                <input type="text" id="locationId" name="locationId" required>
            </div>

            <!-- Location Name -->
            <div class="form-field">
                <label for="locationName">Location Name:</label>
                <input type="text" id="locationName" name="locationName" required>
            </div>

            <!-- Location Type -->
            <div class="form-field">
                <label for="locationType">Location Type:</label>
                <input type="text" id="locationType" name="locationType" required>
            </div>

            <!-- Parent ID -->
            <div class="form-field">
                <label for="parentId">Parent ID:</label>
                <input type="text" id="parentId" name="parentId">
            </div>

            <!-- Submit Button -->
            <button type="submit" name="submitLocation">Submit Location</button>
        </form>
    </div>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            // Get the form values
            String locationCode = request.getParameter("locationCode");
            String locationId = request.getParameter("locationId");
            String locationName = request.getParameter("locationName");
            String locationType = request.getParameter("locationType");
            String parentId = request.getParameter("parentId");

            try {
                // Connect to the database
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/auca_library", "root", "");
                
                // Prepare SQL statement to insert location data
                String sql = "INSERT INTO Location (location_code, location_id, location_name, location_type, parent_id) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setString(1, locationCode);
                statement.setString(2, locationId);
                statement.setString(3, locationName);
                statement.setString(4, locationType);
                statement.setString(5, parentId);

                // Execute the insert query
                int rowsInserted = statement.executeUpdate();

                if (rowsInserted > 0) {
                    out.println("<script>alert('Location saved successfully!');</script>");
                } else {
                    out.println("<script>alert('Failed to save location.');</script>");
                }

            } catch (Exception ex) {
                out.println("<script>alert('Error: " + ex.getMessage() + "');</script>");
                ex.printStackTrace();
            }
        }
    %>
</body>
</html>
