class Authentication < ActiveRecord::Base
  attr_accessible :account_id, :provider, :uid
  belongs_to :account
end
