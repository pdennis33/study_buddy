// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import mrujs from 'https://cdn.jsdelivr.net/npm/mrujs@1.0.2/+esm'

window.Turbo = Turbo;

mrujs.start();

// Initialize all tooltips on the page
document.addEventListener("turbo:load", function() {
  const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
  tooltipTriggerList.forEach(function (tooltipTriggerEl) {
    new bootstrap.Tooltip(tooltipTriggerEl);
  });
});
