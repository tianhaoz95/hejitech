document.addEventListener('DOMContentLoaded', () => {
  // --- CLIENT-SIDE ROUTER ---
  const views = {
    home: document.getElementById('home-view'),
    terms: document.getElementById('terms-view'),
    privacy: document.getElementById('privacy-view')
  };

  function navigateTo(path, scrollTarget = null) {
    window.history.pushState({}, '', path);
    handleRoute(scrollTarget);
  }

  function handleRoute(scrollTarget = null) {
    const path = window.location.pathname;

    // Reset views
    Object.values(views).forEach(view => {
      if (view) view.classList.add('hidden');
    });

    if (path === '/terms' || path === '/terms/') {
      views.terms.classList.remove('hidden');
      document.title = 'Terms of Service | Heji Technology LLC';
      window.scrollTo(0, 0);
    } else if (path === '/privacy' || path === '/privacy/') {
      views.privacy.classList.remove('hidden');
      document.title = 'Privacy Policy | Heji Technology LLC';
      window.scrollTo(0, 0);
    } else {
      views.home.classList.remove('hidden');
      document.title = 'Heji Technology LLC | AI-Native Tools & Infrastructure';

      // If we need to scroll to a specific section on home page
      if (scrollTarget) {
        const element = document.querySelector(scrollTarget);
        if (element) {
          element.scrollIntoView({ behavior: 'smooth' });
        }
      } else if (window.location.hash) {
        const element = document.querySelector(window.location.hash);
        if (element) {
          element.scrollIntoView({ behavior: 'smooth' });
        }
      } else {
        window.scrollTo(0, 0);
      }
    }
  }

  // Intercept local link clicks for SPA feel
  document.body.addEventListener('click', (e) => {
    // Logo / Back button navigation to home
    if (e.target.closest('#nav-logo-btn') || e.target.closest('#terms-back-btn') || e.target.closest('#privacy-back-btn')) {
      e.preventDefault();
      navigateTo('/');
    }

    // Terms page navigation
    if (e.target.closest('#nav-terms-link') || e.target.closest('#footer-terms-link')) {
      e.preventDefault();
      navigateTo('/terms');
    }

    // Privacy page navigation
    if (e.target.closest('#footer-privacy-link') || e.target.closest('#nav-privacy-link')) {
      e.preventDefault();
      navigateTo('/privacy');
    }

    // Anchors on home page
    const anchorLink = e.target.closest('a[href^="#"]');
    if (anchorLink) {
      e.preventDefault();
      const targetHash = anchorLink.getAttribute('href');
      const currentPath = window.location.pathname;
      
      if (currentPath === '/terms' || currentPath === '/privacy') {
        navigateTo('/', targetHash);
      } else {
        const targetElement = document.querySelector(targetHash);
        if (targetElement) {
          targetElement.scrollIntoView({ behavior: 'smooth' });
        }
      }
    }
  });

  // Handle browser back/forward buttons
  window.addEventListener('popstate', () => {
    handleRoute();
  });

  // Initialize route on page load
  handleRoute();


  // --- DYNAMIC CARD MOUSE GLOW ---
  const cards = document.querySelectorAll('.product-card');
  cards.forEach(card => {
    card.addEventListener('mousemove', (e) => {
      const rect = card.getBoundingClientRect();
      const x = e.clientX - rect.left; // x position within the element
      const y = e.clientY - rect.top;  // y position within the element

      // Update card inline custom properties for dynamic visual effects if desired
      card.style.setProperty('--mouse-x', `${x}px`);
      card.style.setProperty('--mouse-y', `${y}px`);

      // Update background gradient positioning of the card's glow container
      const glowElement = card.querySelector('.card-glow');
      if (glowElement) {
        glowElement.style.background = `radial-gradient(circle at ${x}px ${y}px, hsla(var(--accent), 0.08) 0%, transparent 60%)`;
      }
    });
  });


  // --- SCROLL REVEAL (INTERSECTION OBSERVER) ---
  const revealElements = document.querySelectorAll('.scroll-reveal');
  const revealObserver = new IntersectionObserver((entries, observer) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('reveal-active');
        // Unobserve once revealed to avoid re-triggering animations on scroll up
        observer.unobserve(entry.target);
      }
    });
  }, {
    threshold: 0.15,
    rootMargin: '0px 0px -50px 0px' // triggers slightly before entering viewport
  });

  revealElements.forEach(el => {
    revealObserver.observe(el);
  });


  // --- FAQ ACCORDION SINGLE OPEN LIMITER ---
  const faqItems = document.querySelectorAll('.faq-item');
  faqItems.forEach(item => {
    const summary = item.querySelector('summary');
    summary.addEventListener('click', (e) => {
      // If we are opening this item, close all other open items
      if (!item.hasAttribute('open')) {
        faqItems.forEach(otherItem => {
          if (otherItem !== item && otherItem.hasAttribute('open')) {
            otherItem.removeAttribute('open');
          }
        });
      }
    });
  });


  // --- CONTACT FORM SUBMISSION HANDLING ---
  const inquiryForm = document.getElementById('inquiry-form');
  const statusMsg = document.getElementById('form-status-msg');
  const submitBtn = document.getElementById('form-submit-btn');

  if (inquiryForm) {
    inquiryForm.addEventListener('submit', (e) => {
      e.preventDefault();
      
      const name = document.getElementById('form-name').value.trim();
      const email = document.getElementById('form-email').value.trim();
      const message = document.getElementById('form-message').value.trim();

      if (!name || !email || !message) {
        statusMsg.className = 'form-message error';
        statusMsg.textContent = 'Please fill out all required fields.';
        return;
      }

      // Visual state: Loading
      submitBtn.disabled = true;
      submitBtn.textContent = 'Sending...';
      statusMsg.textContent = '';

      // Simulate API call for premium feedback
      setTimeout(() => {
        statusMsg.className = 'form-message success';
        statusMsg.textContent = 'Thank you! Your message has been sent successfully.';
        
        // Reset form inputs
        inquiryForm.reset();
        
        // Restore submit button
        submitBtn.disabled = false;
        submitBtn.textContent = 'Send Message';
      }, 1200);
    });
  }

  // --- FUTURISTIC BACKGROUND NETWORK ANIMATION ---
  const canvas = document.getElementById('bg-network');
  if (canvas) {
    const ctx = canvas.getContext('2d');
    let particles = [];
    let mouse = { x: null, y: null, radius: 120 };

    function resizeCanvas() {
      canvas.width = window.innerWidth;
      canvas.height = window.innerHeight;
      initParticles();
    }

    class Particle {
      constructor() {
        this.x = Math.random() * canvas.width;
        this.y = Math.random() * canvas.height;
        this.vx = (Math.random() - 0.5) * 0.4;
        this.vy = (Math.random() - 0.5) * 0.4;
        this.size = Math.random() * 1.5 + 0.5;
      }

      update() {
        this.x += this.vx;
        this.y += this.vy;

        // Bounce on boundaries
        if (this.x < 0 || this.x > canvas.width) this.vx = -this.vx;
        if (this.y < 0 || this.y > canvas.height) this.vy = -this.vy;
      }

      draw() {
        ctx.fillStyle = 'rgba(20, 184, 166, 0.3)';
        ctx.beginPath();
        ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
        ctx.fill();
      }
    }

    function initParticles() {
      particles = [];
      const numberOfParticles = Math.min(80, Math.floor((canvas.width * canvas.height) / 20000));
      for (let i = 0; i < numberOfParticles; i++) {
        particles.push(new Particle());
      }
    }

    function drawLines() {
      for (let i = 0; i < particles.length; i++) {
        for (let j = i + 1; j < particles.length; j++) {
          const dx = particles[i].x - particles[j].x;
          const dy = particles[i].y - particles[j].y;
          const dist = Math.sqrt(dx * dx + dy * dy);

          if (dist < 90) {
            const alpha = (1 - dist / 90) * 0.08;
            ctx.strokeStyle = `rgba(20, 184, 166, ${alpha})`;
            ctx.lineWidth = 0.8;
            ctx.beginPath();
            ctx.moveTo(particles[i].x, particles[i].y);
            ctx.lineTo(particles[j].x, particles[j].y);
            ctx.stroke();
          }
        }

        // Draw connections to the mouse position
        if (mouse.x !== null && mouse.y !== null) {
          const dx = particles[i].x - mouse.x;
          const dy = particles[i].y - mouse.y;
          const dist = Math.sqrt(dx * dx + dy * dy);

          if (dist < mouse.radius) {
            const alpha = (1 - dist / mouse.radius) * 0.12;
            ctx.strokeStyle = `rgba(20, 184, 166, ${alpha})`;
            ctx.lineWidth = 0.8;
            ctx.beginPath();
            ctx.moveTo(particles[i].x, particles[i].y);
            ctx.lineTo(mouse.x, mouse.y);
            ctx.stroke();
          }
        }
      }
    }

    function animate() {
      ctx.clearRect(0, 0, canvas.width, canvas.height);
      
      particles.forEach(p => {
        p.update();
        p.draw();
      });

      drawLines();
      requestAnimationFrame(animate);
    }

    // Event listeners
    window.addEventListener('resize', resizeCanvas);
    window.addEventListener('mousemove', (e) => {
      mouse.x = e.clientX;
      mouse.y = e.clientY;
    });
    window.addEventListener('mouseleave', () => {
      mouse.x = null;
      mouse.y = null;
    });

    // Initialize and run
    resizeCanvas();
    animate();
  }
});
