# == Schema Information
#
# Table name: abnb_dates
#
#  id                :bigint           not null, primary key
#  available         :boolean
#  available_checkin :boolean
#  bookable          :boolean
#  date              :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  scanning_id       :bigint           not null
#
# Indexes
#
#  index_abnb_dates_on_scanning_id  (scanning_id)
#
class AbnbDate < ApplicationRecord

  # relations
  belongs_to :scanning, inverse_of: :abnb_dates
end
