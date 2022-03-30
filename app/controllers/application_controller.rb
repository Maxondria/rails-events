class ApplicationController < ActionController::Base
  # Add a custom flash key to the flash hash
  add_flash_types :danger
end
