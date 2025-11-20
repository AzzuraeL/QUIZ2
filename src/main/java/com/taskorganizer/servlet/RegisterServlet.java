package com.taskorganizer.servlet;

import com.taskorganizer.dao.UserDAO;
import com.taskorganizer.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to register page
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate input
        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Name is required");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Email is required");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Validate email format
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("errorMessage", "Invalid email format");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        if (password == null || password.length() < 6) {
            request.setAttribute("errorMessage", "Password must be at least 6 characters");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Check if email already exists
        if (userDAO.emailExists(email.trim())) {
            request.setAttribute("errorMessage", "Email already registered");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Create new user
        User user = new User(name.trim(), email.trim(), password);
        
        if (userDAO.registerUser(user)) {
            // Registration successful - auto login
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getName());
            session.setMaxInactiveInterval(30 * 60); // 30 minutes
            
            request.setAttribute("successMessage", "Registration successful! Welcome to Task Organizer.");
            response.sendRedirect("TaskServlet?action=dashboard");
        } else {
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
