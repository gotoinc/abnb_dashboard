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

  # relations
  belongs_to :user, inverse_of: :scannings

  # validators
  validates_presence_of :user
end
