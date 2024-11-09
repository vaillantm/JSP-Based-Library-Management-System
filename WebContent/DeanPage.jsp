<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Library Dashboard - DEAN</title>
    <style>
   
        body {
            font-family: Arial, sans-serif;
            background-color: #1e3a8a; /* Dark Blue Background */
            color: white; /* White Text */
           
        }

     

        /* Headings */
        h1 {
            color: white;
   
        }

      

       

        /* Button Styles */
        button {
           
            background-color: black; /* Black Button */
            border: none;
          
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #444; /* Darker Button Hover */
        }

        /* Links */
        a {
            color: #007bff;
            text-decoration: none;
            transition: color 0.3s;
        }

        a:hover {
            color: #0056b3;
        }

     
        
    </style>
    
     <style>
        body {
            font-family: Arial, sans-serif;
         
            text-align: center;
            margin: 20px;
        }
        h1 {
            font-size: 30px;
            color: #333;
        }
        .section-title {
            font-weight: bold;
            color: red;
            margin-top: 20px;
        }
        .label {
            font-size: 16px;
            margin: 5px;
        }
    </style>
</head>
<body>
    <h1>Welcome, DEAN!</h1>
    
    <div class="section-title">DETAILS:</div>
    <div class="label">Total Books: 
        <%= getCount("SELECT COUNT(*) FROM book") %>
    </div>
    <div class="label">Books Borrowed: 
        <%= getCount("SELECT COUNT(*) FROM borrower") %>
    </div>
    <div class="label">Total Users: 
        <%= getCount("SELECT COUNT(*) FROM users") %>
    </div>
    <div class="label">Total Shelves: 
        <%= getCount("SELECT COUNT(*) FROM shelf") %>
    </div>
    <div class="label">Total Rooms: 
        <%= getCount("SELECT COUNT(*) FROM room") %>
    </div>

    <div class="section-title">Users:</div>
    <div class="label">Approved: 
        <%= getCount("SELECT COUNT(*) FROM membership WHERE membership_status = 'APPROVED'") %>
    </div>
    <div class="label">Pending: 
        <%= getCount("SELECT COUNT(*) FROM membership WHERE membership_status = 'PENDING'") %>
    </div>
    <div class="label">Rejected: 
        <%= getCount("SELECT COUNT(*) FROM membership WHERE membership_status = 'REJECTED'") %>
    </div>

    <div class="section-title">Role:</div>
    <div class="label">Student: 
        <%= getCount("SELECT COUNT(*) FROM users WHERE role = 'STUDENT'") %>
    </div>
    <div class="label">Manager: 
        <%= getCount("SELECT COUNT(*) FROM users WHERE role = 'MANAGER'") %>
    </div>
    <div class="label">Teacher: 
        <%= getCount("SELECT COUNT(*) FROM users WHERE role = 'TEACHER'") %>
    </div>
    <div class="label">Dean: 
        <%= getCount("SELECT COUNT(*) FROM users WHERE role = 'DEAN'") %>
    </div>
    <div class="label">Librarian: 
        <%= getCount("SELECT COUNT(*) FROM users WHERE role = 'LIBRARIAN'") %>
    </div>
    <div class="label">HOD: 
        <%= getCount("SELECT COUNT(*) FROM users WHERE role = 'HOD'") %>
    </div>

    <div class="section-title">Book Status:</div>
    <div class="label">Available: 
        <%= getCount("SELECT COUNT(*) FROM book WHERE book_status = 'AVAILABLE'") %>
    </div>
    <div class="label">Reserved: 
        <%= getCount("SELECT COUNT(*) FROM book WHERE book_status = 'RESERVED'") %>
    </div>
    <div class="label">Borrowed: 
        <%= getCount("SELECT COUNT(*) FROM book WHERE book_status = 'BORROWED'") %>
    </div>
</body>
</html>

<%!
    // Helper method to get count from the database
    public int getCount(String query) {
        int count = 0;
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/auca_library", "root", "");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        return count;
    }
%>