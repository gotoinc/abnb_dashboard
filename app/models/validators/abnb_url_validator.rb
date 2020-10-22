module Validators
  class AbnbUrlValidator < ActiveModel::Validator

    InvalidUrl = Class.new(URI::InvalidURIError)
    InvalidUrlFormat = Class.new(StandardError)

    def validate(record)
      value = record.url
      return if value.blank?

      begin
        uri = URI.parse(value)
        reg = /^https?:\/\/(www.)?(airbnb.com\/(h\/[a-z0-9-]+|rooms\/\d+)+|abnb.me\/[a-zA-Z0-9]+)/
        case
        when !uri.kind_of?(URI::HTTP)
          raise InvalidUrl, 'Invalid url'
        when !(reg =~ value)
          raise InvalidUrlFormat, 'Invalid url format'
        end
      rescue => e
        record.errors.add(:url, options[:message] || e.message)
      end
    end
  end
end