module Abnb
  class DatesScrapingService

    BASE_URI = 'https://www.airbnb.com/api/v3/PdpAvailabilityCalendar'.freeze
    ABNB_API_KEY = 'd306zoyjsyarp7ifhu67rjxn52tv0t20'.freeze
    ABNB_SHA_256_HASH = 'b94ab2c7e743e30b3d0bc92981a55fff22a05b20bcc9bcc25ca075cc95b42aac'.freeze

    MONTHS_DEEP_KEY = 'data.merlin.pdpAvailabilityCalendar.calendarMonths'.freeze

    DayResult = Struct.new(:date, :available, :available_checkin, :bookable)
    Result = proc{ |date| DayResult.new(Date.parse(date['calendarDate']), date['available'], date['availableForCheckin'], date['bookable']) }

    attr_reader :listing_id

    def call(listing_id)
      @listing_id = listing_id
      response = perform_request
      dates = extract_dates(JSON.parse(response.body))
      dates.map &Result
    end

    private

    def perform_request
      RestClient.get(url, headers)
    end

    def headers
      { 'X-Airbnb-GraphQL-Platform': 'web', 'X-Airbnb-API-Key': ABNB_API_KEY }
    end

    def url
      uri = URI.parse(BASE_URI)
      uri.query = Rack::Utils.build_query(params)
      uri.to_s
    end

    def params
      {
        operationName: 'PdpAvailabilityCalendar',
        currency: 'USD',
        locale: 'en',
        variables: { request: { count: 2, listingId: listing_id, month: DateTime.now.month, year: DateTime.now.year } }.to_json,
        extensions: { persistedQuery: { version: 1, sha256Hash: ABNB_SHA_256_HASH } }.to_json
      }
    end

    def extract_dates(body)
      MONTHS_DEEP_KEY.split('.').inject(body) { |result, key| result.send(:[], key) }.map{ |month| month['days'] }.flatten
    end
  end
end
