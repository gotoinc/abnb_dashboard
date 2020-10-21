require 'selenium-webdriver'

class Browser

  attr_reader :options

  def initialize
    # Initialize a default driver options
    @options = Selenium::WebDriver::Chrome::Options.new
  end

  def call
    # Initialize the driver with our desired browser
    @driver ||= Selenium::WebDriver.for :chrome, options: options
  end

  private

  def options
    @options.add_argument('--headless')
    @options
  end
end
