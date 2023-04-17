import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="users--avatar"
export default class extends Controller {
  remove(e) {
    e.preventDefault()

    this.#setRemoveFlag()
    this.element.remove()
  }

  #setRemoveFlag() {
    const flag = document.createElement("input")
    flag.setAttribute("type", "hidden")
    flag.setAttribute("name", "user[remove_avatar]")
    flag.value = true

    this.element.insertAdjacentElement("beforebegin", flag)
  }
}
