package dao;

import connect.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.CV;

public class CVDAO {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // Lấy tất cả CVs
    public List<CV> getAllCVs() {
        List<CV> list = new ArrayList<>();
        String query = "SELECT * FROM CVs";

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new CV(
                        rs.getInt("cvID"),
                        rs.getInt("accID"),
                        rs.getString("fullName"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("gender"),
                        rs.getString("education"),
                        rs.getString("experience"),
                        rs.getString("skills")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return list;
    }

    // Lấy CV theo accID
    public CV getCVByAccID(int accID) {
        CV cv = null;
        String sql = "SELECT * FROM CVs WHERE accID = ?";

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, accID);
            rs = ps.executeQuery();

            if (rs.next()) {
                cv = new CV();
                cv.setCvID(rs.getInt("cvID"));
                cv.setAccID(rs.getInt("accID"));
                cv.setFullName(rs.getString("fullName"));
                cv.setPhone(rs.getString("phone"));
                cv.setAddress(rs.getString("address"));
                cv.setGender(rs.getString("gender"));
                cv.setEducation(rs.getString("education"));
                cv.setExperience(rs.getString("experience"));
                cv.setSkills(rs.getString("skills"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return cv;
    }

    // Thêm mới CV
    public boolean insert(CV cv) {
        String sql = "INSERT INTO CVs (accID, fullName, phone, address, gender, education, experience, skills) "
                  + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, cv.getAccID());
            ps.setString(2, cv.getFullName());
            ps.setString(3, cv.getPhone());
            ps.setString(4, cv.getAddress());
            ps.setString(5, cv.getGender());
            ps.setString(6, cv.getEducation());
            ps.setString(7, cv.getExperience());
            ps.setString(8, cv.getSkills());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources();
        }
    }

    // Cập nhật CV
    public boolean update(CV cv) {
        String sql = "UPDATE CVs SET fullName = ?, phone = ?, address = ?, gender = ?, "
                  + "education = ?, experience = ?, skills = ? WHERE cvID = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, cv.getFullName());
            ps.setString(2, cv.getPhone());
            ps.setString(3, cv.getAddress());
            ps.setString(4, cv.getGender());
            ps.setString(5, cv.getEducation());
            ps.setString(6, cv.getExperience());
            ps.setString(7, cv.getSkills());
            ps.setInt(8, cv.getCvID());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources();
        }
    }

    // Đóng kết nối tài nguyên
    private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    // Hàm test
    public static void main(String[] args) {
        CVDAO dao = new CVDAO();

        System.out.println("=== Test getAllCVs() ===");
        List<CV> list = dao.getAllCVs();
        for (CV cv : list) {
            System.out.println("cvID: " + cv.getCvID()
                    + ", accID: " + cv.getAccID()
                    + ", fullName: " + cv.getFullName()
                    + ", phone: " + cv.getPhone()
                    + ", address: " + cv.getAddress()
                    + ", gender: " + cv.getGender()
                    + ", education: " + cv.getEducation()
                    + ", experience: " + cv.getExperience()
                    + ", skills: " + cv.getSkills());
        }

        System.out.println("\n=== Test getCVByAccID(1) ===");
        CV cv = dao.getCVByAccID(2);
        if (cv != null) {
            System.out.println("cvID: " + cv.getCvID()
                    + ", accID: " + cv.getAccID()
                    + ", fullName: " + cv.getFullName()
                    + ", phone: " + cv.getPhone()
                    + ", address: " + cv.getAddress()
                    + ", gender: " + cv.getGender()
                    + ", education: " + cv.getEducation()
                    + ", experience: " + cv.getExperience()
                    + ", skills: " + cv.getSkills());
        } else {
            System.out.println("Không tìm thấy CV với accID = 1");
        }
    }
}
