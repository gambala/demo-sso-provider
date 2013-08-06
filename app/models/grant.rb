class Grant < ActiveRecord::Base
	attr_accessible :access_token, :access_token_expires_at, :code, :refresh_token
	belongs_to :account
	belongs_to :application
	before_create :generate_tokens

	def generate_tokens
		self.code, self.access_token, self.refresh_token = SecureRandom.hex(16), SecureRandom.hex(16), SecureRandom.hex(16)
		self.access_token_expires_at = Time.now + 2.weeks
		# self.access_token_expires_at = Time.now + 5.minutes
	end
end
