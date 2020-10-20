module Dashboard
  class ApplicationController < ActionController::Base
    layout 'dashboard'

    before_action :authenticate_user!

    def index
      render template: 'application'
    end
  end
end
