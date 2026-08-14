import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "icon"]

  toggle() {
    const hidden = this.menuTarget.classList.toggle("hidden")
    this.iconTarget.textContent = hidden ? "menu" : "close"
  }
}
