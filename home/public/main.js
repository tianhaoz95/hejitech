document.addEventListener('DOMContentLoaded', () => {
  // --- CLIENT-SIDE ROUTER ---
  const views = {
    home: document.getElementById('home-view'),
    terms: document.getElementById('terms-view')
  };

  const navTermsLink = document.getElementById('nav-terms-link');
  const footerTermsLink = document.getElementById('footer-terms-link');
  const navLogoBtn = document.getElementById('nav-logo-btn');
  const termsBackBtn = document.getElementById('terms-back-btn');

  function navigateTo(path, scrollTarget = null) {
    window.history.pushState({}, '', path);
    handleRoute(scrollTarget);
  }

  function handleRoute(scrollTarget = null) {
    const path = window.location.pathname;

    if (path === '/terms' || path === '/terms/') {
      // Show terms view, hide home view
      views.home.classList.add('hidden');
      views.terms.classList.remove('hidden');
      document.title = 'Terms of Service | Heji Technology LLC';
      window.scrollTo(0, 0);
    } else {
      // Show home view, hide terms view
      views.terms.classList.add('hidden');
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
    // Logo navigation
    if (e.target.closest('#nav-logo-btn') || e.target.closest('#terms-back-btn')) {
      e.preventDefault();
      navigateTo('/');
    }

    // Terms page navigation
    if (e.target.closest('#nav-terms-link') || e.target.closest('#footer-terms-link')) {
      e.preventDefault();
      navigateTo('/terms');
    }

    // Anchors on home page
    const anchorLink = e.target.closest('a[href^="#"]');
    if (anchorLink) {
      e.preventDefault();
      const targetHash = anchorLink.getAttribute('href');
      
      if (window.location.pathname === '/terms') {
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
});
