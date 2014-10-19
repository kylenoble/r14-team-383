# == Schema Information
#
# Table name: links
#
#  id         :integer          not null, primary key
#  name       :text
#  href       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Link < ActiveRecord::Base
end
