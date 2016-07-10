# == Schema Information
#
# Table name: visitations
#
#  id         :uuid             not null, primary key
#  visitor_id :integer          not null
#  address    :citext           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :visitation do
    address { FFaker::Internet.http_url }

    association :visitor, factory: :visitors
  end
end
