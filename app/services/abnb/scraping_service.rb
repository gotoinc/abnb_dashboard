module Abnb
  class ScrapingService

    attr_reader :url

    Result = Struct.new(:title, :location)

    def call(url = nil)
      @url = url
      fetch_data
    end

    private

    def fetch_data
      Result.new(parse[:title], parse[:location])
    end

    def parse
      response_html = Nokogiri::HTML.parse(perform_request.body)
      {
          title: response_html.at_css('.title-selector')&.children.try(:[], 0)&.text&.strip,
          location: response_html.at_css('.location-selector')&.children.try(:[], 0)&.text&.strip
      }
    end

    def perform_request
      RestClient.get(url)
    end
  end
end