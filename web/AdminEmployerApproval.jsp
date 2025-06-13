<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.EmployerApproval" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <title>Duyệt Employer</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.32/dist/sweetalert2.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background: #f8f9fa; 
            padding: 20px;
        }
        .container { 
            background: #fff; 
            border-radius: 10px; 
            box-shadow: 0 0 20px rgba(0,0,0,0.1); 
            padding: 30px;
            margin-top: 20px;
        }
        .page-title {
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e9ecef;
        }
        .table {
            background: white;
            border-radius: 8px;
            overflow: hidden;
        }
        .table thead {
            background: #f8f9fa;
        }
        .table th {
            font-weight: 600;
            color: #2c3e50;
            border-bottom: 2px solid #dee2e6;
        }
        .table td {
            vertical-align: middle;
        }
        .btn {
            border-radius: 5px;
            padding: 8px 16px;
            font-weight: 500;
            transition: all 0.3s;
        }
        .btn-view {
            background: #3498db;
            color: white;
        }
        .btn-approve {
            background: #2ecc71;
            color: white;
        }
        .btn-reject {
            background: #e74c3c;
            color: white;
        }
        .btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .status-pending {
            color: #e67e22;
            font-weight: 500;
        }
        .no-data {
            text-align: center;
            padding: 40px;
            color: #7f8c8d;
            font-size: 1.1em;
        }
        .modal-content {
            border-radius: 10px;
        }
        .modal-header {
            background: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
        }
        .modal-title {
            color: #2c3e50;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="page-title text-center">Danh sách Employer chờ duyệt</h2>
        
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên công ty</th>
                        <th>Email</th>
                        <th>Website</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<EmployerApproval> employers = (List<EmployerApproval>) request.getAttribute("employers");
                        if (employers != null && !employers.isEmpty()) {
                            for (EmployerApproval employer : employers) {
                    %>
                        <tr>
                            <td><%= employer.getAccID() %></td>
                            <td><%= employer.getCompanyName() %></td>
                            <td><%= employer.getEmail() %></td>
                            <td><%= employer.getWebsite() %></td>
                            <td><span class="status-pending">Chờ duyệt</span></td>
                            <td>
                                <div class="btn-group" role="group">
                                    <a href="employer-detail?accID=<%= employer.getAccID() %>" 
                                       class="btn btn-view me-2">
                                        <i class="fas fa-eye"></i> Chi tiết
                                    </a>
                                    <button type="button" 
                                            class="btn btn-approve me-2"
                                            onclick="handleApprove(<%= employer.getAccID() %>, '<%= employer.getCompanyName() %>')">
                                        <i class="fas fa-check"></i> Duyệt
                                    </button>
                                    <button type="button" 
                                            class="btn btn-reject"
                                            onclick="showRejectModal(<%= employer.getAccID() %>, '<%= employer.getCompanyName() %>')">
                                        <i class="fas fa-times"></i> Từ chối
                                    </button>
                                </div>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="6" class="no-data">
                                <i class="fas fa-info-circle me-2"></i>
                                Không có employer nào đang chờ duyệt
                            </td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal từ chối -->
    <div class="modal fade" id="rejectModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Từ chối Employer</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="rejectForm">
                        <input type="hidden" id="rejectAccID" name="accID">
                        <input type="hidden" name="action" value="reject">
                        <div class="mb-3">
                            <label for="reason" class="form-label">Lý do từ chối</label>
                            <textarea class="form-control" id="reason" name="reason" rows="3" required></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-danger" onclick="handleReject()">Xác nhận từ chối</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.32/dist/sweetalert2.all.min.js"></script>
    <script>
        // Hiển thị thông báo từ session nếu có
        <%
        String successMsg = (String) session.getAttribute("success");
        String errorMsg = (String) session.getAttribute("error");
        if (successMsg != null) {
            successMsg = successMsg.replace("'", "\\'");
        %>
            Swal.fire({
                icon: 'success',
                title: 'Thành công',
                text: '<%= successMsg %>',
                timer: 3000
            });
            <% session.removeAttribute("success"); %>
        <% } %>
        
        <%
        if (errorMsg != null) {
            errorMsg = errorMsg.replace("'", "\\'");
        %>
            Swal.fire({
                icon: 'error',
                title: 'Lỗi',
                text: '<%= errorMsg %>',
                timer: 3000
            });
            <% session.removeAttribute("error"); %>
        <% } %>

        // Xử lý duyệt employer
        function handleApprove(accID, companyName) {
            Swal.fire({
                title: 'Xác nhận duyệt',
                text: 'Bạn có chắc chắn muốn duyệt employer "' + companyName + '"?',
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: 'Duyệt',
                cancelButtonText: 'Hủy',
                confirmButtonColor: '#2ecc71',
                cancelButtonColor: '#95a5a6'
            }).then((result) => {
                if (result.isConfirmed) {
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = 'AdminEmployerApproval';
                    
                    const accIDInput = document.createElement('input');
                    accIDInput.type = 'hidden';
                    accIDInput.name = 'accID';
                    accIDInput.value = accID;
                    
                    const actionInput = document.createElement('input');
                    actionInput.type = 'hidden';
                    actionInput.name = 'action';
                    actionInput.value = 'approve';
                    
                    form.appendChild(accIDInput);
                    form.appendChild(actionInput);
                    document.body.appendChild(form);
                    form.submit();
                }
            });
        }

        // Hiển thị modal từ chối
        function showRejectModal(accID, companyName) {
            document.getElementById('rejectAccID').value = accID;
            const modal = new bootstrap.Modal(document.getElementById('rejectModal'));
            modal.show();
        }

        // Xử lý từ chối employer
        function handleReject() {
            const form = document.getElementById('rejectForm');
            const reason = document.getElementById('reason').value.trim();
            
            if (!reason) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Thiếu thông tin',
                    text: 'Vui lòng nhập lý do từ chối',
                    timer: 2000
                });
                return;
            }
            
            form.method = 'POST';
            form.action = 'AdminEmployerApproval';
            form.submit();
        }
    </script>
</body>
</html> 