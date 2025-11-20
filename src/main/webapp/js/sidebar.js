// Sidebar Toggle Functionality
document.addEventListener('DOMContentLoaded', function() {
    const sidebarToggle = document.getElementById('sidebarToggle');
    const sidebar = document.getElementById('sidebar');
    const mainContent = document.querySelector('.main-content');
    const appContainer = document.querySelector('.app-container');
    
    // Initialize sidebar as hidden on mobile only
    if (window.innerWidth <= 768) {
        sidebar.classList.add('hidden');
    }
    
    // Create overlay for mobile
    const overlay = document.createElement('div');
    overlay.className = 'sidebar-overlay';
    appContainer.appendChild(overlay);
    
    // Toggle sidebar
    if (sidebarToggle) {
        sidebarToggle.addEventListener('click', function() {
            sidebar.classList.toggle('hidden');
            overlay.classList.toggle('active');
        });
    }
    
    // Close sidebar when clicking overlay
    overlay.addEventListener('click', function() {
        sidebar.classList.add('hidden');
        overlay.classList.remove('active');
    });
    
    // Close sidebar on mobile after clicking a link
    const navLinks = sidebar.querySelectorAll('.nav-item');
    navLinks.forEach(link => {
        link.addEventListener('click', function() {
            if (window.innerWidth <= 768) {
                sidebar.classList.add('hidden');
                overlay.classList.remove('active');
            }
        });
    });
});
