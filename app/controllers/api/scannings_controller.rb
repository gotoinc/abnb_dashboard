module Api
  class ScanningsController < ApplicationController

    before_action :authenticate_user!

    def create
      scanner.call(scanning_url).then do |result|
        scanner_updater(result).call
      end

      redirect_to dashboard_path
    end

    private

    def scanning_url
      params.fetch(:url)
    end

    def browser
      Browser.new
    end

    def scanner
      Abnb::ScrapingService.new(browser.call)
    end

    def scanner_updater(result)
      ScanningUpdatingService.new(result, current_user)
    end
  end
end
