import { Controller } from "@hotwired/stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = ["icon"]

  initialize() {
    this.isLiked = false
    this.resumeId = undefined
  }

  connect() {
    this.element.setAttribute("data-action", "click->favorite#like")
    this.resumeId = this.element.dataset.id
  }

  like() {
    Rails.ajax({
      url: `/resumes/${this.resumeId}/like`,
      type: "POST",
      success: function ({ id, status }) {
        console.log(id, status)
      },
      error: function (error) {
        console.error("Error:", error)
      },
    })

    if (this.isLiked) {
      // 打 API

      this.iconTarget.classList.add("fa-regular")
      this.iconTarget.classList.remove("fa-solid")
    } else {
      // 打 API

      this.iconTarget.classList.remove("fa-regular")
      this.iconTarget.classList.add("fa-solid")
    }
    this.isLiked = !this.isLiked
  }
}
