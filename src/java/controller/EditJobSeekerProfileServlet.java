package controller;

import dao.AccountDAO;
import dao.CVDAO;
import model.Account;
import model.CV;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "EditJobSeekerProfile", urlPatterns = {"/EditJobSeekerProfile"})
public class EditJobSeekerProfileServlet extends HttpServlet {

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
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String education = request.getParameter("education");
        String experience = request.getParameter("experience");
        String skills = request.getParameter("skills");

        // Clean up "Chưa có dữ liệu" placeholder values
        fullName = "Chưa có dữ liệu".equals(fullName) ? "" : fullName;
        phone = "Chưa có dữ liệu".equals(phone) ? "" : phone;
        address = "Chưa có dữ liệu".equals(address) ? "" : address;
        education = "Chưa có dữ liệu".equals(education) ? "" : education;
        experience = "Chưa có dữ liệu".equals(experience) ? "" : experience;
        skills = "Chưa có dữ liệu".equals(skills) ? "" : skills;

        try {
            CVDAO cvDao = new CVDAO();
            CV cv = cvDao.getCVByAccID(account.getAccID());
            
            if (cv == null) {
                // Create new CV if it doesn't exist
                cv = new CV();
                cv.setAccID(account.getAccID());
            }
            
            // Update CV object
            cv.setFullName(fullName);
            cv.setPhone(phone);
            cv.setAddress(address);
            cv.setGender(gender);
            cv.setEducation(education);
            cv.setExperience(experience);
            cv.setSkills(skills);
            
            if (cv.getCvID() == 0) {
                // Insert new CV
                cvDao.insert(cv);
            } else {
                // Update existing CV
                cvDao.update(cv);
            }
            
            // Update session attribute
            session.setAttribute("cv", cv);
            
            // Redirect back to profile page with success message
            session.setAttribute("message", "Profile updated successfully!");
            response.sendRedirect("JSKProfile");
            
        } catch (Exception e) {
            // Handle any errors
            session.setAttribute("error", "Error updating profile: " + e.getMessage());
            response.sendRedirect("JSKProfile");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to profile page
        response.sendRedirect("JSKProfile");
    }
} 