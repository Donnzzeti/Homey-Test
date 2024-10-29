import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["status"]

  connect() {
    this.element.addEventListener("ajax:success", (event) => {
      const [data, status, xhr] = event.detail
      this.statusTarget.textContent = data.status
    })
  }
}