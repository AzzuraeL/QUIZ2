// Task Deadline Notification System

document.addEventListener('DOMContentLoaded', function() {
    checkTaskDeadlines();
});

function checkTaskDeadlines() {
    // Only check if we have tasks data
    if (typeof tasksData === 'undefined' || !tasksData || tasksData.length === 0) {
        return;
    }
    
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    
    let overdueTasks = [];
    let dueTodayTasks = [];
    let dueSoonTasks = [];
    
    tasksData.forEach(task => {
        // Skip completed tasks
        if (task.status === 'Completed') {
            return;
        }
        
        if (!task.dueDate || task.dueDate === '') {
            return;
        }
        
        const dueDate = new Date(task.dueDate + 'T00:00:00');
        dueDate.setHours(0, 0, 0, 0);
        
        const diffTime = dueDate - today;
        const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
        
        if (diffDays < 0) {
            overdueTasks.push({...task, daysOverdue: Math.abs(diffDays)});
        } else if (diffDays === 0) {
            dueTodayTasks.push(task);
        } else if (diffDays <= 3) {
            dueSoonTasks.push({...task, daysUntil: diffDays});
        }
    });
    
    // Show notifications
    if (overdueTasks.length > 0) {
        showDeadlineNotification('overdue', overdueTasks);
    }
    
    if (dueTodayTasks.length > 0) {
        setTimeout(() => {
            showDeadlineNotification('today', dueTodayTasks);
        }, 500);
    }
    
    if (dueSoonTasks.length > 0) {
        setTimeout(() => {
            showDeadlineNotification('soon', dueSoonTasks);
        }, 1000);
    }
}

function showDeadlineNotification(type, tasks) {
    const container = getOrCreateNotificationContainer();
    
    const notification = document.createElement('div');
    notification.className = `deadline-notification notification-${type}`;
    
    let icon, title, message;
    
    if (type === 'overdue') {
        icon = '⚠️';
        title = `${tasks.length} Overdue Task${tasks.length > 1 ? 's' : ''}`;
        if (tasks.length === 1) {
            message = `"${tasks[0].title}" is ${tasks[0].daysOverdue} day${tasks[0].daysOverdue > 1 ? 's' : ''} overdue!`;
        } else {
            message = `You have ${tasks.length} tasks that are past their deadline.`;
        }
    } else if (type === 'today') {
        icon = '📅';
        title = `${tasks.length} Task${tasks.length > 1 ? 's' : ''} Due Today`;
        if (tasks.length === 1) {
            message = `"${tasks[0].title}" is due today!`;
        } else {
            message = `You have ${tasks.length} tasks due today.`;
        }
    } else {
        icon = '🔔';
        title = `${tasks.length} Task${tasks.length > 1 ? 's' : ''} Due Soon`;
        if (tasks.length === 1) {
            message = `"${tasks[0].title}" is due in ${tasks[0].daysUntil} day${tasks[0].daysUntil > 1 ? 's' : ''}.`;
        } else {
            message = `You have ${tasks.length} tasks due in the next 3 days.`;
        }
    }
    
    notification.innerHTML = `
        <div class="notification-icon">${icon}</div>
        <div class="notification-content">
            <div class="notification-title">${title}</div>
            <div class="notification-message">${message}</div>
            ${tasks.length <= 3 ? `
                <div class="notification-tasks">
                    ${tasks.map(task => `
                        <div class="notification-task-item">
                            <span class="task-priority-dot priority-${task.priority}"></span>
                            <a href="TaskServlet?action=edit&id=${task.id}">${task.title}</a>
                        </div>
                    `).join('')}
                </div>
            ` : `
                <a href="TaskServlet?action=list" class="notification-view-all">View all tasks</a>
            `}
        </div>
        <button class="notification-close" onclick="this.parentElement.remove()">×</button>
    `;
    
    container.appendChild(notification);
    
    // Animate in
    setTimeout(() => {
        notification.classList.add('show');
    }, 100);
    
    // Auto dismiss after 10 seconds
    setTimeout(() => {
        notification.classList.remove('show');
        setTimeout(() => {
            notification.remove();
        }, 300);
    }, 10000);
}

function getOrCreateNotificationContainer() {
    let container = document.getElementById('notificationContainer');
    if (!container) {
        container = document.createElement('div');
        container.id = 'notificationContainer';
        container.className = 'notification-container';
        document.body.appendChild(container);
    }
    return container;
}

// Export for use in other pages
window.taskNotifications = {
    checkTaskDeadlines,
    showDeadlineNotification
};
