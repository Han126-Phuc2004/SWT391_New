<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết Employer</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
            color: #2c3e50;
            line-height: 1.6;
        }
        .container {
            max-width: 800px;
            margin: 40px auto;
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            padding: 40px;
        }
        .page-title {
            color: #2c3e50;
            text-align: center;
            font-weight: 600;
            margin-bottom: 40px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e9ecef;
        }
        .employer-info {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 30px;
            margin-bottom: 30px;
        }
        .info-item {
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #e9ecef;
        }
        .info-item:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }
        .label {
            font-weight: 600;
            color: #34495e;
            min-width: 150px;
            display: inline-block;
        }
        .value {
            color: #2c3e50;
        }
        .back-button {
            display: inline-block;
            padding: 12px 24px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s ease;
            font-weight: 500;
        }
        .back-button:hover {
            background: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            color: white;
        }
        .back-button i {
            margin-right: 8px;
        }
        .actions {
            text-align: center;
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="page-title">Chi tiết Employer</h2>
        
        <div class="employer-info">
            <div class="info-item">
                <span class="label"><i class="fas fa-id-card me-2"></i>ID:</span>
                <span class="value"><%= request.getAttribute("accID") %></span>
            </div>
            <div class="info-item">
                <span class="label"><i class="fas fa-envelope me-2"></i>Email:</span>
                <span class="value"><%= request.getAttribute("email") %></span>
            </div>
            <div class="info-item">
                <span class="label"><i class="fas fa-building me-2"></i>Tên công ty:</span>
                <span class="value"><%= request.getAttribute("companyName") %></span>
            </div>
            <div class="info-item">
                <span class="label"><i class="fas fa-globe me-2"></i>Website:</span>
                <span class="value"><%= request.getAttribute("website") %></span>
            </div>
            <div class="info-item">
                <span class="label"><i class="fas fa-map-marker-alt me-2"></i>Địa chỉ:</span>
                <span class="value"><%= request.getAttribute("address") %></span>
            </div>
            <div class="info-item">
                <span class="label"><i class="fas fa-phone me-2"></i>Số điện thoại:</span>
                <span class="value"><%= request.getAttribute("phone") %></span>
            </div>
        </div>
        
        <div class="actions">
            <a class="back-button" href="<%=request.getContextPath()%>/AdminEmployerApproval">
                <i class="fas fa-arrow-left"></i>Quay lại danh sách
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 