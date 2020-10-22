module Api
  class ScanningsController < ApplicationController

    before_action :authenticate_user!
    before_action :validate_abnb_url!

    def create
      scanner.call(scanning_url).then do |result|
        scanner_updater(result).call
        browser.quit
      end

      redirect_to dashboard_path
    end

    private

    def validate_abnb_url!
      scanning = Scanning.new(url: scanning_url)
      scanning.valid?
      return redirect_to dashboard_path, notice: scanning.errors.messages[:url] if scanning.errors[:url].any?
    end

    def scanning_url
      params.fetch(:url)
    end

    def browser
      @browser ||= Browser.new.call
    end

    def scanner
      Abnb::ScrapingService.new(browser)
    end

    def scanner_updater(result)
      ScanningUpdatingService.new(result, current_user)
    end
  end
end
