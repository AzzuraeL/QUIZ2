// Calendar functionality for Task Organizer

let currentMonth = new Date().getMonth();
let currentYear = new Date().getFullYear();
let tasks = typeof tasksData !== 'undefined' ? tasksData : [];

document.addEventListener('DOMContentLoaded', function() {
    initCalendar();
    
    // Navigation buttons
    document.getElementById('prevMonth').addEventListener('click', function() {
        currentMonth--;
        if (currentMonth < 0) {
            currentMonth = 11;
            currentYear--;
        }
        renderCalendar();
    });
    
    document.getElementById('nextMonth').addEventListener('click', function() {
        currentMonth++;
        if (currentMonth > 11) {
            currentMonth = 0;
            currentYear++;
        }
        renderCalendar();
    });
    
    document.getElementById('todayBtn').addEventListener('click', function() {
        currentMonth = new Date().getMonth();
        currentYear = new Date().getFullYear();
        renderCalendar();
    });
    
    // Modal controls
    document.getElementById('closeModal').addEventListener('click', closeModal);
    document.getElementById('taskModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeModal();
        }
    });
});

function initCalendar() {
    renderCalendar();
}

function renderCalendar() {
    const monthNames = ['January', 'February', 'March', 'April', 'May', 'June',
                       'July', 'August', 'September', 'October', 'November', 'December'];
    
    // Update title
    document.getElementById('calendarTitle').textContent = `${monthNames[currentMonth]} ${currentYear}`;
    
    // Get first day of month and number of days
    const firstDay = new Date(currentYear, currentMonth, 1).getDay();
    const daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate();
    const daysInPrevMonth = new Date(currentYear, currentMonth, 0).getDate();
    
    const calendarDays = document.getElementById('calendarDays');
    calendarDays.innerHTML = '';
    
    const today = new Date();
    const isCurrentMonth = today.getMonth() === currentMonth && today.getFullYear() === currentYear;
    const todayDate = today.getDate();
    
    // Previous month days
    for (let i = firstDay - 1; i >= 0; i--) {
        const day = daysInPrevMonth - i;
        const dayElement = createDayElement(day, true, false);
        calendarDays.appendChild(dayElement);
    }
    
    // Current month days
    for (let day = 1; day <= daysInMonth; day++) {
        const isToday = isCurrentMonth && day === todayDate;
        const dayElement = createDayElement(day, false, isToday);
        calendarDays.appendChild(dayElement);
    }
    
    // Next month days
    const totalCells = calendarDays.children.length;
    const remainingCells = totalCells % 7 === 0 ? 0 : 7 - (totalCells % 7);
    for (let day = 1; day <= remainingCells; day++) {
        const dayElement = createDayElement(day, true, false);
        calendarDays.appendChild(dayElement);
    }
}

function createDayElement(day, isOtherMonth, isToday) {
    const dayDiv = document.createElement('div');
    dayDiv.className = 'calendar-day';
    
    if (isOtherMonth) {
        dayDiv.classList.add('other-month');
    }
    
    if (isToday) {
        dayDiv.classList.add('today');
    }
    
    const dayNumber = document.createElement('div');
    dayNumber.className = 'calendar-day-number';
    dayNumber.textContent = day;
    dayDiv.appendChild(dayNumber);
    
    if (!isOtherMonth) {
        // Get tasks for this day
        const dateStr = `${currentYear}-${String(currentMonth + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
        const dayTasks = getTasksForDate(dateStr);
        
        if (dayTasks.length > 0) {
            const tasksContainer = document.createElement('div');
            tasksContainer.className = 'calendar-tasks';
            
            // Show up to 3 tasks
            const displayTasks = dayTasks.slice(0, 3);
            displayTasks.forEach(task => {
                const taskItem = document.createElement('div');
                taskItem.className = `calendar-task-item priority-${task.priority}`;
                if (task.status === 'Completed') {
                    taskItem.classList.add('status-Completed');
                }
                taskItem.textContent = task.title;
                taskItem.addEventListener('click', function(e) {
                    e.stopPropagation();
                    showTaskDetails(task);
                });
                tasksContainer.appendChild(taskItem);
            });
            
            dayDiv.appendChild(tasksContainer);
            
            // Show count if more than 3 tasks
            if (dayTasks.length > 3) {
                const countBadge = document.createElement('div');
                countBadge.className = 'calendar-task-count';
                countBadge.textContent = `+${dayTasks.length - 3}`;
                dayDiv.appendChild(countBadge);
            }
        }
        
        dayDiv.addEventListener('click', function() {
            if (dayTasks.length > 0) {
                showDayTasks(day, monthNames[currentMonth], dayTasks);
            }
        });
    }
    
    return dayDiv;
}

function getTasksForDate(dateStr) {
    return tasks.filter(task => {
        return task.dueDate === dateStr;
    });
}

function showTaskDetails(task) {
    const modal = document.getElementById('taskModal');
    const content = document.getElementById('modalTaskContent');
    
    let tagsHtml = '';
    if (task.tags && task.tags.trim() !== '') {
        const tagList = task.tags.split(',').map(tag => 
            `<span class="tag">${tag.trim()}</span>`
        ).join('');
        tagsHtml = `<div class="task-tags">${tagList}</div>`;
    }
    
    content.innerHTML = `
        <div class="task-card priority-${task.priority} ${task.status === 'Completed' ? 'completed' : ''}">
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
            
            ${tagsHtml}
            
            <div class="task-dates">
                <div class="date-item">
                    <span class="date-label">Due Date:</span>
                    <span>${formatDate(task.dueDate)}</span>
                </div>
            </div>
            
            <div class="task-actions">
                <a href="TaskServlet?action=edit&id=${task.id}" class="btn btn-edit">Edit Task</a>
                <a href="TaskServlet?action=delete&id=${task.id}" class="btn btn-delete" 
                   onclick="return confirm('Are you sure you want to delete this task?')">Delete Task</a>
            </div>
        </div>
    `;
    
    modal.classList.add('active');
}

function showDayTasks(day, month, dayTasks) {
    const modal = document.getElementById('taskModal');
    const content = document.getElementById('modalTaskContent');
    const title = document.getElementById('modalTaskTitle');
    
    title.textContent = `Tasks for ${month} ${day}`;
    
    let tasksHtml = dayTasks.map(task => {
        let tagsHtml = '';
        if (task.tags && task.tags.trim() !== '') {
            const tagList = task.tags.split(',').map(tag => 
                `<span class="tag">${tag.trim()}</span>`
            ).join('');
            tagsHtml = `<div class="task-tags">${tagList}</div>`;
        }
        
        return `
            <div class="task-card priority-${task.priority} ${task.status === 'Completed' ? 'completed' : ''}" 
                 style="margin-bottom: 20px;">
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
                
                ${tagsHtml}
                
                <div class="task-actions">
                    <a href="TaskServlet?action=edit&id=${task.id}" class="btn btn-edit">Edit</a>
                    <a href="TaskServlet?action=delete&id=${task.id}" class="btn btn-delete" 
                       onclick="return confirm('Are you sure?')">Delete</a>
                </div>
            </div>
        `;
    }).join('');
    
    content.innerHTML = tasksHtml;
    modal.classList.add('active');
}

function closeModal() {
    document.getElementById('taskModal').classList.remove('active');
    document.getElementById('modalTaskTitle').textContent = 'Task Details';
}

function formatDate(dateStr) {
    if (!dateStr || dateStr === '') return 'No due date';
    const date = new Date(dateStr + 'T00:00:00');
    const options = { year: 'numeric', month: 'long', day: 'numeric' };
    return date.toLocaleDateString('en-US', options);
}

// Expose functions for external use if needed
window.calendarFunctions = {
    renderCalendar,
    showTaskDetails,
    closeModal
};
