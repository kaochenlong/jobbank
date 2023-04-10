import { Controller } from "@hotwired/stimulus"
import { patch } from "@rails/request.js"
import Sortable from "sortablejs"
import { myAlert } from "utils/notify"

// Connects to data-controller="sortable"
export default class extends Controller {
  connect() {
    Sortable.create(this.element, {
      ghostClass: "drag-ghost",
      onUpdate: async (e) => {
        const { resumeId } = e.item.dataset
        const newIndex = e.newIndex + 1

        const url = `/api/v1/resumes/${resumeId}/sort`

        const resp = await patch(url, { body: JSON.stringify({ newIndex }) })

        if (resp.ok) {
          myAlert("成功更新順序")
        }

        // patch(url, { body: JSON.stringify({ newIndex }) }).then((resp) => {
        //   if (resp.ok) {
        //     myAlert("成功更新順序")
        //   }
        // })
      },
    })
  }
}
