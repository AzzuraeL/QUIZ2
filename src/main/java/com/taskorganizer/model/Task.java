package com.taskorganizer.model;

import java.io.Serializable;
import java.util.Date;

public class Task implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int id;
    private int userId;
    private String title;
    private String description;
    private String priority;
    private String status;
    private String category;
    private String tags;
    private String notes;
    private Date createdDate;
    private Date dueDate;
    private Date completedDate;
    
    public Task() {
        this.createdDate = new Date();
        this.status = "Pending";
        this.category = "General";
    }
    
    public Task(int id, int userId, String title, String description, String priority, String status, Date dueDate) {
        this.id = id;
        this.userId = userId;
        this.title = title;
        this.description = description;
        this.priority = priority;
        this.status = status;
        this.createdDate = new Date();
        this.dueDate = dueDate;
        this.category = "General";
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getPriority() {
        return priority;
    }
    
    public void setPriority(String priority) {
        this.priority = priority;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Date getCreatedDate() {
        return createdDate;
    }
    
    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }
    
    public Date getDueDate() {
        return dueDate;
    }
    
    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getCategory() {
        return category;
    }
    
    public void setCategory(String category) {
        this.category = category;
    }
    
    public String getTags() {
        return tags;
    }
    
    public void setTags(String tags) {
        this.tags = tags;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    public Date getCompletedDate() {
        return completedDate;
    }
    
    public void setCompletedDate(Date completedDate) {
        this.completedDate = completedDate;
    }
}
