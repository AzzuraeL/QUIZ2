<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - Task Organizer</title>
    <link rel="stylesheet" href="css/style-new.css">
</head>
<body>
    <div class="app-container">
        <!-- Sidebar Navigation -->
        <jsp:include page="sidebar.jsp" />
        
        <!-- Main Content -->
        <div class="main-content">
            <!-- Top Bar -->
            <div class="top-bar">
                <div class="top-bar-left">
                    <button id="sidebarToggle" class="hamburger-btn" title="Toggle Sidebar">
                        <span class="hamburger-icon">☰</span>
                    </button>
                    <div class="top-bar-title">
                        <h1>My Profile</h1>
                        <p class="subtitle">Manage your account information</p>
                    </div>
                </div>
                <div class="top-bar-right">
                    <button id="themeToggle" class="btn-icon" title="Toggle Theme">
                        <span class="theme-icon">Theme</span>
                    </button>
                    <a href="TaskServlet?action=dashboard" class="btn-icon" title="Dashboard">
                        <span>Dashboard</span>
                    </a>
                    <a href="LogoutServlet" class="btn-logout">Logout</a>
                </div>
            </div>

            <!-- Profile Content -->
            <div class="profile-container">
                <!-- Success/Error Messages -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success">
                        ${success}
                    </div>
                </c:if>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        ${error}
                    </div>
                </c:if>
                
                <div class="profile-content">
                    <!-- Profile Card -->
                    <div class="profile-card">
                        <div class="profile-header">
                            <div class="profile-avatar-large">
                                ${user.name.substring(0, 1).toUpperCase()}
                            </div>
                            <h2>${user.name}</h2>
                            <p class="profile-email">${user.email}</p>
                        </div>
                        
                        <div class="profile-stats">
                            <div class="profile-stat-item">
                                <div class="profile-stat-info">
                                    <div class="profile-stat-label">Member Since</div>
                                    <div class="profile-stat-value">
                                        <fmt:formatDate value="${user.createdDate}" pattern="MMM dd, yyyy"/>
                                    </div>
                                </div>
                            </div>
                            
                            <c:if test="${not empty user.lastLogin}">
                                <div class="profile-stat-item">
                                    <div class="profile-stat-info">
                                        <div class="profile-stat-label">Last Login</div>
                                        <div class="profile-stat-value">
                                            <fmt:formatDate value="${user.lastLogin}" pattern="MMM dd, yyyy HH:mm"/>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                        
                        <button type="button" id="editProfileBtn" class="btn btn-primary" style="width: 100%; margin-top: 20px;">
                            Edit Profile
                        </button>
                    </div>
                    
                    <!-- Edit Profile Form -->
                    <div class="profile-form-card" id="editProfileForm" style="display: none;">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                            <h3>Edit Profile</h3>
                            <button type="button" id="cancelEditBtn" class="btn btn-secondary">Cancel</button>
                        </div>
                        
                        <form action="ProfileServlet" method="post" class="profile-form">
                            <input type="hidden" name="action" value="update">
                            
                            <div class="form-group">
                                <label for="name">Full Name <span class="required">*</span></label>
                                <input type="text" id="name" name="name" value="${user.name}" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="email">Email Address <span class="required">*</span></label>
                                <input type="email" id="email" name="email" value="${user.email}" required>
                            </div>
                            
                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary">
                                    Save Changes
                                </button>
                            </div>
                        </form>
                        
                        <div class="profile-info-box">
                            <h4>Security Note</h4>
                            <p>Your password is securely encrypted and cannot be displayed. To change your password, please contact support.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="js/theme.js"></script>
    <script src="js/sidebar.js"></script>
    <script>
        // Toggle edit profile form
        document.getElementById('editProfileBtn').addEventListener('click', function() {
            document.getElementById('editProfileForm').style.display = 'block';
            this.style.display = 'none';
        });
        
        document.getElementById('cancelEditBtn').addEventListener('click', function() {
            document.getElementById('editProfileForm').style.display = 'none';
            document.getElementById('editProfileBtn').style.display = 'block';
        });
    </script>
</body>
</html>
