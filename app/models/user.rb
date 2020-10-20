class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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
