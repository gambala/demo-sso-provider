class Account < ActiveRecord::Base
  attr_accessible :info
  validates :info, presence: true
  serialize :info, Hash

  has_many :authentications
end
