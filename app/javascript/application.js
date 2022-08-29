// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails';
import 'controllers';
import '@fortawesome/fontawesome-free';
import 'tw-elements/dist/plugin';

import Pagy from 'pagy-module';
window.addEventListener('turbo:load', Pagy.init);
