class Checkin < ActiveRecord::Base
  belongs_to :user

  scope :reposted, :conditions => {:reposted => true}
end
