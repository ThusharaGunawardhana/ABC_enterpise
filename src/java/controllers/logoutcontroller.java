package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "logoutcontroller", urlPatterns = {"/logoutcontroller"})
public class logoutcontroller extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch the session object
        HttpSession session = request.getSession(false);
        
        // If a session exists, invalidate it
        if (session != null) {
            session.invalidate();
        }
        
        // Redirect to the sign-in page
        response.sendRedirect("signin.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to the POST handler
        doPost(request, response);
    }
}
