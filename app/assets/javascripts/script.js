$(document).on("turbolinks:load", function() {
  const fadeoutElement = document.querySelector(".fadeoutTarget");
  function flashFadeout() {
    setTimeout(function() {
      fadeoutElement.classList.add("fadeout");
    }, 5000);
  }
  if (fadeoutElement != null) {
    window.onload = flashFadeout();
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

