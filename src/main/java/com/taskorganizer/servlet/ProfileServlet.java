package com.taskorganizer.servlet;

import com.taskorganizer.dao.TaskDAO;
import com.taskorganizer.dao.UserDAO;
import com.taskorganizer.model.Task;
import com.taskorganizer.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private TaskDAO taskDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        taskDAO = new TaskDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        
        User user = userDAO.getUserById(userId);
        request.setAttribute("user", user);
        
        // Get task statistics for the profile page
        Map<String, Integer> stats = taskDAO.getTaskStatistics(userId);
        request.setAttribute("stats", stats);
        
        // Get tasks for notifications
        List<Task> tasks = taskDAO.getAllTasks(userId);
        request.setAttribute("tasks", tasks);
        
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        
        String action = request.getParameter("action");
        
        if ("update".equals(action)) {
            updateProfile(request, response, userId);
        } else if ("changePassword".equals(action)) {
            changePassword(request, response, userId);
        }
    }
    
    private void updateProfile(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        
        User user = userDAO.getUserById(userId);
        
        // Check if email is changed and already exists
        if (!user.getEmail().equals(email) && userDAO.emailExists(email)) {
            request.setAttribute("error", "Email already in use by another account");
            request.setAttribute("user", user);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }
        
        user.setName(name);
        user.setEmail(email);
        
        boolean success = userDAO.updateUser(user);
        
        if (success) {
            // Update session
            request.getSession().setAttribute("userName", name);
            request.getSession().setAttribute("user", user);
            
            request.setAttribute("success", "Profile updated successfully!");
            request.setAttribute("user", user);
        } else {
            request.setAttribute("error", "Failed to update profile");
            request.setAttribute("user", user);
        }
        
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
    
    private void changePassword(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        User user = userDAO.getUserById(userId);
        
        // Validate passwords match
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "New passwords do not match");
            request.setAttribute("user", user);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }
        
        // Validate password length
        if (newPassword.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters long");
            request.setAttribute("user", user);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }
        
        // Attempt to update password
        boolean success = userDAO.updatePassword(userId, currentPassword, newPassword);
        
        if (success) {
            request.setAttribute("success", "Password changed successfully!");
            request.setAttribute("user", user);
        } else {
            request.setAttribute("error", "Current password is incorrect");
            request.setAttribute("user", user);
        }
        
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
