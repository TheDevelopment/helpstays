class BedsController < ApplicationController
  include AuthenticatedSystem

  layout "main"
  
  def index
    @houses = current_user.houses
  end
end
