package controllers;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/DownloadReport")
public class DownloadReportServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the selected month from the request parameter
        String selectedMonth = request.getParameter("reportMonth");

        if (selectedMonth != null && !selectedMonth.isEmpty()) {
            // Generate the PDF based on the selected month
            generatePdfReport(selectedMonth, response);
        } else {
            // Handle the case where the month is not provided
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Month parameter is missing.");
        }
    }

    private void generatePdfReport(String selectedMonth, HttpServletResponse response) throws IOException {
        // Database connection details
        String url = "jdbc:mysql://localhost:3306/aspire_enterprises";
        String username = "root";
        String password = "";

        try {
            // Set the response type to PDF
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "inline; filename=Business_Report.pdf");

            // Initialize the PDF document
            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());

            // Open the document to start writing
            document.open();

            // Title for the report
            document.add(new Paragraph("Business Report for " + selectedMonth, FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18)));
            document.add(Chunk.NEWLINE);

            // Create a table with 6 columns (corresponding to your data)
            PdfPTable table = new PdfPTable(6);
            table.setWidthPercentage(100);

            // Add table headers (based on your provided structure)
            table.addCell("Sale ID");
            table.addCell("Date");
            table.addCell("Product Name");
            table.addCell("Quantity Sold");
            table.addCell("Price Per Unit");
            table.addCell("Total Sale Amount");

            // Connect to the database and fetch sales data for the selected month
            try (Connection conn = DriverManager.getConnection(url, username, password)) {
                // Ensure that data is ordered by the 'date' column, ascending
                String query = "SELECT sale_id, date, product_name, quantity_sold, price_per_unit, total_sale_amount " +
                               "FROM sales " +
                               "WHERE DATE_FORMAT(date, '%Y-%m') = ? ";
                               

                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, selectedMonth); // Set the selected month as parameter

                // Add data to the table
                try (ResultSet rs = ps.executeQuery()) {
                    boolean hasData = false;  // Flag to check if data exists
                    while (rs.next()) {
                        hasData = true;
                        table.addCell(String.valueOf(rs.getInt("sale_id")));
                        table.addCell(rs.getString("date"));  // Assuming 'date' is in 'yyyy-MM-dd' format
                        table.addCell(rs.getString("product_name"));
                        table.addCell(String.valueOf(rs.getInt("quantity_sold")));
                        table.addCell(String.valueOf(rs.getDouble("price_per_unit")));
                        table.addCell(String.valueOf(rs.getDouble("total_sale_amount")));
                    }

                    // If no data found, add a message to the document
                    if (!hasData) {
                        document.add(new Paragraph("No sales data found for the selected month."));
                    }
                } catch (SQLException e) {
                    System.out.println("Error processing result set: " + e.getMessage());
                    document.add(new Paragraph("Error retrieving data from the database."));
                }
            } catch (SQLException e) {
                System.out.println("Database error: " + e.getMessage());
                document.add(new Paragraph("Database connection error."));
            }

            // Add the table to the document if data was found
            document.add(table);

            // Close the document
            document.close();

        } catch (DocumentException e) {
            System.out.println("Document error: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating the PDF report.");
        }
    }


}

