class Offer < ActiveRecord::Base
  belongs_to :fruit
  belongs_to :vegetable
end
