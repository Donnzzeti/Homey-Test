import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["comments"]

  connect() {
    this.element.addEventListener("ajax:success", (event) => {
      const [data, status, xhr] = event.detail
      this.commentsTarget.insertAdjacentHTML("beforeend", `<li>${data.content} - commented by ${data.user.email}</li>`)
    })
  }
}