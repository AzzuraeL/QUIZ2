// Quick Status Update Functionality
function updateStatus(taskId, newStatus) {
    // Show loading indicator
    const selector = document.querySelector(`select[data-task-id="${taskId}"]`);
    const originalValue = selector.value;
    selector.disabled = true;
    
    // Send AJAX request to update status
    fetch(`TaskServlet?action=quickUpdateStatus&id=${taskId}&status=${encodeURIComponent(newStatus)}`, {
        method: 'GET',
        headers: {
            'X-Requested-With': 'XMLHttpRequest'
        }
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // Show success message
            showNotification('✅ Task status updated successfully!', 'success');
            
            // Update the task card to reflect the new status
            const taskCard = selector.closest('.task-card');
            const statusBadge = taskCard.querySelector('.status-badge');
            
            // Update status badge
            statusBadge.className = `badge status-badge status-${newStatus.replace(' ', '')}`;
            statusBadge.textContent = newStatus;
            
            // Add completed class if status is Completed
            if (newStatus === 'Completed') {
                taskCard.classList.add('completed');
            } else {
                taskCard.classList.remove('completed');
            }
            
            // Optionally reload page after short delay to update statistics
            setTimeout(() => {
                location.reload();
            }, 1500);
        } else {
            // Show error message
            showNotification('❌ Failed to update status', 'error');
            selector.value = originalValue;
        }
    })
    .catch(error => {
        console.error('Error updating status:', error);
        showNotification('❌ Error updating status', 'error');
        selector.value = originalValue;
    })
    .finally(() => {
        selector.disabled = false;
    });
}

// Attach event listeners to all status selectors
document.addEventListener('DOMContentLoaded', function() {
    const statusSelectors = document.querySelectorAll('.status-selector');
    
    statusSelectors.forEach(selector => {
        selector.addEventListener('change', function() {
            const taskId = this.getAttribute('data-task-id');
            const newStatus = this.value;
            updateStatus(taskId, newStatus);
        });
    });
});

// Notification function
function showNotification(message, type) {
    // Create notification element
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.textContent = message;
    
    // Add to body
    document.body.appendChild(notification);
    
    // Trigger animation
    setTimeout(() => {
        notification.classList.add('show');
    }, 10);
    
    // Remove after 3 seconds
    setTimeout(() => {
        notification.classList.remove('show');
        setTimeout(() => {
            document.body.removeChild(notification);
        }, 300);
    }, 3000);
}
