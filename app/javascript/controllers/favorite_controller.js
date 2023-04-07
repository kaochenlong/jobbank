import { Controller } from "@hotwired/stimulus"
import Rails from "@rails/ujs"
import Swal from "sweetalert2"

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

  notify(message) {
    const Toast = Swal.mixin({
      toast: true,
      position: "top-end",
      showConfirmButton: false,
      timer: 2000,
      timerProgressBar: true,
      didOpen: (toast) => {
        toast.addEventListener("mouseenter", Swal.stopTimer)
        toast.addEventListener("mouseleave", Swal.resumeTimer)
      },
    })

    Toast.fire({
      icon: "success",
      title: message,
    })
  }

  like() {
    this.isLiked = !this.isLiked
    this.updateIcon()
    Rails.ajax({
      url: `/resumes/${this.resumeId}/like`,
      type: "POST",
      success: ({ status }) => {
        // 成功的話...
        console.log(status)
        if (status == "like") {
          this.notify("已收藏")
        } else {
          this.notify("取消收藏")
        }
      },
      error: function (error) {
        console.error("Error:", error)
      },
    })
  }
}
