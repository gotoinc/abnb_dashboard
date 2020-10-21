class ScanningUpdatingService

  attr_accessor :dates
  attr_reader :scanning,
              :scanning_result

  def initialize(scanning_result, user)
    @dates = []
    @scanning = Scanning.find_or_initialize_by(abnb_id: scanning_result.abnb_id, user_id: user.id)
    @scanning_result = scanning_result
  end

  def call
    scanning.assign_attributes(scanning_result.to_h)
    dates = dates_scraping.call(scanning_result.abnb_id) if scanning.save
    dates.each do |item|
      date = AbnbDate.find_or_initialize_by(date: item.date, scanning: scanning)
      date.assign_attributes(item.to_h)
      date.save
    end
  end

  private

  def dates_scraping
    Abnb::DatesScrapingService.new
  end
end
