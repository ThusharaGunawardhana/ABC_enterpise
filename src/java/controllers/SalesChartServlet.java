package controllers;

import models.SalesModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/SalesChartServlet")
public class SalesChartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");

        // Fetch data from the SalesModel
        SalesModel model = new SalesModel();
        String jsonData = model.getMonthlySalesData();

        // Send JSON response to the client
        response.getWriter().write(jsonData);
    }
}
