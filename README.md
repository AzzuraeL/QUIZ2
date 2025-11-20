# 📋 Task Organizer - Enhanced Web Application

A modern, full-featured task management web application built with Java Servlets, JSP, and MySQL.

## ✨ Features

### Authentication & Security
- 🔐 **User Registration & Login** - Secure authentication with BCrypt password hashing
- 👤 **User Sessions** - Session management with auto-logout after 30 minutes of inactivity
- 🛡️ **Protected Routes** - Authentication filter to protect task pages

### Task Management
- ➕ **Create Tasks** - Add tasks with title, description, priority, status, category, tags, and notes
- ✏️ **Edit Tasks** - Update any task details
- 🗑️ **Delete Tasks** - Remove tasks with confirmation
- 📊 **Task Statistics** - Dashboard showing pending, in progress, and completed tasks
- � **Search Tasks** - Search by title, description, or tags
- 🎯 **Filter Tasks** - Filter by status, priority, or category
- 📁 **Categories** - Organize tasks (Work, Personal, Development, Health, Finance, Education, etc.)
- 🏷️ **Tags** - Add multiple tags to tasks for better organization
- � **Notes** - Add additional notes to tasks
- ⏰ **Due Dates** - Set and track task deadlines
- ✅ **Completion Tracking** - Automatic completion date recording

### User Interface
- 🎨 **Modern Design** - Beautiful gradient backgrounds and card-based layouts
- 📱 **Responsive** - Works perfectly on desktop, tablet, and mobile devices
- ✨ **Animations** - Smooth transitions and hover effects
- � **Color-Coded** - Priority and status color indicators
- 📊 **Statistics Dashboard** - Visual overview of your tasks

## 🛠️ Technologies Used

- **Backend**: Java 8, Servlets, JSP, JSTL
- **Database**: MySQL 8.0
- **Security**: BCrypt password hashing
- **Build Tool**: Maven
- **Server**: Apache Tomcat 9.0+
- **Frontend**: HTML5, CSS3, JavaScript

## 📋 Prerequisites

- Java Development Kit (JDK) 8 or higher
- Apache Maven 3.6+
- MySQL 8.0+
- Apache Tomcat 9.0+
- IDE (Eclipse, IntelliJ IDEA, or VS Code)

## 📁 Project Structure

```
task-organizer/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── taskorganizer/
│       │           ├── dao/
│       │           │   ├── TaskDAO.java
│       │           │   └── UserDAO.java
│       │           ├── filter/
│       │           │   └── AuthenticationFilter.java
│       │           ├── model/
│       │           │   ├── Task.java
│       │           │   └── User.java
│       │           ├── servlet/
│       │           │   ├── LoginServlet.java
│       │           │   ├── LogoutServlet.java
│       │           │   ├── RegisterServlet.java
│       │           │   └── TaskServlet.java
│       │           └── util/
│       │               └── DatabaseUtil.java
│       └── webapp/
│           ├── css/
│           │   └── style.css
│           ├── WEB-INF/
│           │   └── web.xml
│           ├── edit-task.jsp
│           ├── index.jsp
│           ├── login.jsp
│           └── register.jsp
├── database.sql
├── pom.xml
└── README.md
```

## 🚀 Setup Instructions

### 1. Database Setup

1. Install MySQL Server
2. Open MySQL Workbench or command line
3. Run the SQL script to create the database:

```bash
mysql -u root -p < database.sql
```

Or manually execute the `database.sql` file located in the project root.

4. Update database credentials in `src/main/java/com/taskorganizer/util/DatabaseUtil.java`:
```java
private static final String DB_USER = "root";
private static final String DB_PASSWORD = "your_password";
```

### 2. Build the Project

```bash
mvn clean install
```

### 3. Deploy to Tomcat

**Option 1: Manual Deployment**
1. Copy the generated WAR file from `target/task-organizer.war`
2. Place it in Tomcat's `webapps` directory
3. Start Tomcat server

**Option 2: IDE Deployment**
1. Import as Maven project
2. Configure Tomcat server in your IDE
3. Deploy the project
4. Start the server

### 4. Access the Application

Open your browser and navigate to:
```
http://localhost:8080/task-organizer
```

## 👥 Default Demo Account

For testing purposes, a demo account is created:
- **Email**: demo@example.com
- **Password**: password123

## 🎯 Usage Guide

### Creating an Account
1. Navigate to the registration page
2. Enter your name, email, and password (minimum 6 characters)
3. Click "Create Account"
4. You'll be automatically logged in

### Adding a Task
1. Fill in the "Add New Task" form
2. Set priority, status, category, and due date
3. Add tags for better organization (optional)
4. Add notes if needed (optional)
5. Click "Add Task"

### Managing Tasks
- **Edit**: Click the "Edit" button on any task card
- **Delete**: Click the "Delete" button (with confirmation)
- **Search**: Use the search bar to find tasks by keyword
- **Filter**: Use filter dropdowns to view specific task groups

### Dashboard Statistics
View real-time statistics showing:
- Pending tasks
- Tasks in progress
- Completed tasks
- Total task count

## 🔒 Security Features

- **Password Hashing**: BCrypt with salt for secure password storage
- **SQL Injection Prevention**: Prepared statements for all database queries
- **Session Management**: Secure session handling with timeout
- **Authentication Filter**: Prevents unauthorized access to protected pages
- **XSS Protection**: Input sanitization and output encoding

## 🎨 Customization

### Changing Theme Colors
Edit `src/main/webapp/css/style.css`:
```css
/* Primary gradient */
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
```

### Adding New Categories
Update the category dropdown in `index.jsp` and `edit-task.jsp`:
```html
<option value="YourCategory">Your Category</option>
```

## 📝 Database Schema

### Users Table
- `id`: INT (Primary Key, Auto Increment)
- `name`: VARCHAR(100)
- `email`: VARCHAR(100) (Unique)
- `password`: VARCHAR(255) (Hashed)
- `created_date`: TIMESTAMP
- `last_login`: TIMESTAMP

### Tasks Table
- `id`: INT (Primary Key, Auto Increment)
- `user_id`: INT (Foreign Key)
- `title`: VARCHAR(200)
- `description`: TEXT
- `priority`: VARCHAR(20)
- `status`: VARCHAR(20)
- `category`: VARCHAR(50)
- `tags`: VARCHAR(255)
- `notes`: TEXT
- `created_date`: TIMESTAMP
- `due_date`: TIMESTAMP
- `completed_date`: TIMESTAMP

## 🐛 Troubleshooting

### Database Connection Issues
- Verify MySQL is running
- Check database credentials in `DatabaseUtil.java`
- Ensure database `task_organizer_db` exists

### Port Already in Use
- Change Tomcat port in `server.xml`
- Or stop the application using the port

### Build Errors
- Run `mvn clean install`
- Check Java and Maven versions
- Verify all dependencies in `pom.xml`

## 🤝 Contributing

Feel free to fork this project and submit pull requests for any improvements!

## 📄 License

This project is open source and available under the MIT License.

## 👨‍💻 Author

Created with ❤️ for productivity

---

**Happy Task Managing! 📋✨**
