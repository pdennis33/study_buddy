// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";

// Handle confirmation for links
document.addEventListener("turbo:click", function(event) {
    let element = event.target.closest("[data-confirm]");
    if (element) {
        let message = element.getAttribute("data-confirm");
        if (!confirm(message)) {
            event.preventDefault();  // Prevent the navigation if not confirmed
        }
    }
});

// Handle confirmation for forms (like button_to)
document.addEventListener("turbo:submit-start", function(event) {
    let form = event.target;
    let submitButton = form.querySelector("[data-confirm]");

    if (submitButton) {
        let message = submitButton.getAttribute("data-confirm");

        if (!confirm(message)) {
            event.preventDefault();
            event.detail.formSubmission.stop();
        }
    }
});
