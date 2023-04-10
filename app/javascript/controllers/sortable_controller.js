import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

// Connects to data-controller="sortable"
export default class extends Controller {
  connect() {
    Sortable.create(this.element, {
      ghostClass: "drag-ghost",
      onUpdate: function (e) {
        // 打 API
        console.log("go!")
      },
    })
  }
}
