<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Product</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; }
        .container { margin: 20px auto; max-width: 900px; padding: 20px; background: #fff; border-radius: 10px; }
        .form-group input[type="button"] {
            background-color: #f44336;
            color: white;
            border: none;
            cursor: pointer;
        }
        .form-group input[type="button"]:hover {
            background-color: #e53935;
        }

        label { font-weight: bold; display: block; }
        input { width: 100%; padding: 8px; margin-top: 5px; border-radius: 5px; border: 1px solid #ddd; }
        input[type="submit"], input[type="button"] {
            cursor: pointer; background-color: #4CAF50; color: white; border: none;
        }
        input[type="submit"]:hover { background-color: #45a049; }
        input[type="button"]:hover { background-color: #f44336; }
    </style>
</head>
<body>
    <jsp:include page="adminNav.jsp" />

    <div class="container">
        <h1>Add Product</h1>
        <form action="InventoryController?action=add" method="POST">
            <div class="form-group">
                <label for="product_name">Product Name</label>
                <input type="text" id="product_name" name="product_name" required />
            </div>
            <div class="form-group">
                <label for="category_id">Category ID</label>
                <input type="text" id="category_id" name="category_id" required />
            </div>
            <div class="form-group">
                <label for="stock_quantity">Stock Quantity</label>
                <input type="number" id="stock_quantity" name="stock_quantity" required />
            </div>
            <div class="form-group">
                <label for="supplier_name">Supplier Name</label>
                <input type="text" id="supplier_name" name="supplier_name" required />
            </div>
            <div class="form-group">
                <input type="submit" value="Save" />
                <input type="button" value="Cancel" onclick="window.location.href='inventoryTableAdmin.jsp'" />
            </div>
        </form>
    </div>
</body>
</html>
