import { Controller } from "@hotwired/stimulus"
import dropin from "braintree-web-drop-in"

// Connects to data-controller="braintree"
export default class extends Controller {
  static targets = ["dropin", "nonce"]

  initialize() {
    this.instance = null
  }

  initElements() {
    // dropin
    const dropIn = document.createElement("div")
    dropIn.setAttribute("data-braintree-target", "dropin")

    this.element.insertAdjacentElement("afterbegin", dropIn)

    // form
    this.element.setAttribute("data-action", "submit->braintree#getNonce")

    // hidden field
    const hidden = document.createElement("input")
    hidden.setAttribute("type", "hidden")
    hidden.setAttribute("name", "nonce")
    hidden.setAttribute("data-braintree-target", "nonce")
    this.element.appendChild(hidden)
  }

  getNonce(e) {
    e.preventDefault()

    this.instance &&
      this.instance.requestPaymentMethod().then(({ nonce }) => {
        this.nonceTarget.value = nonce
        this.element.submit()
      })
  }

  connect() {
    this.initElements()

    const { token } = this.element.dataset

    dropin
      .create({
        authorization: token,
        container: this.dropinTarget,
      })
      .then((instance) => {
        this.instance = instance
      })
      .catch((err) => {
        console.log(err)
      })
  }
}
