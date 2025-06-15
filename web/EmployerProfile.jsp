<%-- 
    Document   : EmployerProfile
    Created on : Jun 2, 2025, 10:17:52 PM
    Author     : phamd
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Employer Profile - Job Portal</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background: #f4f7fc;
                font-family: 'Segoe UI', sans-serif;
            }
            .profile-box {
                background: #fff;
                border-radius: 10px;
                padding: 20px;
                margin-top: 20px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            }
            .profile-image {
                width: 150px;
                height: 150px;
                border-radius: 50%;
                object-fit: cover;
                border: 3px solid #007bff;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease;
            }
            .profile-image:hover {
                transform: scale(1.05);
            }
            .avatar-upload {
                margin-top: 15px;
            }
            .avatar-upload input[type="file"] {
                display: none;
            }
            .avatar-upload label {
                display: inline-block;
                padding: 8px 16px;
                background: #007bff;
                color: white;
                border-radius: 5px;
                cursor: pointer;
                transition: background 0.3s ease;
            }
            .avatar-upload label:hover {
                background: #0056b3;
            }
            .section-title {
                margin-bottom: 20px;
            }
            .alert {
                margin-top: 20px;
            }
            .action-buttons {
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <!-- Include Header -->
        <jsp:include page="Header.jsp" />

        <div class="container mt-5">
            <!-- Messages -->
            <c:if test="${not empty sessionScope.message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% session.removeAttribute("message"); %>
            </c:if>
            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${sessionScope.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% session.removeAttribute("error"); %>
            </c:if>

            <div class="row">
                <!-- Left Profile -->
                <div class="col-md-4">
                    <div class="profile-box text-center">
                        <!-- Hiển thị avatar -->
                        <img class="profile-image" src="${pageContext.request.contextPath}/${sessionScope.account.avatar != null ? sessionScope.account.avatar : 'assets/avatar/default.png'}" alt="Avatar">
                        <form action="changeAvatar" method="post" enctype="multipart/form-data" class="avatar-upload">
                            <label for="avatar">
                                <i class="fas fa-camera me-2"></i>Chọn ảnh mới
                            </label>
                            <input type="file" name="avatar" id="avatar" accept="image/*" onchange="this.form.submit()">
                        </form>
                        <h5 class="mt-3">${username}</h5>
                        <p class="text-muted">${empty employer.name ? 'Chưa có dữ liệu' : employer.name}</p>
                        <div class="mt-4">
                            <a href="CompanyProfile.jsp?accID=${employer.accID}" class="btn btn-outline-primary btn-sm">View Company Profile</a>
                        </div>
                    </div>
                </div>

                <!-- Right Content -->
                <div class="col-md-8">
                    <div class="profile-box">
                        <div class="section-title">
                            <h4>Company Profile</h4>
                        </div>
                        <form id="profileForm" action="EditEmployerProfile" method="post">
                            <div class="row g-3">
                                <div class="col-12">
                                    <label>Company Name</label>
                                    <input type="text" name="name" class="form-control" 
                                           value="${empty employer.name ? 'Chưa có dữ liệu' : employer.name}" readonly>
                                </div>
                                <div class="col-md-6">
                                    <label>Phone Number</label>
                                    <input type="tel" name="phone" class="form-control" 
                                           value="${empty employer.phone ? 'Chưa có dữ liệu' : employer.phone}" readonly>
                                </div>
                                <div class="col-md-6">
                                    <label>Email Address</label>
                                    <input type="email" name="email" class="form-control" value="${email}" readonly>
                                </div>
                                <div class="col-12">
                                    <label>Address</label>
                                    <input type="text" name="address" class="form-control" 
                                           value="${empty employer.address ? 'Chưa có dữ liệu' : employer.address}" readonly>
                                </div>
                                <div class="col-12">
                                    <label>Website</label>
                                    <input type="url" name="website" class="form-control" 
                                           value="${empty employer.website ? 'Chưa có dữ liệu' : employer.website}" readonly>
                                </div>
                            </div>
                            <div class="action-buttons">
                                <button type="button" class="btn btn-primary" id="editBtn" onclick="toggleEdit()">Edit Profile</button>
                                <button type="submit" class="btn btn-success" id="saveBtn" style="display: none;">Save Changes</button>
                                <button type="button" class="btn btn-secondary" id="cancelBtn" onclick="toggleEdit()" style="display: none;">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Include Footer -->
        <jsp:include page="Footer.jsp" />

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function toggleEdit() {
                const form = document.getElementById('profileForm');
                const inputs = form.querySelectorAll('input:not([name="email"])');
                const editBtn = document.getElementById('editBtn');
                const saveBtn = document.getElementById('saveBtn');
                const cancelBtn = document.getElementById('cancelBtn');
                
                if (inputs[0].readOnly) {
                    // Switch to edit mode
                    inputs.forEach(input => {
                        input.readOnly = false;
                        if (input.value === 'Chưa có dữ liệu') {
                            input.value = '';
                        }
                    });
                    editBtn.style.display = 'none';
                    saveBtn.style.display = 'inline-block';
                    cancelBtn.style.display = 'inline-block';
                } else {
                    // Switch back to view mode
                    inputs.forEach(input => {
                        input.readOnly = true;
                    });
                    editBtn.style.display = 'inline-block';
                    saveBtn.style.display = 'none';
                    cancelBtn.style.display = 'none';
                    form.reset();
                }
            }
        </script>
    </body>
</html>
