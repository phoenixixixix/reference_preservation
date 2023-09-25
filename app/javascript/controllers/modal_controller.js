import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.modal = document.getElementById("form_modal")
  }

  open() {
    this.modal.showModal()
  }

  close(e) {
    if (e.detail.success) {
      this.modal.close()
    }
  }
}