package controller;

import dao.AccountDAO;
import dao.CVDAO;
import model.Account;
import model.CV;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "JSKProfileServlet", urlPatterns = {"/JSKProfile"})
public class JSKProfileServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        // Thêm debug log
        System.out.println("Debug - Session ID: " + session.getId());
        System.out.println("Debug - Account from session: " + (account == null ? "null" : account.getUsername()));

        // Nếu chưa đăng nhập thì redirect về login
        if (account == null) {
            System.out.println("Debug - No account found in session, redirecting to Login.jsp");
            response.sendRedirect("Login.jsp");
            return;
        }

        try {
            // Khởi tạo DAO
            AccountDAO accountDAO = new AccountDAO();
            CVDAO cvDAO = new CVDAO();

            // Lấy thông tin chi tiết từ DB
            Account detailedAccount = accountDAO.getAccountById(account.getAccID());
            System.out.println("Debug - Detailed account: " + (detailedAccount == null ? "null" : detailedAccount.getUsername()));
            
            CV cv = cvDAO.getCVByAccID(account.getAccID());
            System.out.println("Debug - CV data: " + (cv == null ? "null" : "found"));

            // Gửi dữ liệu lên JSP
            request.setAttribute("username", detailedAccount.getUsername());
            request.setAttribute("email", detailedAccount.getEmail());
            request.setAttribute("cv", cv);

            // Chuyển đến trang JSP
            request.getRequestDispatcher("JobSeekerProfile.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Error in JSKProfileServlet: " + e.getMessage());
            e.printStackTrace(); // In ra stack trace để debug
            session.setAttribute("error", "Có lỗi xảy ra khi tải thông tin profile: " + e.getMessage());
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
