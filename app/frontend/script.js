const menuToggle = document.getElementById("menuToggle");
const navLinks = document.getElementById("navLinks");

menuToggle.addEventListener("click", () => {
    navLinks.classList.toggle("active");
});

document.querySelectorAll(".nav-links a").forEach((link) => {
    link.addEventListener("click", () => {
        navLinks.classList.remove("active");
    });
});

async function checkTestService() {
  const status = document.getElementById("test-status");

  try {
    const response = await fetch("/api/test");
    const data = await response.json();

    status.textContent = `${data.message} — ${data.status.toUpperCase()}`;
  } catch (error) {
    status.textContent = "Test service unavailable";
  }
}

checkTestService();