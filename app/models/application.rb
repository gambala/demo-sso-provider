class Application < ActiveRecord::Base
	attr_accessible :account_id, :name, :redirect_uri, :secret, :uid

	before_create :default_values
	def default_values
		self.uid = SecureRandom.hex(16)
		self.secret = SecureRandom.hex(16)
	end
end
