package model;

public class CV {
    private int cvID;
    private int accID;
    private String fullName;
    private String phone;
    private String address;
    private String gender;
    private String education;
    private String experience;
    private String skills;

    // Constructor mặc định
    public CV() {
    }

    // Constructor có tham số
    public CV(int cvID, int accID, String fullName, String phone, String address, String gender, String education, String experience, String skills) {
        this.cvID = cvID;
        this.accID = accID;
        this.fullName = fullName;
        this.phone = phone;
        this.address = address;
        this.gender = gender;
        this.education = education;
        this.experience = experience;
        this.skills = skills;
    }

    // Getter & Setter
    public int getCvID() {
        return cvID;
    }

    public void setCvID(int cvID) {
        this.cvID = cvID;
    }

    public int getAccID() {
        return accID;
    }

    public void setAccID(int accID) {
        this.accID = accID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getExperience() {
        return experience;
    }

    public void setExperience(String experience) {
        this.experience = experience;
    }

    public String getSkills() {
        return skills;
    }

    public void setSkills(String skills) {
        this.skills = skills;
    }
}
