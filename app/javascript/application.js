// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import Rails from "@rails/ujs"
Rails.start()

document.addEventListener("turbo:load", function () {
  document.querySelectorAll(".menu-button").forEach(button => {
    button.addEventListener("click", function (event) {
      event.stopPropagation();
      let menu = this.nextElementSibling;
      
      // Close all other open menus
      document.querySelectorAll(".dropdown-menu").forEach(m => {
        if (m !== menu) m.style.display = "none";
      });

      // Toggle current menu
      menu.style.display = menu.style.display === "block" ? "none" : "block";
    });
  });

  // Close dropdown when clicking outside
  document.addEventListener("click", function () {
    document.querySelectorAll(".dropdown-menu").forEach(menu => menu.style.display = "none");
  });
});
