-- Create database
CREATE DATABASE IF NOT EXISTS task_organizer_db;
USE task_organizer_db;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS tasks;
DROP TABLE IF EXISTS users;

-- Create users table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create tasks table
CREATE TABLE tasks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    priority VARCHAR(20) NOT NULL DEFAULT 'Medium',
    status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    category VARCHAR(50) DEFAULT 'General',
    tags VARCHAR(255),
    notes TEXT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    due_date TIMESTAMP NULL,
    completed_date TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_status (status),
    INDEX idx_priority (priority),
    INDEX idx_category (category),
    INDEX idx_due_date (due_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert sample user (password: password123)
-- The password is hashed using BCrypt
INSERT INTO users (name, email, password, created_date) VALUES 
('Demo User', 'demo@example.com', '$2a$10$rFKZvJKGLQhLGJJ8vHBGOOzIxLzMp3GKK5dGQkrZ6KqKxbRZ5h7yW', NOW());

-- Get the demo user ID
SET @demo_user_id = LAST_INSERT_ID();

-- Insert sample tasks for demo user
INSERT INTO tasks (user_id, title, description, priority, status, category, tags, created_date, due_date) VALUES
(@demo_user_id, 'Complete Project Proposal', 'Finish the Q4 project proposal and submit to management', 'High', 'In Progress', 'Work', 'urgent,project', NOW(), DATE_ADD(NOW(), INTERVAL 3 DAY)),
(@demo_user_id, 'Team Meeting', 'Weekly team sync-up meeting to discuss progress and blockers', 'Medium', 'Pending', 'Work', 'meeting,team', NOW(), DATE_ADD(NOW(), INTERVAL 2 DAY)),
(@demo_user_id, 'Code Review', 'Review pull requests from team members', 'High', 'Pending', 'Development', 'code,review', NOW(), DATE_ADD(NOW(), INTERVAL 1 DAY)),
(@demo_user_id, 'Update Documentation', 'Update API documentation with new endpoints', 'Low', 'Pending', 'Development', 'documentation', NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY)),
(@demo_user_id, 'Grocery Shopping', 'Buy groceries for the week', 'Medium', 'Pending', 'Personal', 'shopping', NOW(), DATE_ADD(NOW(), INTERVAL 1 DAY)),
(@demo_user_id, 'Gym Workout', 'Complete 45-minute cardio and strength training', 'Low', 'Completed', 'Health', 'fitness,health', DATE_SUB(NOW(), INTERVAL 1 DAY), DATE_SUB(NOW(), INTERVAL 1 DAY)),
(@demo_user_id, 'Read Book', 'Finish reading "The Clean Coder"', 'Low', 'In Progress', 'Personal', 'reading,learning', NOW(), DATE_ADD(NOW(), INTERVAL 10 DAY)),
(@demo_user_id, 'Database Optimization', 'Optimize slow queries and add indexes', 'High', 'Pending', 'Development', 'database,performance', NOW(), DATE_ADD(NOW(), INTERVAL 5 DAY));

-- Display created tables
SHOW TABLES;

-- Display sample data
SELECT * FROM users;
SELECT id, user_id, title, priority, status, category, created_date, due_date FROM tasks;

-- Success message
SELECT 'Database setup completed successfully!' AS message;
