ENV['RACK_ENV'] = 'test'

require("rspec")
require("pg")
require("sinatra/activerecord")
require("employee")
require("division")

RSpec.configure do |config|
  config.after(:each) do
    Division.all().each() do |division|
      division.destroy()
    end
    # Employee.all().each() do |list|
    #   employee.destroy()
    # end
  end
end
