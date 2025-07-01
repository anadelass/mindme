// app/javascript/controllers/testimonials_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item"]
  static values = { interval: Number }

  connect() {
    this.currentTestimony = 0
    this.totalTestimonies = this.itemTargets.length
    this.startAutoplay()
  }

  disconnect() {
    this.stopAutoplay()
  }

  startAutoplay() {
    this.autoplayTimer = setInterval(() => {
      this.nextTestimony()
    }, this.intervalValue || 4000)
  }

  stopAutoplay() {
    if (this.autoplayTimer) {
      clearInterval(this.autoplayTimer)
    }
  }

  nextTestimony() {
    this.currentTestimony = (this.currentTestimony + 1) % this.totalTestimonies
    this.showTestimony(this.currentTestimony)
  }

  showTestimony(index) {
    this.itemTargets.forEach((item, i) => {
      item.classList.toggle('active', i === index)
    })
  }
}
