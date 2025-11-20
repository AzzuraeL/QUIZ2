<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<aside class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <div class="logo">
            <span class="logo-text">Task Organizer</span>
        </div>
    </div>
    
    <nav class="sidebar-nav">
        <a href="TaskServlet?action=dashboard" class="nav-item ${pageContext.request.servletPath == '/dashboard.jsp' ? 'active' : ''}">
            <span class="nav-text">Dashboard</span>
        </a>
        
        <a href="TaskServlet?action=list" class="nav-item ${pageContext.request.servletPath == '/index.jsp' ? 'active' : ''}">
            <span class="nav-text">My Tasks</span>
        </a>
        
        <a href="ProfileServlet" class="nav-item ${pageContext.request.servletPath == '/profile.jsp' ? 'active' : ''}">
            <span class="nav-text">Profile</span>
        </a>
        
        <div class="nav-divider"></div>
        
        <div class="nav-section-title">FILTERS</div>
        
        <a href="TaskServlet?action=filter&filterType=status&filterValue=Pending" class="nav-item nav-item-small">
            <span class="nav-text">Pending</span>
        </a>
        
        <a href="TaskServlet?action=filter&filterType=status&filterValue=In Progress" class="nav-item nav-item-small">
            <span class="nav-text">In Progress</span>
        </a>
        
        <a href="TaskServlet?action=filter&filterType=status&filterValue=Completed" class="nav-item nav-item-small">
            <span class="nav-text">Completed</span>
        </a>
        
        <div class="nav-divider"></div>
        
        <a href="LogoutServlet" class="nav-item nav-item-logout">
            <span class="nav-text">Logout</span>
        </a>
    </nav>
    
    <div class="sidebar-footer">
        <div class="user-info">
            <div class="user-avatar">
                ${sessionScope.userName.substring(0, 1).toUpperCase()}
            </div>
            <div class="user-details">
                <div class="user-name">${sessionScope.userName}</div>
                <div class="user-email">${sessionScope.user.email}</div>
            </div>
        </div>
    </div>
</aside>
