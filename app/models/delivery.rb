# == Schema Information
#
# Table name: deliveries
#
#  id                    :integer          not null, primary key
#  arrived               :boolean
#  description           :string
#  details               :string
#  supposed_to_arrive_on :date
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_id               :integer
#
class Delivery < ApplicationRecord
  validates(:description, presence: true)
  validates(:supposed_to_arrive_on, presence: true)

  belongs_to(:owner, class_name: "User", foreign_key: "user_id")
end
