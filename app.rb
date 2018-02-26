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

get("/employee/:id") do
  @employee = Employee.find(params.fetch("id").to_i())
  # @divisions = Division.all() <- Add when you want to show division employee is part of
  erb(:employeeinfo)
end

get("/division/:id") do
  @division = Division.find(params.fetch("id").to_i())
  # @employees = Employee.all() <- Add when you want to show employees that are part of that division.
  erb(:divisioninfo)
end

post("/employee") do
  name = params.fetch("name")
  employee = Employee.new({:name => name, :id => nil})
  employee.save()
  erb(:success)
end

patch("/employee/:id") do
  name = params.fetch("name")
  @employee = Employee.find(params.fetch("id").to_i())
  @employee.update({:name => name})
  # @tasks = Task.all()
  erb(:success)
end

patch("/division/:id") do
  title = params.fetch("title")
  @division = Division.find(params.fetch("id").to_i())
  @division.update({:title => title})
  # @tasks = Task.all()
  erb(:success)
end
