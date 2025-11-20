<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Tasks - Task Organizer</title>
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
                        <h1>My Tasks</h1>
                        <p class="subtitle">Manage all your tasks</p>
                    </div>
                </div>
                <div class="top-bar-right">
                    <button id="themeToggle" class="btn-icon" title="Toggle Theme">
                        <span class="theme-icon">Theme</span>
                    </button>
                    <a href="add-task.jsp" class="btn btn-primary">
                        <span>Add Task</span>
                    </a>
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

            <!-- Search and Filter -->
            <div class="search-filter-container">
                <div class="search-box">
                    <form action="TaskServlet" method="get">
                        <input type="hidden" name="action" value="search">
                        <input type="text" name="keyword" placeholder="Search tasks by title, description, or tags..." value="${param.keyword}">
                        <button type="submit" class="btn-search">Search</button>
                    </form>
                </div>
                
                <div class="filter-box">
                    <form action="TaskServlet" method="get" class="filter-form" id="filterForm">
                        <input type="hidden" name="action" value="filter">
                        <select name="filterType" id="filterType" onchange="updateFilterOptions()">
                            <option value="">Filter by...</option>
                            <option value="status" ${param.filterType == 'status' ? 'selected' : ''}>Status</option>
                            <option value="priority" ${param.filterType == 'priority' ? 'selected' : ''}>Priority</option>
                            <option value="category" ${param.filterType == 'category' ? 'selected' : ''}>Category</option>
                        </select>
                        
                        <select name="filterValue" id="filterValue">
                            <option value="">Select value...</option>
                        </select>
                        
                        <button type="submit" class="btn-filter">Apply</button>
                        <a href="TaskServlet?action=list" class="btn-reset">Clear</a>
                    </form>
                </div>
            </div>

            <!-- Task List -->
            <div class="task-list">
                <div class="section-header">
                    <h2>
                        <c:choose>
                            <c:when test="${not empty param.keyword}">
                                Search Results for "${param.keyword}"
                            </c:when>
                            <c:when test="${not empty param.filterType}">
                                Filtered by ${param.filterType}: ${param.filterValue}
                            </c:when>
                            <c:otherwise>
                                All Tasks
                            </c:otherwise>
                        </c:choose>
                    </h2>
                    <span class="task-count">${tasks.size()} task(s)</span>
                </div>
                
                <c:choose>
                    <c:when test="${empty tasks}">
                        <div class="no-tasks">
                            <h3>No Tasks Found</h3>
                            <p>
                                <c:choose>
                                    <c:when test="${not empty param.keyword}">
                                        No tasks match your search criteria.
                                    </c:when>
                                    <c:when test="${not empty param.filterType}">
                                        No tasks found with these filter settings.
                                    </c:when>
                                    <c:otherwise>
                                        Create your first task to get started!
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <a href="add-task.jsp" class="btn btn-primary">Add Task</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="tasks-grid">
                            <c:forEach var="task" items="${tasks}">
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
                                    
                                    <c:if test="${not empty task.notes}">
                                        <div class="task-notes">
                                            ${task.notes}
                                        </div>
                                    </c:if>
                                    
                                    <div class="task-dates">
                                        <div class="date-item">
                                            <span class="date-label">Created:</span>
                                            <fmt:formatDate value="${task.createdDate}" pattern="MMM dd, yyyy"/>
                                        </div>
                                        <c:if test="${not empty task.dueDate}">
                                            <div class="date-item">
                                                <span class="date-label">Due:</span>
                                                <fmt:formatDate value="${task.dueDate}" pattern="MMM dd, yyyy"/>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty task.completedDate}">
                                            <div class="date-item">
                                                <span class="date-label">Completed:</span>
                                                <fmt:formatDate value="${task.completedDate}" pattern="MMM dd, yyyy"/>
                                            </div>
                                        </c:if>
                                    </div>
                                    
                                    <!-- Quick Status Update -->
                                    <div class="quick-status">
                                        <label>Quick Status:</label>
                                        <select class="status-selector" data-task-id="${task.id}">
                                            <option value="Pending" ${task.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                            <option value="In Progress" ${task.status == 'In Progress' ? 'selected' : ''}>In Progress</option>
                                            <option value="Completed" ${task.status == 'Completed' ? 'selected' : ''}>Completed</option>
                                        </select>
                                    </div>
                                    
                                    <div class="task-actions">
                                        <a href="TaskServlet?action=edit&id=${task.id}" class="btn btn-edit">Edit</a>
                                        <a href="TaskServlet?action=delete&id=${task.id}" class="btn btn-delete" 
                                           onclick="return confirm('Are you sure you want to delete this task?')">Delete</a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <script>
        // Filter options update
        function updateFilterOptions() {
            const filterType = document.getElementById('filterType').value;
            const filterValue = document.getElementById('filterValue');
            
            filterValue.innerHTML = '<option value="">Select value...</option>';
            
            if (filterType === 'status') {
                filterValue.innerHTML += '<option value="Pending">Pending</option>';
                filterValue.innerHTML += '<option value="In Progress">In Progress</option>';
                filterValue.innerHTML += '<option value="Completed">Completed</option>';
            } else if (filterType === 'priority') {
                filterValue.innerHTML += '<option value="High">High</option>';
                filterValue.innerHTML += '<option value="Medium">Medium</option>';
                filterValue.innerHTML += '<option value="Low">Low</option>';
            } else if (filterType === 'category') {
                filterValue.innerHTML += '<option value="General">General</option>';
                filterValue.innerHTML += '<option value="Work">Work</option>';
                filterValue.innerHTML += '<option value="Personal">Personal</option>';
                filterValue.innerHTML += '<option value="Development">Development</option>';
                filterValue.innerHTML += '<option value="Health">Health</option>';
                filterValue.innerHTML += '<option value="Finance">Finance</option>';
                filterValue.innerHTML += '<option value="Education">Education</option>';
                filterValue.innerHTML += '<option value="Other">Other</option>';
            }
        }
        
        // Initialize filter options if filter type is selected
        window.onload = function() {
            const filterType = document.getElementById('filterType').value;
            if (filterType) {
                updateFilterOptions();
                const filterValue = '${param.filterValue}';
                if (filterValue) {
                    document.getElementById('filterValue').value = filterValue;
                }
            }
        };
    </script>
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
    <script src="js/quick-status.js"></script>
    <script src="js/sidebar.js"></script>
    <script src="js/profile-dropdown.js"></script>
    <script src="js/task-notifications.js"></script>
</body>
</html>
