<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Task - Task Organizer</title>
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
                        <h1>Add New Task</h1>
                        <p class="subtitle">Create a new task to stay organized</p>
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

            <!-- Add Task Form -->
            <div class="form-container-page">
                <form action="TaskServlet" method="post" class="task-form">
                    <input type="hidden" name="action" value="add">
                    
                    <div class="form-section">
                        <h3>Basic Information</h3>
                        
                        <div class="form-group">
                            <label for="title">Task Title <span class="required">*</span></label>
                            <input type="text" id="title" name="title" required 
                                   placeholder="e.g., Complete project proposal">
                        </div>
                        
                        <div class="form-group">
                            <label for="description">Description</label>
                            <textarea id="description" name="description" rows="4" 
                                      placeholder="Provide details about this task..."></textarea>
                        </div>
                    </div>
                    
                    <div class="form-section">
                        <h3>Task Details</h3>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="priority">Priority <span class="required">*</span></label>
                                <select id="priority" name="priority" required>
                                    <option value="Medium" selected>Medium</option>
                                    <option value="High">High</option>
                                    <option value="Low">Low</option>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="status">Status <span class="required">*</span></label>
                                <select id="status" name="status" required>
                                    <option value="Pending" selected>Pending</option>
                                    <option value="In Progress">In Progress</option>
                                    <option value="Completed">Completed</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="category">Category</label>
                                <select id="category" name="category">
                                    <option value="General" selected>General</option>
                                    <option value="Work">Work</option>
                                    <option value="Personal">Personal</option>
                                    <option value="Development">Development</option>
                                    <option value="Health">Health</option>
                                    <option value="Finance">Finance</option>
                                    <option value="Education">Education</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="dueDate">Due Date</label>
                                <input type="date" id="dueDate" name="dueDate">
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-section">
                        <h3>Additional Information</h3>
                        
                        <div class="form-group">
                            <label for="tags">Tags</label>
                            <input type="text" id="tags" name="tags" 
                                   placeholder="e.g., urgent, meeting, backend (comma-separated)">
                            <small class="form-help">Separate tags with commas</small>
                        </div>
                        
                        <div class="form-group">
                            <label for="notes">Notes</label>
                            <textarea id="notes" name="notes" rows="3" 
                                      placeholder="Add any additional notes or reminders..."></textarea>
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">
                            <span>Create Task</span>
                        </button>
                        <a href="dashboard.jsp" class="btn btn-secondary">
                            <span>Cancel</span>
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="js/theme.js"></script>
    <script src="js/sidebar.js"></script>
    <script src="js/profile-dropdown.js"></script>
</body>
</html>
