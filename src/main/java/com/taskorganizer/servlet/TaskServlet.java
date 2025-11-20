package com.taskorganizer.servlet;

import com.taskorganizer.dao.TaskDAO;
import com.taskorganizer.model.Task;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@WebServlet("/TaskServlet")
public class TaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TaskDAO taskDAO;
    
    @Override
    public void init() throws ServletException {
        taskDAO = new TaskDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                listTasks(request, response);
                break;
            case "dashboard":
                showDashboard(request, response);
                break;
            case "calendar":
                showCalendar(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteTask(request, response);
                break;
            case "filter":
                filterTasks(request, response);
                break;
            case "search":
                searchTasks(request, response);
                break;
            case "quickUpdateStatus":
                quickUpdateStatus(request, response);
                break;
            default:
                listTasks(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "add";
        }
        
        switch (action) {
            case "add":
                addTask(request, response);
                break;
            case "update":
                updateTask(request, response);
                break;
            default:
                listTasks(request, response);
                break;
        }
    }
    
    private void listTasks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = (int) request.getSession().getAttribute("userId");
        List<Task> tasks = taskDAO.getAllTasks(userId);
        Map<String, Integer> stats = taskDAO.getTaskStatistics(userId);
        request.setAttribute("tasks", tasks);
        request.setAttribute("stats", stats);
        request.getRequestDispatcher("index-new.jsp").forward(request, response);
    }
    
    private void addTask(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = (int) request.getSession().getAttribute("userId");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String priority = request.getParameter("priority");
        String status = request.getParameter("status");
        String category = request.getParameter("category");
        String tags = request.getParameter("tags");
        String notes = request.getParameter("notes");
        String dueDateStr = request.getParameter("dueDate");
        
        Task task = new Task();
        task.setUserId(userId);
        task.setTitle(title);
        task.setDescription(description);
        task.setPriority(priority);
        task.setStatus(status);
        task.setCategory(category != null ? category : "General");
        task.setTags(tags);
        task.setNotes(notes);
        
        if (dueDateStr != null && !dueDateStr.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date dueDate = sdf.parse(dueDateStr);
                task.setDueDate(dueDate);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        
        taskDAO.addTask(task);
        response.sendRedirect("TaskServlet?action=list");
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = (int) request.getSession().getAttribute("userId");
        int id = Integer.parseInt(request.getParameter("id"));
        Task task = taskDAO.getTaskById(id, userId);
        request.setAttribute("task", task);
        request.getRequestDispatcher("edit-task-new.jsp").forward(request, response);
    }
    
    private void updateTask(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = (int) request.getSession().getAttribute("userId");
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String priority = request.getParameter("priority");
        String status = request.getParameter("status");
        String category = request.getParameter("category");
        String tags = request.getParameter("tags");
        String notes = request.getParameter("notes");
        String dueDateStr = request.getParameter("dueDate");
        
        Task task = taskDAO.getTaskById(id, userId);
        if (task != null) {
            task.setTitle(title);
            task.setDescription(description);
            task.setPriority(priority);
            task.setStatus(status);
            task.setCategory(category != null ? category : "General");
            task.setTags(tags);
            task.setNotes(notes);
            
            if (dueDateStr != null && !dueDateStr.isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date dueDate = sdf.parse(dueDateStr);
                    task.setDueDate(dueDate);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            
            // Set completed date if status is "Completed"
            if ("Completed".equals(status) && task.getCompletedDate() == null) {
                task.setCompletedDate(new Date());
            } else if (!"Completed".equals(status)) {
                task.setCompletedDate(null);
            }
            
            taskDAO.updateTask(task);
        }
        
        response.sendRedirect("TaskServlet?action=list");
    }
    
    private void deleteTask(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = (int) request.getSession().getAttribute("userId");
        int id = Integer.parseInt(request.getParameter("id"));
        taskDAO.deleteTask(id, userId);
        response.sendRedirect("TaskServlet?action=list");
    }
    
    private void filterTasks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = (int) request.getSession().getAttribute("userId");
        String filterType = request.getParameter("filterType");
        String filterValue = request.getParameter("filterValue");
        
        List<Task> tasks;
        if ("status".equals(filterType)) {
            tasks = taskDAO.getTasksByStatus(userId, filterValue);
        } else if ("priority".equals(filterType)) {
            tasks = taskDAO.getTasksByPriority(userId, filterValue);
        } else if ("category".equals(filterType)) {
            tasks = taskDAO.getTasksByCategory(userId, filterValue);
        } else {
            tasks = taskDAO.getAllTasks(userId);
        }
        
        Map<String, Integer> stats = taskDAO.getTaskStatistics(userId);
        request.setAttribute("tasks", tasks);
        request.setAttribute("stats", stats);
        request.getRequestDispatcher("index-new.jsp").forward(request, response);
    }
    
    private void searchTasks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = (int) request.getSession().getAttribute("userId");
        String keyword = request.getParameter("keyword");
        
        List<Task> tasks;
        if (keyword != null && !keyword.trim().isEmpty()) {
            tasks = taskDAO.searchTasks(userId, keyword.trim());
        } else {
            tasks = taskDAO.getAllTasks(userId);
        }
        
        Map<String, Integer> stats = taskDAO.getTaskStatistics(userId);
        request.setAttribute("tasks", tasks);
        request.setAttribute("stats", stats);
        request.setAttribute("searchKeyword", keyword);
        request.getRequestDispatcher("index-new.jsp").forward(request, response);
    }
    
    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = (int) request.getSession().getAttribute("userId");
        
        // Get statistics
        Map<String, Integer> stats = taskDAO.getTaskStatistics(userId);
        request.setAttribute("stats", stats);
        
        // Get recent tasks (limit to 6)
        List<Task> allTasks = taskDAO.getAllTasks(userId);
        List<Task> recentTasks = allTasks.size() > 6 ? allTasks.subList(0, 6) : allTasks;
        request.setAttribute("recentTasks", recentTasks);
        
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
    
    private void showCalendar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = (int) request.getSession().getAttribute("userId");
        
        // Get all tasks for calendar view
        List<Task> tasks = taskDAO.getAllTasks(userId);
        request.setAttribute("tasks", tasks);
        
        request.getRequestDispatcher("calendar.jsp").forward(request, response);
    }
    
    private void quickUpdateStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        int userId = (int) request.getSession().getAttribute("userId");
        int taskId = Integer.parseInt(request.getParameter("id"));
        String newStatus = request.getParameter("status");
        
        Task task = taskDAO.getTaskById(taskId, userId);
        
        if (task != null) {
            task.setStatus(newStatus);
            
            // Set completed date if status is Completed
            if ("Completed".equals(newStatus) && task.getCompletedDate() == null) {
                task.setCompletedDate(new Date());
            } else if (!"Completed".equals(newStatus)) {
                task.setCompletedDate(null);
            }
            
            boolean success = taskDAO.updateTask(task);
            
            if (success) {
                response.getWriter().write("{\"success\": true, \"message\": \"Status updated successfully\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Failed to update status\"}");
            }
        } else {
            response.getWriter().write("{\"success\": false, \"message\": \"Task not found\"}");
        }
    }
}
