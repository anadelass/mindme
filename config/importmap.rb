# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "chartkick", to: "chartkick" # @5.0.1
pin "Chart.bundle", to: "Chart.bundle.js" # Usa Chart.js como backend
pin "chart.js" # @4.5.0
pin "@kurkle/color", to: "@kurkle--color.js" # @0.3.4
