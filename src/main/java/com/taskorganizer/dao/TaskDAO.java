package com.taskorganizer.dao;

import com.taskorganizer.model.Task;
import com.taskorganizer.util.DatabaseUtil;

import java.sql.*;
import java.util.*;

public class TaskDAO {
    
    // Create
    public boolean addTask(Task task) {
        String sql = "INSERT INTO tasks (user_id, title, description, priority, status, category, tags, notes, created_date, due_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setInt(1, task.getUserId());
            pstmt.setString(2, task.getTitle());
            pstmt.setString(3, task.getDescription());
            pstmt.setString(4, task.getPriority());
            pstmt.setString(5, task.getStatus());
            pstmt.setString(6, task.getCategory());
            pstmt.setString(7, task.getTags());
            pstmt.setString(8, task.getNotes());
            pstmt.setTimestamp(9, new Timestamp(task.getCreatedDate().getTime()));
            pstmt.setTimestamp(10, task.getDueDate() != null ? new Timestamp(task.getDueDate().getTime()) : null);
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        task.setId(generatedKeys.getInt(1));
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Read all tasks for a user
    public List<Task> getAllTasks(int userId) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks WHERE user_id = ? ORDER BY created_date DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    tasks.add(extractTaskFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks;
    }
    
    // Read by ID
    public Task getTaskById(int id, int userId) {
        String sql = "SELECT * FROM tasks WHERE id = ? AND user_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            pstmt.setInt(2, userId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractTaskFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Update
    public boolean updateTask(Task task) {
        String sql = "UPDATE tasks SET title = ?, description = ?, priority = ?, status = ?, category = ?, tags = ?, notes = ?, due_date = ?, completed_date = ? WHERE id = ? AND user_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, task.getTitle());
            pstmt.setString(2, task.getDescription());
            pstmt.setString(3, task.getPriority());
            pstmt.setString(4, task.getStatus());
            pstmt.setString(5, task.getCategory());
            pstmt.setString(6, task.getTags());
            pstmt.setString(7, task.getNotes());
            pstmt.setTimestamp(8, task.getDueDate() != null ? new Timestamp(task.getDueDate().getTime()) : null);
            pstmt.setTimestamp(9, task.getCompletedDate() != null ? new Timestamp(task.getCompletedDate().getTime()) : null);
            pstmt.setInt(10, task.getId());
            pstmt.setInt(11, task.getUserId());
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Delete
    public boolean deleteTask(int id, int userId) {
        String sql = "DELETE FROM tasks WHERE id = ? AND user_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            pstmt.setInt(2, userId);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Get tasks by status
    public List<Task> getTasksByStatus(int userId, String status) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks WHERE user_id = ? AND status = ? ORDER BY created_date DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            pstmt.setString(2, status);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    tasks.add(extractTaskFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks;
    }
    
    // Get tasks by priority
    public List<Task> getTasksByPriority(int userId, String priority) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks WHERE user_id = ? AND priority = ? ORDER BY created_date DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            pstmt.setString(2, priority);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    tasks.add(extractTaskFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks;
    }
    
    // Get tasks by category
    public List<Task> getTasksByCategory(int userId, String category) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks WHERE user_id = ? AND category = ? ORDER BY created_date DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            pstmt.setString(2, category);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    tasks.add(extractTaskFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks;
    }
    
    // Search tasks by keyword
    public List<Task> searchTasks(int userId, String keyword) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks WHERE user_id = ? AND (title LIKE ? OR description LIKE ? OR tags LIKE ?) ORDER BY created_date DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            pstmt.setInt(1, userId);
            pstmt.setString(2, searchPattern);
            pstmt.setString(3, searchPattern);
            pstmt.setString(4, searchPattern);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    tasks.add(extractTaskFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks;
    }
    
    // Get task statistics
    public Map<String, Integer> getTaskStatistics(int userId) {
        Map<String, Integer> stats = new HashMap<>();
        String sql = "SELECT status, COUNT(*) as count FROM tasks WHERE user_id = ? GROUP BY status";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    stats.put(rs.getString("status"), rs.getInt("count"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }
    
    // Helper method to extract Task from ResultSet
    private Task extractTaskFromResultSet(ResultSet rs) throws SQLException {
        Task task = new Task();
        task.setId(rs.getInt("id"));
        task.setUserId(rs.getInt("user_id"));
        task.setTitle(rs.getString("title"));
        task.setDescription(rs.getString("description"));
        task.setPriority(rs.getString("priority"));
        task.setStatus(rs.getString("status"));
        task.setCategory(rs.getString("category"));
        task.setTags(rs.getString("tags"));
        task.setNotes(rs.getString("notes"));
        task.setCreatedDate(rs.getTimestamp("created_date"));
        task.setDueDate(rs.getTimestamp("due_date"));
        task.setCompletedDate(rs.getTimestamp("completed_date"));
        return task;
    }
}
