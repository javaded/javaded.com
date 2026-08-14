import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "icon"]

  toggle() {
    const isHidden = this.menuTarget.classList.toggle("hidden")
    this.menuTarget.classList.toggle("flex", !isHidden)
    this.iconTarget.textContent = isHidden ? "menu" : "close"
  }
}
