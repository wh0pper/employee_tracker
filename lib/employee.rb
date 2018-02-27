class Employee < ActiveRecord::Base
  belongs_to(:divisons)
  has_and_belongs_to_many(:projects)
end
