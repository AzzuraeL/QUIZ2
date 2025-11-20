<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calendar - Task Organizer</title>
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
                        <h1>Calendar View</h1>
                        <p class="subtitle">View your tasks by due date</p>
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

            <!-- Calendar Container -->
            <div class="calendar-container">
                <!-- Calendar Header -->
                <div class="calendar-header">
                    <div class="calendar-nav">
                        <button id="prevMonth">← Previous</button>
                        <h2 class="calendar-title" id="calendarTitle">Month Year</h2>
                        <button id="nextMonth">Next →</button>
                    </div>
                    <div class="calendar-actions">
                        <button id="todayBtn" class="btn btn-primary">Today</button>
                        <a href="add-task.jsp" class="btn btn-primary">Add Task</a>
                    </div>
                </div>

                <!-- Calendar Grid -->
                <div class="calendar-grid">
                    <div class="calendar-weekdays">
                        <div class="calendar-weekday">Sunday</div>
                        <div class="calendar-weekday">Monday</div>
                        <div class="calendar-weekday">Tuesday</div>
                        <div class="calendar-weekday">Wednesday</div>
                        <div class="calendar-weekday">Thursday</div>
                        <div class="calendar-weekday">Friday</div>
                        <div class="calendar-weekday">Saturday</div>
                    </div>
                    <div class="calendar-days" id="calendarDays">
                        <!-- Days will be generated by JavaScript -->
                    </div>
                </div>

                <!-- Calendar Legend -->
                <div class="calendar-legend">
                    <h3>Legend</h3>
                    <div class="legend-items">
                        <div class="legend-item">
                            <div class="legend-color" style="background: var(--color-high);"></div>
                            <span class="legend-label">High Priority</span>
                        </div>
                        <div class="legend-item">
                            <div class="legend-color" style="background: var(--color-medium);"></div>
                            <span class="legend-label">Medium Priority</span>
                        </div>
                        <div class="legend-item">
                            <div class="legend-color" style="background: var(--color-completed);"></div>
                            <span class="legend-label">Low Priority</span>
                        </div>
                        <div class="legend-item">
                            <div class="legend-color" style="background: var(--bg-gradient-start); opacity: 0.6; text-decoration: line-through;"></div>
                            <span class="legend-label">Completed Task</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Task Modal -->
    <div class="task-modal-overlay" id="taskModal">
        <div class="task-modal">
            <div class="task-modal-header">
                <h2 id="modalTaskTitle">Task Details</h2>
                <button class="task-modal-close" id="closeModal">&times;</button>
            </div>
            <div id="modalTaskContent">
                <!-- Task details will be loaded here -->
            </div>
        </div>
    </div>

    <!-- Pass tasks data to JavaScript -->
    <script>
        const tasksData = [
            <c:forEach var="task" items="${tasks}" varStatus="status">
            {
                id: ${task.id},
                title: "${fn:escapeXml(task.title)}",
                description: "${fn:escapeXml(task.description)}",
                priority: "${task.priority}",
                status: "${task.status}",
                category: "${task.category}",
                dueDate: "<fmt:formatDate value='${task.dueDate}' pattern='yyyy-MM-dd'/>",
                tags: "${fn:escapeXml(task.tags)}"
            }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
    </script>
    
    <script src="js/theme.js"></script>
    <script src="js/sidebar.js"></script>
    <script src="js/profile-dropdown.js"></script>
    <script src="js/calendar.js"></script>
</body>
</html>
