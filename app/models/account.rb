class Account < ActiveRecord::Base
  attr_accessible :info
  validates :info, presence: true
  serialize :info, Hash

  has_many :authentications

  has_many :applications
  has_many :grants

  def add_info(info)
    self.info.merge!(info){|key, oldval, newval| [*oldval].to_a | [*newval].to_a}
  end

  def add_authentications(authentications)
    self.authentications << authentications
  end

  def get_info(key)
    if self.info[key].kind_of?(Array)
      return self.info[key][0]
    else
      return self.info[key]
    end
  end
end
