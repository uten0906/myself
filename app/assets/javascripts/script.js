$(document).on("turbolinks:load", function() {
  const alertElement = document.querySelector(".alert");
  function alertFadeout() {
    setTimeout(function() {
      alertElement.classList.add("fadeout");
    }, 5000);
  }
  if (alertElement != null) {
    window.onload = alertFadeout();
  }

  const targetElement = document.querySelectorAll(".animationTarget");
  function targetElementAddShow() {
    for (let i = 0; i < targetElement.length; i++) {
      const getElementDistance = targetElement[i].getBoundingClientRect().top + targetElement[i].clientHeight * .2
      if (window.innerHeight > getElementDistance) {
        targetElement[i].classList.add("show");
      }
    }
  }
  window.onload = targetElementAddShow();
  document.addEventListener("scroll", targetElementAddShow);
})

