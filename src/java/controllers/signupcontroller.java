/*import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/signupcontroller"})
public class signupcontroller extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String email = request.getParameter("email");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String password = request.getParameter("password");
        String contact = request.getParameter("contact");
        
        out.println("<h1>Hello " + firstname  + " Your details are as follows");
        out.println("<br>");
        out.println("email : " + email );
        out.println("<br>");
        out.println("fname : " + firstname );
        out.println("<br>");
        out.println("lname : " + lastname );
        out.println("<br>");
        out.println("password : " + password );
        out.println("<br>");
        out.println("contact : " + contact );
    }*/
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.dbHelper; // Import your dbHelper class

@WebServlet(urlPatterns = {"/signupcontroller"})
public class signupcontroller extends HttpServlet {

    // Database connection details
    //private final String DB_URL = "jdbc:mysql://localhost:3306/abc"; // Your database URL
    //private final String DB_USER = "root"; // Replace with your MySQL username
    //private final String DB_PASSWORD = ""; // Replace with your MySQL password

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Retrieve form data from the request
        String email = request.getParameter("email");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String password = request.getParameter("password");
        String contact = request.getParameter("contact");

        try (PrintWriter out = response.getWriter()) {
            // Using dbHelper to get the connection
            try (Connection conn = dbHelper.connectToDB()) {
                // SQL statement to insert user data, omitting the `id` column (auto-incremented)
                String sql = "INSERT INTO user (email, firstname, lastname, password, contact) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, email);
                    stmt.setString(2, firstname);
                    stmt.setString(3, lastname);
                    stmt.setString(4, password); // Ideally, hash the password for security
                    stmt.setString(5, contact);

                    // Execute the SQL statement
                    int rowsInserted = stmt.executeUpdate();
                    if (rowsInserted > 0) {
                        out.println("<h1>Registration Successful!</h1>");
                        out.println("<p>Welcome, " + firstname + "!</p>");
                        request.getRequestDispatcher("signin.jsp").forward(request, response);
                    } else {
                        out.println("<h1>Registration Failed</h1>");
                    }
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace(); // Print the stack trace for debugging
                out.println("<h1>Error: Unable to connect to the database or execute the statement.</h1>");
                out.println("<p>" + e.getMessage() + "</p>"); // Display detailed error message
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to the signup form
        response.sendRedirect("signup.jsp");
    }
}
