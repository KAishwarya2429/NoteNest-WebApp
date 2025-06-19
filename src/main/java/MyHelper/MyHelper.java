package MyHelper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MyHelper {
    private static final String URL = "jdbc:postgresql://localhost:5432/notenest";
    private static final String USER = "postgres";
    private static final String PASSWORD = "password";

    public static Connection getConnection() {
        try {
            Class.forName("org.postgresql.Driver"); // PostgreSQL driver class
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
