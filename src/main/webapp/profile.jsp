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
                    <div class="profile-dropdown-container">
                        <button class="profile-avatar-btn" id="profileDropdownBtn" title="Profile Menu">
                            ${sessionScope.userName.substring(0, 1).toUpperCase()}
                        </button>
                        <div class="profile-dropdown-menu" id="profileDropdownMenu">
                            <div class="dropdown-header">
                                <div class="dropdown-avatar">
                                    ${sessionScope.userName.substring(0, 1).toUpperCase()}
                                </div>
                                <div class="dropdown-user-info">
                                    <div class="dropdown-username">${sessionScope.userName}</div>
                                    <div class="dropdown-email">${sessionScope.user.email}</div>
                                </div>
                            </div>
                            <div class="dropdown-divider"></div>
                            <a href="ProfileServlet" class="dropdown-item">
                                <span class="dropdown-icon">👤</span>
                                <span>My Profile</span>
                            </a>
                            <a href="TaskServlet?action=dashboard" class="dropdown-item">
                                <span class="dropdown-icon">📊</span>
                                <span>Dashboard</span>
                            </a>
                            <a href="TaskServlet?action=list" class="dropdown-item">
                                <span class="dropdown-icon">✓</span>
                                <span>My Tasks</span>
                            </a>
                            <div class="dropdown-divider"></div>
                            <a href="LogoutServlet" class="dropdown-item dropdown-logout">
                                <span class="dropdown-icon">🚪</span>
                                <span>Logout</span>
                            </a>
                        </div>
                    </div>
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
                            
                            <div class="profile-stat-item" style="border-left-color: var(--color-total);">
                                <div class="profile-stat-info">
                                    <div class="profile-stat-label">Total Tasks</div>
                                    <div class="profile-stat-value">
                                        ${stats.Total != null ? stats.Total : 0}
                                    </div>
                                </div>
                            </div>
                            
                            <div class="profile-stat-item" style="border-left-color: var(--color-completed);">
                                <div class="profile-stat-info">
                                    <div class="profile-stat-label">Completed Tasks</div>
                                    <div class="profile-stat-value">
                                        ${stats.Completed != null ? stats.Completed : 0}
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="profile-actions-grid">
                            <a href="TaskServlet?action=dashboard" class="profile-action-card">
                                <div class="profile-action-icon">📊</div>
                                <div class="profile-action-title">Dashboard</div>
                                <div class="profile-action-description">View overview</div>
                            </a>
                            <a href="TaskServlet?action=list" class="profile-action-card">
                                <div class="profile-action-icon">✓</div>
                                <div class="profile-action-title">My Tasks</div>
                                <div class="profile-action-description">Manage tasks</div>
                            </a>
                            <a href="TaskServlet?action=calendar" class="profile-action-card">
                                <div class="profile-action-icon">📅</div>
                                <div class="profile-action-title">Calendar</div>
                                <div class="profile-action-description">View schedule</div>
                            </a>
                        </div>
                        
                        <button type="button" id="editProfileBtn" class="btn btn-primary" style="width: 100%; margin-top: 20px;">
                            📝 Edit Profile Information
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
                    </div>
                    
                    <!-- Change Password Section -->
                    <div class="profile-form-card password-section">
                        <h3>🔒 Security & Password</h3>
                        <p style="color: var(--text-secondary); margin-bottom: 15px; font-size: 0.9em;">
                            Keep your account secure by regularly updating your password
                        </p>
                        
                        <button type="button" id="changePasswordBtn" class="btn btn-secondary" style="width: 100%;">
                            🔑 Change Password
                        </button>
                        
                        <div id="changePasswordForm" style="display: none; margin-top: 20px;">
                            <form action="ProfileServlet" method="post" class="profile-form">
                                <input type="hidden" name="action" value="changePassword">
                                
                                <div class="form-group">
                                    <label for="currentPassword">Current Password <span class="required">*</span></label>
                                    <input type="password" id="currentPassword" name="currentPassword" required>
                                </div>
                                
                                <div class="form-group">
                                    <label for="newPassword">New Password <span class="required">*</span></label>
                                    <input type="password" id="newPassword" name="newPassword" required minlength="6">
                                </div>
                                
                                <div class="form-group">
                                    <label for="confirmPassword">Confirm New Password <span class="required">*</span></label>
                                    <input type="password" id="confirmPassword" name="confirmPassword" required minlength="6">
                                </div>
                                
                                <div class="password-requirements">
                                    <h4>Password Requirements:</h4>
                                    <ul>
                                        <li>At least 6 characters long</li>
                                        <li>Use a mix of letters and numbers for better security</li>
                                        <li>Avoid using easily guessable passwords</li>
                                    </ul>
                                </div>
                                
                                <div class="form-actions">
                                    <button type="submit" class="btn btn-primary">
                                        Update Password
                                    </button>
                                    <button type="button" id="cancelPasswordBtn" class="btn btn-secondary">
                                        Cancel
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // Pass tasks data for notifications
        const tasksData = [
            <c:forEach var="task" items="${tasks}" varStatus="status">
            {
                id: ${task.id},
                title: "${task.title}".replace(/"/g, '&quot;'),
                priority: "${task.priority}",
                status: "${task.status}",
                dueDate: "<fmt:formatDate value='${task.dueDate}' pattern='yyyy-MM-dd'/>"
            }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
    </script>
    <script src="js/theme.js"></script>
    <script src="js/sidebar.js"></script>
    <script src="js/profile-dropdown.js"></script>
    <script src="js/task-notifications.js"></script>
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
        
        // Toggle password change form
        const changePasswordBtn = document.getElementById('changePasswordBtn');
        if (changePasswordBtn) {
            changePasswordBtn.addEventListener('click', function() {
                document.getElementById('changePasswordForm').style.display = 'block';
                this.style.display = 'none';
            });
        }
        
        const cancelPasswordBtn = document.getElementById('cancelPasswordBtn');
        if (cancelPasswordBtn) {
            cancelPasswordBtn.addEventListener('click', function() {
                document.getElementById('changePasswordForm').style.display = 'none';
                document.getElementById('changePasswordBtn').style.display = 'block';
            });
        }
    </script>
</body>
</html>
