# == Schema Information
#
# Table name: scannings
#
#  id         :bigint           not null, primary key
#  location   :string
#  title      :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  abnb_id    :string
#  user_id    :bigint           not null
#
# Indexes
#
#  index_scannings_on_user_id  (user_id)
#
class Scanning < ApplicationRecord
  LIMIT_RANGE_DAYS = 30

  # relations
  has_many :abnb_dates, dependent: :destroy, inverse_of: :scanning
  belongs_to :user, inverse_of: :scannings

  # validators
  validates_presence_of :user

  # instance_methods
  def occupancy_rate
    start_date = DateTime.now.to_date
    end_date = DateTime.now.to_date + LIMIT_RANGE_DAYS.days
    ((abnb_dates.where(date: start_date ... end_date).where(bookable: true).count.to_f / LIMIT_RANGE_DAYS) * 100).round(1)
  end
end
