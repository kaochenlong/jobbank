import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  input(e) {
    const content = e.target.value.trim()

    if (content != "") {
      // 開
      this.buttonTarget.classList.remove("btn-disable")
      this.buttonTarget.classList.add("btn-primary")
      this.buttonTarget.removeAttribute("disabled")
    } else {
      // 關
      this.buttonTarget.classList.remove("btn-primary")
      this.buttonTarget.classList.add("btn-disable")
      this.buttonTarget.setAttribute("disabled", "")
    }
  }
}
