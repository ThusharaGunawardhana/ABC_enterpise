package models;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class dbHelper {

    // Static method to get a database connection
    public static Connection connectToDB() throws ClassNotFoundException, SQLException {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.jdbc.Driver"); // Modern MySQL JDBC driver

        // Database connection details
        String url = "jdbc:mysql://localhost:3306/aspire_enterprises"; // Your database URL
        String username = "root"; // Replace with your MySQL username
        String password = ""; // Replace with your MySQL password

        // Establish the connection
        return DriverManager.getConnection(url, username, password);
    }
}
