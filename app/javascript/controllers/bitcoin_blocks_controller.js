import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['hash', 'btn', 'error'];

  connect() {
    if (this.btnTarget) this.btnTarget.type = 'button';
  }

  error(status) {
    switch (status) {
      case 409:
        throw new Error('The entered hash is already stored');
      case 404:
        throw new Error('No block found with that hash');
      default:
        throw new Error('An error has ocurred');
    }
  }

  async add(event) {
    const hash = this.hashTarget.value;
    // only letters and numbers
    const regex = new RegExp('^[a-zA-Z0-9]*$');

    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

    try {
      if (hash === '') throw new Error('The input is empty');
      if (!regex.test(hash))
        throw new Error('Only allowed to write letters and numbers');

      const apiRes = await fetch(`https://blockchain.info/rawblock/${hash}`);

      if (!apiRes.ok) throw new Error(this.error(apiRes.status));

      const data = await apiRes.json();

      const newBlock = {
        hash_id: hash,
        bits: data.bits,
        time: data.time,
        prev_block: data.prev_block,
        block_index: data.block_index,
      };

      const response = await fetch('/', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken,
        },
        body: JSON.stringify(newBlock),
      });

      if (response.ok) {
        this.hashTarget.value = '';
        this.errorTarget.innerHTML = '';
        return Turbo.renderStreamMessage(await response.text());
      }

      throw new Error(this.error(response.status));
    } catch (err) {
      const message =
        err.message === 'Failed to fetch'
          ? 'An error has occurred in the application, try checking your internet connection'
          : err.message;

      this.errorTarget.insertAdjacentHTML(
        'afterbegin',
        `
        <div class="alert bg-red-100 mt-6 rounded-lg py-5 px-6  text-base text-red-700 inline-flex items-center w-full alert-dismissible fade show" role="alert">
          ${message}
          <button type="button" class="btn-close box-content w-4 h-4 p-1 ml-auto text-red-900 border-none rounded-none opacity-50 focus:shadow-none focus:outline-none focus:opacity-100 hover:text-red-900 hover:opacity-75 hover:no-underline" data-bs-dismiss="alert" aria-label="Close">X</button>
        </div>
      `
      );
    }
  }
}
