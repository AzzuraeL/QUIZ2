<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Task Organizer</title>
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
                        <h1>Dashboard</h1>
                        <p class="subtitle">Welcome back, <strong>${sessionScope.userName}</strong>!</p>
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

            <!-- Statistics Cards -->
            <div class="stats-container">
                <div class="stat-card stat-pending">
                    <div class="stat-info">
                        <h3>${stats.Pending != null ? stats.Pending : 0}</h3>
                        <p>Pending Tasks</p>
                    </div>
                </div>
                
                <div class="stat-card stat-progress">
                    <div class="stat-info">
                        <h3>${stats['In Progress'] != null ? stats['In Progress'] : 0}</h3>
                        <p>In Progress</p>
                    </div>
                </div>
                
                <div class="stat-card stat-completed">
                    <div class="stat-info">
                        <h3>${stats.Completed != null ? stats.Completed : 0}</h3>
                        <p>Completed</p>
                    </div>
                </div>
                
                <div class="stat-card stat-total">
                    <div class="stat-info">
                        <h3>${stats.Total != null ? stats.Total : 0}</h3>
                        <p>Total Tasks</p>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <h2>Quick Actions</h2>
                <div class="action-buttons">
                    <a href="add-task.jsp" class="action-btn action-primary">
                        <span class="action-text">Add New Task</span>
                    </a>
                    <a href="TaskServlet?action=list" class="action-btn action-secondary">
                        <span class="action-text">View All Tasks</span>
                    </a>
                    <a href="TaskServlet?action=filter&filterType=status&filterValue=Pending" class="action-btn action-warning">
                        <span class="action-text">Pending Tasks</span>
                    </a>
                    <a href="TaskServlet?action=filter&filterType=priority&filterValue=High" class="action-btn action-danger">
                        <span class="action-text">High Priority</span>
                    </a>
                </div>
            </div>

            <!-- Recent Tasks -->
            <div class="recent-tasks">
                <div class="section-header">
                    <h2>Recent Tasks</h2>
                    <a href="TaskServlet?action=list" class="btn-link">View All</a>
                </div>
                
                <c:choose>
                    <c:when test="${empty recentTasks}">
                        <div class="no-tasks">
                            <h3>No Tasks Yet</h3>
                            <p>Create your first task to get started!</p>
                            <a href="add-task.jsp" class="btn btn-primary">Add Task</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="tasks-grid">
                            <c:forEach var="task" items="${recentTasks}">
                                <div class="task-card priority-${task.priority} ${task.status == 'Completed' ? 'completed' : ''}">
                                    <div class="task-header">
                                        <div>
                                            <h3>${task.title}</h3>
                                            <span class="task-category">${task.category}</span>
                                        </div>
                                        <span class="task-id">#${task.id}</span>
                                    </div>
                                    
                                    <p class="task-description">${task.description}</p>
                                    
                                    <div class="task-meta">
                                        <span class="badge priority-badge priority-${task.priority}">${task.priority}</span>
                                        <span class="badge status-badge status-${task.status.replace(' ', '')}">${task.status}</span>
                                    </div>
                                    
                                    <c:if test="${not empty task.tags}">
                                        <div class="task-tags">
                                            <c:forEach var="tag" items="${task.tags.split(',')}">
                                                <span class="tag">${tag.trim()}</span>
                                            </c:forEach>
                                        </div>
                                    </c:if>
                                    
                                    <!-- Quick Status Update -->
                                    <div class="quick-status">
                                        <label>Quick Status:</label>
                                        <select class="status-selector" data-task-id="${task.id}" onchange="updateStatus(${task.id}, this.value)">
                                            <option value="Pending" ${task.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                            <option value="In Progress" ${task.status == 'In Progress' ? 'selected' : ''}>In Progress</option>
                                            <option value="Completed" ${task.status == 'Completed' ? 'selected' : ''}>Completed</option>
                                        </select>
                                    </div>
                                    
                                    <div class="task-actions">
                                        <a href="TaskServlet?action=edit&id=${task.id}" class="btn btn-edit">Edit</a>
                                        <a href="TaskServlet?action=delete&id=${task.id}" class="btn btn-delete" onclick="return confirm('Are you sure you want to delete this task?')">Delete</a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <script src="js/theme.js"></script>
    <script src="js/quick-status.js"></script>
    <script src="js/sidebar.js"></script>
</body>
</html>
