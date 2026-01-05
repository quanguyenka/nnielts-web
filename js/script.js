// ============================================
// Initialize AOS (Animate On Scroll)
// ============================================
AOS.init({
    duration: 1000,
    once: true,
    offset: 100,
    easing: 'ease-out-cubic'
});

// ============================================
// Navbar Scroll Effect
// ============================================
const navbar = document.getElementById('navbar');
let lastScrollTop = 0;

window.addEventListener('scroll', () => {
    let scrollTop = window.pageYOffset || document.documentElement.scrollTop;

    // Add scrolled class when scrolling down
    if (scrollTop > 50) {
        navbar.classList.add('scrolled');
    } else {
        navbar.classList.remove('scrolled');
    }

    lastScrollTop = scrollTop;
});

// ============================================
// Mobile Menu Toggle
// ============================================
const hamburger = document.getElementById('hamburger');
const navMenu = document.getElementById('navMenu');

hamburger.addEventListener('click', () => {
    navMenu.classList.toggle('active');
    hamburger.classList.toggle('active');
});

// Close mobile menu when clicking on a link
const navLinks = document.querySelectorAll('.nav-link');
navLinks.forEach(link => {
    link.addEventListener('click', () => {
        navMenu.classList.remove('active');
        hamburger.classList.remove('active');
    });
});

// ============================================
// Active Navigation Link on Scroll
// ============================================
const sections = document.querySelectorAll('section[id]');

function highlightNavigation() {
    const scrollY = window.pageYOffset;

    sections.forEach(section => {
        const sectionHeight = section.offsetHeight;
        const sectionTop = section.offsetTop - 100;
        const sectionId = section.getAttribute('id');
        const navLink = document.querySelector(`.nav-link[href="#${sectionId}"]`);

        if (navLink) {
            if (scrollY > sectionTop && scrollY <= sectionTop + sectionHeight) {
                navLink.classList.add('active');
            } else {
                navLink.classList.remove('active');
            }
        }
    });
}

window.addEventListener('scroll', highlightNavigation);

// ============================================
// Smooth Scroll for Anchor Links
// ============================================
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        const href = this.getAttribute('href');

        // Don't prevent default for non-section links
        if (href === '#') return;

        e.preventDefault();

        const target = document.querySelector(href);
        if (target) {
            const offsetTop = target.offsetTop - 80;

            window.scrollTo({
                top: offsetTop,
                behavior: 'smooth'
            });
        }
    });
});

// ============================================
// Counter Animation for Achievement Numbers
// ============================================
function animateCounter(element) {
    const target = parseFloat(element.getAttribute('data-target'));
    const isDecimal = target % 1 !== 0;
    const duration = 2000; // 2 seconds
    const increment = target / (duration / 16); // 60fps
    let current = 0;

    const updateCounter = () => {
        current += increment;

        if (current < target) {
            if (isDecimal) {
                element.textContent = current.toFixed(1);
            } else {
                element.textContent = Math.floor(current).toLocaleString();
            }
            requestAnimationFrame(updateCounter);
        } else {
            if (isDecimal) {
                element.textContent = target.toFixed(1);
            } else {
                element.textContent = Math.floor(target).toLocaleString();
            }
        }
    };

    updateCounter();
}

// Intersection Observer for Counter Animation
const achievementSection = document.querySelector('#achievements');
const achievementNumbers = document.querySelectorAll('.achievement-number');
let countersAnimated = false;

const achievementObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting && !countersAnimated) {
            countersAnimated = true;
            achievementNumbers.forEach(number => {
                animateCounter(number);
            });
        }
    });
}, {
    threshold: 0.5
});

if (achievementSection) {
    achievementObserver.observe(achievementSection);
}

// ============================================
// FAQ Accordion
// ============================================
const faqItems = document.querySelectorAll('.faq-item');

faqItems.forEach(item => {
    const question = item.querySelector('.faq-question');

    question.addEventListener('click', () => {
        // Close other items
        faqItems.forEach(otherItem => {
            if (otherItem !== item) {
                otherItem.classList.remove('active');
            }
        });

        // Toggle current item
        item.classList.toggle('active');
    });
});

// ============================================
// Back to Top Button
// ============================================
const backToTopBtn = document.getElementById('backToTop');

window.addEventListener('scroll', () => {
    if (window.pageYOffset > 300) {
        backToTopBtn.classList.add('show');
    } else {
        backToTopBtn.classList.remove('show');
    }
});

backToTopBtn.addEventListener('click', () => {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
});

// ============================================
// Contact Form Handling
// ============================================
const contactForm = document.getElementById('contactForm');

contactForm.addEventListener('submit', (e) => {
    e.preventDefault();

    // Get form data
    const formData = new FormData(contactForm);
    const data = {};
    formData.forEach((value, key) => {
        data[key] = value;
    });

    // Show success message (you can replace this with actual form submission)
    showNotification('success', 'Cảm ơn bạn đã đăng ký! Chúng tôi sẽ liên hệ với bạn trong vòng 15 phút.');

    // Reset form
    contactForm.reset();

    // In a real application, you would send this data to your backend
    console.log('Form data:', data);
});

// ============================================
// Notification System
// ============================================
function showNotification(type, message) {
    // Create notification element
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.innerHTML = `
        <i class="fas fa-${type === 'success' ? 'check-circle' : 'exclamation-circle'}"></i>
        <span>${message}</span>
    `;

    // Add styles
    notification.style.cssText = `
        position: fixed;
        top: 100px;
        right: 30px;
        background: ${type === 'success' ? '#10b981' : '#ef4444'};
        color: white;
        padding: 20px 30px;
        border-radius: 12px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
        display: flex;
        align-items: center;
        gap: 15px;
        font-weight: 600;
        z-index: 10000;
        animation: slideInRight 0.5s ease;
        max-width: 400px;
    `;

    document.body.appendChild(notification);

    // Remove after 5 seconds
    setTimeout(() => {
        notification.style.animation = 'slideOutRight 0.5s ease';
        setTimeout(() => {
            notification.remove();
        }, 500);
    }, 5000);
}

// Add notification animations to CSS dynamically
const style = document.createElement('style');
style.textContent = `
    @keyframes slideInRight {
        from {
            transform: translateX(400px);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }

    @keyframes slideOutRight {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(400px);
            opacity: 0;
        }
    }
`;
document.head.appendChild(style);

// ============================================
// Form Validation
// ============================================
const formInputs = document.querySelectorAll('.form-group input, .form-group select, .form-group textarea');

formInputs.forEach(input => {
    // Add focus effect
    input.addEventListener('focus', () => {
        input.parentElement.classList.add('focused');
    });

    input.addEventListener('blur', () => {
        input.parentElement.classList.remove('focused');

        // Validate on blur
        if (input.hasAttribute('required') && !input.value.trim()) {
            input.style.borderColor = '#ef4444';
        } else {
            input.style.borderColor = '';
        }
    });

    // Real-time validation for phone number
    if (input.type === 'tel') {
        input.addEventListener('input', (e) => {
            // Remove non-numeric characters
            e.target.value = e.target.value.replace(/[^0-9]/g, '');

            // Validate Vietnamese phone number format
            const phoneRegex = /^(0[3|5|7|8|9])+([0-9]{8})$/;
            if (phoneRegex.test(e.target.value)) {
                input.style.borderColor = '#10b981';
            } else if (e.target.value.length > 0) {
                input.style.borderColor = '#ef4444';
            } else {
                input.style.borderColor = '';
            }
        });
    }

    // Real-time validation for email
    if (input.type === 'email') {
        input.addEventListener('input', (e) => {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (emailRegex.test(e.target.value)) {
                input.style.borderColor = '#10b981';
            } else if (e.target.value.length > 0) {
                input.style.borderColor = '#ef4444';
            } else {
                input.style.borderColor = '';
            }
        });
    }
});

// ============================================
// Parallax Effect for Hero Section
// ============================================
window.addEventListener('scroll', () => {
    const scrolled = window.pageYOffset;
    const heroShapes = document.querySelectorAll('.hero-shape');

    heroShapes.forEach((shape, index) => {
        const speed = (index + 1) * 0.1;
        shape.style.transform = `translateY(${scrolled * speed}px)`;
    });
});

// ============================================
// Loading Animation
// ============================================
window.addEventListener('load', () => {
    document.body.classList.add('loaded');

    // Trigger AOS refresh after load
    setTimeout(() => {
        AOS.refresh();
    }, 100);
});

// ============================================
// Lazy Loading for Images
// ============================================
if ('IntersectionObserver' in window) {
    const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                img.src = img.dataset.src;
                img.classList.add('loaded');
                observer.unobserve(img);
            }
        });
    });

    const images = document.querySelectorAll('img[data-src]');
    images.forEach(img => imageObserver.observe(img));
}

// ============================================
// Prevent Form Spam
// ============================================
let formSubmitCount = 0;
const maxSubmitCount = 3;
const submitTimeWindow = 60000; // 1 minute

contactForm.addEventListener('submit', (e) => {
    formSubmitCount++;

    if (formSubmitCount > maxSubmitCount) {
        e.preventDefault();
        showNotification('error', 'Bạn đã gửi quá nhiều lần. Vui lòng thử lại sau 1 phút.');
        return;
    }

    // Reset counter after time window
    setTimeout(() => {
        formSubmitCount = 0;
    }, submitTimeWindow);
});

// ============================================
// Easter Egg: Konami Code
// ============================================
let konamiCode = [];
const konamiPattern = ['ArrowUp', 'ArrowUp', 'ArrowDown', 'ArrowDown', 'ArrowLeft', 'ArrowRight', 'ArrowLeft', 'ArrowRight', 'b', 'a'];

document.addEventListener('keydown', (e) => {
    konamiCode.push(e.key);
    konamiCode = konamiCode.slice(-10);

    if (konamiCode.join(',') === konamiPattern.join(',')) {
        // Easter egg activated!
        document.body.style.animation = 'rainbow 3s infinite';
        showNotification('success', '🎉 Bạn đã tìm thấy Easter Egg! Chúc mừng bạn! 🎊');

        setTimeout(() => {
            document.body.style.animation = '';
        }, 3000);
    }
});

// Add rainbow animation
const rainbowStyle = document.createElement('style');
rainbowStyle.textContent = `
    @keyframes rainbow {
        0% { filter: hue-rotate(0deg); }
        100% { filter: hue-rotate(360deg); }
    }
`;
document.head.appendChild(rainbowStyle);

// ============================================
// Console Welcome Message
// ============================================
console.log('%c🎓 Welcome to NNielts!', 'font-size: 20px; font-weight: bold; color: #6366f1;');
console.log('%cChiến phục IELTS cùng phương pháp 4-IN-1 độc quyền!', 'font-size: 14px; color: #10b981;');
console.log('%c💡 Tip: Thử nhập Konami Code để khám phá Easter Egg!', 'font-size: 12px; color: #f59e0b; font-style: italic;');

// ============================================
// Performance Monitoring
// ============================================
if ('PerformanceObserver' in window) {
    const perfObserver = new PerformanceObserver((list) => {
        for (const entry of list.getEntries()) {
            if (entry.loadTime > 3000) {
                console.warn('Slow resource detected:', entry.name, entry.loadTime + 'ms');
            }
        }
    });

    perfObserver.observe({ entryTypes: ['resource'] });
}

// ============================================
// Service Worker Registration (Optional)
// ============================================
if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
        // Uncomment to enable service worker
        // navigator.serviceWorker.register('/sw.js')
        //     .then(reg => console.log('Service Worker registered'))
        //     .catch(err => console.log('Service Worker registration failed'));
    });
}

// ============================================
// Analytics Tracking (Optional)
// ============================================
function trackEvent(category, action, label) {
    // Replace with your analytics code
    console.log('Event tracked:', { category, action, label });

    // Example for Google Analytics
    // if (typeof gtag !== 'undefined') {
    //     gtag('event', action, {
    //         'event_category': category,
    //         'event_label': label
    //     });
    // }
}

// Track button clicks
document.querySelectorAll('.btn').forEach(btn => {
    btn.addEventListener('click', () => {
        const btnText = btn.textContent.trim();
        trackEvent('Button', 'Click', btnText);
    });
});

// Track form interactions
contactForm.addEventListener('submit', () => {
    trackEvent('Form', 'Submit', 'Contact Form');
});

// ============================================
// Print Debugging Info
// ============================================
console.log('🚀 Website loaded successfully!');
console.log('📊 Total sections:', sections.length);
console.log('🎨 AOS animations initialized');
console.log('✅ All interactive features ready!');
