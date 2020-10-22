module Abnb
  class ScrapingService
    SELECTORS = {
        abnb_id: '#site-content form > input[name=hosting_id]',
        location: 'div:nth-child(1) > div > div > div > div > section > div > div > span:nth-child(5) > span > a',
        title: 'div:nth-child(1) > div > div > div > div > section > div > div > h1',
        root_element: '#site-content > div > div > div:nth-child(1)'
    }
    Result = Struct.new(:title, :location, :abnb_id, :url)

    attr_reader :url,
                :browser

    def initialize(browser)
      @browser = browser
    end

    def call(url = nil)
      @url = url

      perform_request
      fetch_data
    end

    private

    def perform_request
      browser.get(url)
    end

    def fetch_data
      Result.new(title, location, abnb_id, url)
    end

    # Getters
    def root_element
      browser.find_element(:css, SELECTORS[:root_element]) rescue nil
    end

    def title
      root_element.find_element(:css, SELECTORS[:title])&.text rescue nil
    end

    def location
      root_element.find_element(:css, SELECTORS[:location])&.text rescue nil
    end

    def abnb_id
      browser.find_element(:css, SELECTORS[:abnb_id])&.attribute('value') rescue nil
    end
  end
end
