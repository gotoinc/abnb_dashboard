require 'selenium-webdriver'

class Browser

  attr_reader :options

  def initialize
    # Initialize a default driver options
    @options = Selenium::WebDriver::Chrome::Options.new(
        args: %w[no-sandbox disable-dev-shm-usage disable-popup-blocking headless disable-gpu window-size=1920,1080 --enable-features=NetworkService,NetworkServiceInProcess --disable-features=VizDisplayCompositor],
        log_level: :error
    )
  end

  def call
    # Initialize the driver with our desired browser
    @driver ||= Selenium::WebDriver.for :chrome, options: options
  end
end
