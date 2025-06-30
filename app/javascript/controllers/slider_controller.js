import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slide", "bullet"]
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

  disconnect() {
    this.stopAutoplay()
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

  pauseOnHover() {
    this.stopAutoplay()
  }

  resumeOnLeave() {
    if (this.autoplayValue) {
      this.startAutoplay()
    }
  }

  nextSlide() {
    this.currentSlide = (this.currentSlide + 1) % this.totalSlides
    this.showSlide(this.currentSlide)
  }

  prevSlide() {
    this.currentSlide = (this.currentSlide - 1 + this.totalSlides) % this.totalSlides
    this.showSlide(this.currentSlide)
  }

  goToSlide(event) {
    const slideNumber = parseInt(event.currentTarget.dataset.slide)
    this.currentSlide = slideNumber - 1
    this.showSlide(this.currentSlide)
  }

  showSlide(index) {
    this.slideTargets.forEach((slide, i) => {
      slide.classList.toggle('active', i === index)
    })

    this.bulletTargets.forEach((bullet, i) => {
      bullet.classList.toggle('active', i === index)
    })
  }
}
