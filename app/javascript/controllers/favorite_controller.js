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

    const { liked, id } = this.element.dataset
    this.resumeId = id
    this.isLiked = liked == "true" ? true : false

    this.updateIcon()
  }

  updateIcon() {
    if (this.isLiked) {
      this.iconTarget.classList.remove("fa-regular")
      this.iconTarget.classList.add("fa-solid")
    } else {
      this.iconTarget.classList.add("fa-regular")
      this.iconTarget.classList.remove("fa-solid")
    }
  }

  like() {
    this.isLiked = !this.isLiked
    this.updateIcon()

    Rails.ajax({
      url: `/resumes/${this.resumeId}/like`,
      type: "POST",
      success: function ({ id, status }) {
        // 成功的話...
        console.log(id, status)
      },
      error: function (error) {
        console.error("Error:", error)
      },
    })
  }
}
