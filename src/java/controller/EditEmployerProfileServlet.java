package controller;

import dao.AccountDAO;
import dao.EmployerDAO;
import model.Account;
import model.Employer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "EditEmployerProfile", urlPatterns = {"/EditEmployerProfile"})
public class EditEmployerProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        
        if (account == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Get parameters from the form
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String website = request.getParameter("website");

        // Clean up "Chưa có dữ liệu" placeholder values
        name = "Chưa có dữ liệu".equals(name) ? "" : name;
        phone = "Chưa có dữ liệu".equals(phone) ? "" : phone;
        address = "Chưa có dữ liệu".equals(address) ? "" : address;
        website = "Chưa có dữ liệu".equals(website) ? "" : website;

        try {
            EmployerDAO employerDao = new EmployerDAO();
            Employer employer = employerDao.getEmployerById(account.getAccID());
            boolean isNewEmployer = (employer == null);
            
            if (isNewEmployer) {
                // Create new Employer if it doesn't exist
                employer = new Employer(account.getAccID(), name, address, email, phone, website);
            } else {
                // Update existing Employer
                employer.setName(name);
                employer.setPhone(phone);
                employer.setAddress(address);
                employer.setEmail(email);
                employer.setWebsite(website);
            }
            
            boolean success;
            if (isNewEmployer) {
                // Insert new Employer
                success = employerDao.insertEmployer(employer);
            } else {
                // Update existing Employer
                success = employerDao.updateEmployer(employer);
            }
            
            if (success) {
                // Update session attribute
                session.setAttribute("employer", employer);
                session.setAttribute("message", "Cập nhật hồ sơ thành công!");
            } else {
                session.setAttribute("error", "Không thể cập nhật hồ sơ!");
            }
            
        } catch (Exception e) {
            // Handle any errors
            System.out.println("Error updating employer profile: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("error", "Có lỗi xảy ra khi cập nhật hồ sơ: " + e.getMessage());
        }
        
        response.sendRedirect("EmployerProfile");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to profile page
        response.sendRedirect("EmployerProfile");
    }
} 