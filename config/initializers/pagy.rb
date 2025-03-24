# config/initializers/pagy.rb
require 'pagy/extras/bootstrap' # Optional if using bootstrap styling

Pagy::VARS[:items] ||= 6

