# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    name "MyString"
    type ""
    departing "2012-06-28 13:45:27"
    duration "2012-06-28 13:45:27"
    distance 1.5
    heartbeats 1
    burnedcalories 1.5
    feeling ""
    weather "MyString"
    notes "MyString"
  end
end
