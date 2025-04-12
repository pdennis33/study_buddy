function initializeScrollRestore() {
  // STEP 1: Save scroll position if a reorder button is clicked
  document.addEventListener("click", function (event) {
    if (event.target.closest(".reorder-button")) {
      const scrollY = window.scrollY;
      sessionStorage.setItem("scrollPosition", scrollY);
      sessionStorage.setItem("restoreScroll", "true");
    }
  });

  // STEP 2: Restore if flagged
  if (sessionStorage.getItem("restoreScroll") === "true") {
    const scrollY = sessionStorage.getItem("scrollPosition");
    if (scrollY !== null) {
      window.scrollTo(0, parseInt(scrollY));
    }
    // Clean up so it doesn't apply to unrelated navigations
    sessionStorage.removeItem("scrollPosition");
    sessionStorage.removeItem("restoreScroll");
  }
}

// Use turbo:load for Turbo navigation
if (document.readyState === "loading") {
  document.addEventListener("turbo:load", initializeScrollRestore);
} else {
  initializeScrollRestore();
}
