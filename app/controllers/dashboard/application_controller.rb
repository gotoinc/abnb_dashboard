module Dashboard
  class ApplicationController < ActionController::Base
    layout 'dashboard'

    before_action :authenticate_user!

    def index
      @scannings = current_user.scannings.order('updated_at DESC')

      render template: 'application'
    end
  end
end
