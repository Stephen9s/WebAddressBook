class Address < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :user_id, :f_name, :l_name, :phone_num
end
