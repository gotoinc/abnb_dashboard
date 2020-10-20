# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  api_key                :string           not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  login                  :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #relations
  has_many :scannings, dependent: :destroy, inverse_of: :user

  #validators
  validates_presence_of :api_key

  #callbacks
  before_validation do
    self.api_key ||= self.class.generate_api_key
  end

  #class methods
  def self.generate_api_key
    loop do
      _uniq_key = SecureRandom.hex(5)
      break _uniq_key unless self.exists?(api_key: _uniq_key)
    end
  end
end
