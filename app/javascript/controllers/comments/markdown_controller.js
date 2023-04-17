import { Controller } from "@hotwired/stimulus"
import marked from "marked"

// Connects to data-controller="comments--markdown"
export default class extends Controller {
  connect() {
    const content = this.element.textContent.trim()

    marked.setOptions({
      renderer: new marked.Renderer(),
      highlight: function (code, lang) {
        const hljs = require("highlight.js")
        const language = hljs.getLanguage(lang) ? lang : "plaintext"
        return hljs.highlight(code, { language }).value
      },
      langPrefix: "hljs language-", // highlight.js css expects a top-level 'hljs' class.
      pedantic: false,
      gfm: true,
      breaks: false,
      sanitize: false,
      smartypants: false,
      xhtml: false,
    })

    this.element.innerHTML = marked.parse(content)
  }
}
