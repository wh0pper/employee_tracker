require("sinatra")
require("sinatra/reloader")
require("sinatra/activerecord")
also_reload("lib/**/*.rb")
require("./lib/employee")
require("./lib/division")
require("pg")

get("/") do
  erb(:index)
end

get("/divisions") do
  @divisions = Division.all()
  erb(:divisions)
end

get("/employees") do
  @employees = Employee.all()
  erb(:employees)
end

post("/division") do
  title = params.fetch("title")
  division = Division.new({:title => title, :id => nil})
  division.save()
  erb(:success)
end

get("/division/new") do
  erb(:divisionform)
end

get("/employee/new") do
  erb(:employeeform)
end

post("/employee") do
  name = params.fetch("name")
  employee = Employee.new({:name => name, :id => nil})
  employee.save()
  erb(:success)
end
