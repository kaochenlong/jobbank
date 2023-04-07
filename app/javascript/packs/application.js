import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "styles"
import "controllers"
import "@hotwired/turbo-rails"

Rails.start()
Turbolinks.start()
ActiveStorage.start()
