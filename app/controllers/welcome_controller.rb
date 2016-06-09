class WelcomeController < ApplicationController

  def index
    redirect_to portal_patients_path()
  end
end
