import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ui--tag"
export default class extends Controller {
  static values = {
    style: {
      type: String,
      default: "bg-red-300",
    },
  }

  initialize() {
    this.input = null
    this.inputArea = null
  }

  connect() {
    this.input = this.element.querySelector("input")
    this.input.setAttribute("type", "hidden")
    this.createInputArea()
  }

  typing(e) {
    // console.log(data)
    this.input.value = this.inputArea.textContent
  }

  createInputArea() {
    this.inputArea = document.createElement("div")
    this.inputArea.setAttribute("class", this.styleValue)
    this.inputArea.setAttribute("contenteditable", true)
    this.inputArea.setAttribute("data-action", "input->ui--tag#typing")
    this.inputArea.textContent = this.input.value

    this.element.appendChild(this.inputArea)
  }
}
