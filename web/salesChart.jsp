<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Monthly Sales Chart</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <jsp:include page="adminNav.jsp" />
    <h1>Monthly Total Sales Chart</h1>
    <canvas id="salesChart" width="800" height="400"></canvas>

    <script>
        // Fetch data from the servlet
        fetch('SalesChartServlet')
            .then(response => response.json())
            .then(data => {
                console.log('Fetched data:', data); // Debugging: Log data in the console

                // Prepare data for Chart.js
                const months = data.map(item => item.month);
                const sales = data.map(item => item.totalSales);

                // Create the bar chart
                const ctx = document.getElementById('salesChart').getContext('2d');
                new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: months,
                        datasets: [{
                            label: 'Monthly Total Sales',
                            data: sales,
                            backgroundColor: 'rgba(42, 183, 228, 0.8)',
                            borderColor: 'rgba(32, 38, 40, 0.8)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            })
            .catch(error => console.error('Error fetching data:', error));
    </script>
</body>
</html>
