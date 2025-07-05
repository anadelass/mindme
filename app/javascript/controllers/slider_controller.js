// app/javascript/controllers/slider_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slide"]
  static values = {
    autoplay: Boolean,
    interval: Number
  }

  connect() {
    this.currentSlide = 0
    this.totalSlides = this.slideTargets.length

    if (this.autoplayValue) {
      this.startAutoplay()
    }
  }

  startAutoplay() {
    this.autoplayTimer = setInterval(() => {
      this.nextSlide()
    }, this.intervalValue || 5000)
  }

  stopAutoplay() {
    if (this.autoplayTimer) {
      clearInterval(this.autoplayTimer)
    }
  }

  nextSlide() {
    this.currentSlide = (this.currentSlide + 1) % this.totalSlides // Bucle continuo
    this.showSlide(this.currentSlide)
  }

  previousSlide() {
    this.currentSlide = this.currentSlide === 0 ? this.totalSlides - 1 : this.currentSlide - 1 // Bucle continuo
    this.showSlide(this.currentSlide)
  }

  goToSlide(event) {
    this.currentSlide = parseInt(event.target.dataset.slideIndex)
    this.showSlide(this.currentSlide)
  }

  showSlide(index) {
    this.slideTargets.forEach((slide, i) => {
      slide.classList.toggle("active", i === index)
    })

    // Actualizar indicadores
    const indicators = this.element.querySelectorAll('.indicator')
    indicators.forEach((indicator, i) => {
      indicator.classList.toggle("active", i === index)
    })
  }

  pauseOnHover() {
    this.stopAutoplay()
  }

  resumeOnLeave() {
    if (this.autoplayValue) {
      this.startAutoplay()
    }
  }
}
