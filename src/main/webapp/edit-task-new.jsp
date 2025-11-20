<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Task - Task Organizer</title>
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
                        <h1>Edit Task</h1>
                        <p class="subtitle">Update your task details</p>
                    </div>
                </div>
                <div class="top-bar-right">
                    <button id="themeToggle" class="btn-icon" title="Toggle Theme">
                        <span class="theme-icon">Theme</span>
                    </button>
                    <a href="ProfileServlet" class="btn-icon" title="Profile">
                        <span>Profile</span>
                    </a>
                    <a href="LogoutServlet" class="btn-logout">Logout</a>
                </div>
            </div>

            <!-- Edit Task Form -->
            <div class="form-container-page">
                <form action="TaskServlet" method="post" class="task-form">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${task.id}">
                    
                    <div class="form-section">
                        <h3>Basic Information</h3>
                        
                        <div class="form-group">
                            <label for="title">Task Title <span class="required">*</span></label>
                            <input type="text" id="title" name="title" value="${task.title}" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="description">Description</label>
                            <textarea id="description" name="description" rows="4">${task.description}</textarea>
                        </div>
                    </div>
                    
                    <div class="form-section">
                        <h3>Task Details</h3>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="priority">Priority <span class="required">*</span></label>
                                <select id="priority" name="priority" required>
                                    <option value="High" ${task.priority == 'High' ? 'selected' : ''}>High</option>
                                    <option value="Medium" ${task.priority == 'Medium' ? 'selected' : ''}>Medium</option>
                                    <option value="Low" ${task.priority == 'Low' ? 'selected' : ''}>Low</option>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="status">Status <span class="required">*</span></label>
                                <select id="status" name="status" required>
                                    <option value="Pending" ${task.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                    <option value="In Progress" ${task.status == 'In Progress' ? 'selected' : ''}>In Progress</option>
                                    <option value="Completed" ${task.status == 'Completed' ? 'selected' : ''}>Completed</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="category">Category</label>
                                <select id="category" name="category">
                                    <option value="General" ${task.category == 'General' ? 'selected' : ''}>General</option>
                                    <option value="Work" ${task.category == 'Work' ? 'selected' : ''}>Work</option>
                                    <option value="Personal" ${task.category == 'Personal' ? 'selected' : ''}>Personal</option>
                                    <option value="Development" ${task.category == 'Development' ? 'selected' : ''}>Development</option>
                                    <option value="Health" ${task.category == 'Health' ? 'selected' : ''}>Health</option>
                                    <option value="Finance" ${task.category == 'Finance' ? 'selected' : ''}>Finance</option>
                                    <option value="Education" ${task.category == 'Education' ? 'selected' : ''}>Education</option>
                                    <option value="Other" ${task.category == 'Other' ? 'selected' : ''}>Other</option>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="dueDate">Due Date</label>
                                <input type="date" id="dueDate" name="dueDate" 
                                       value="<fmt:formatDate value='${task.dueDate}' pattern='yyyy-MM-dd'/>">
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-section">
                        <h3>Additional Information</h3>
                        
                        <div class="form-group">
                            <label for="tags">Tags</label>
                            <input type="text" id="tags" name="tags" value="${task.tags}"
                                   placeholder="e.g., urgent, meeting, backend (comma-separated)">
                            <small class="form-help">Separate tags with commas</small>
                        </div>
                        
                        <div class="form-group">
                            <label for="notes">Notes</label>
                            <textarea id="notes" name="notes" rows="3">${task.notes}</textarea>
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">
                            <span>Update Task</span>
                        </button>
                        <a href="TaskServlet?action=list" class="btn btn-secondary">
                            <span>Cancel</span>
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="js/theme.js"></script>
    <script src="js/sidebar.js"></script>
</body>
</html>
