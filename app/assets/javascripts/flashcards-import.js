function initializeImportButton() {
    // Handle flashcards file import
    const importButton = document.getElementById("import-button");
    if (!importButton) return;  // If the import button does not exist

    const fileInput = document.getElementById("file-input");
    const form = document.getElementById("import-form");

    // When the button is clicked, trigger the file input click
    importButton.addEventListener("click", function () {
        fileInput.click();
    });

    // When a file is selected, automatically submit the form
    fileInput.addEventListener("change", function () {
        if (fileInput.files.length > 0) {
            form.submit();  // Automatically submit the form after file selection
        }
    });
}

// Check if the document is already loaded
if (document.readyState === 'loading') {
    // The document is still loading, so wait for the turbo:load event
    document.addEventListener("turbo:load", initializeImportButton);
} else {
    // The document is already loaded, so initialize immediately
    initializeImportButton();
}
