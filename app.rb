require("sinatra")
require("sinatra/reloader")
require("sinatra/activerecord")
also_reload("lib/**/*.rb")
require("./lib/employee")
require("./lib/division")
require("./lib/project")
require("pg")
require("pry")

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

get("/projects") do
  @projects = Project.all()
  @divisions = Division.all()
  erb(:projects)
end

post("/divisions") do
  title = params.fetch("title")
  division = Division.new({:title => title, :id => nil})
  division.save()
  @divisions = Division.all()
  erb(:divisions)
end


get("/employee/:id") do
  @employee = Employee.find(params.fetch("id").to_i())
  @assigned_projects = @employee.projects
  @projects = Project.all
  erb(:employeeinfo)
end

get("/division/:id") do
  @division = Division.find(params.fetch("id").to_i())
  @employees = @division.employees()
  erb(:divisioninfo)
end

post("/employees") do
  name = params.fetch("name")
  employee = Employee.new({:name => name, :id => nil})
  employee.save()
  @employees = Employee.all
  erb(:employees)
end

post("/employee/:id/project") do
  employee_id = params.fetch("id")
  project_id = params.fetch("project_id")
  current_employee = Employee.find(employee_id)
  new_project = Project.find(project_id)
  current_employee.projects.push(new_project)
  @employees = Employee.all
  @assigned_projects = current_employee.projects
  @projects = Project.all
  @employee = Employee.find(params.fetch("id").to_i())
  erb(:employeeinfo)
end

post("/division/:id/employee") do
  @division = Division.find(params.fetch("id").to_i())
  @division_id = @division.id
  name = params.fetch("name")
  employee = Employee.find_by({:name => name})
  employee.update({:division_id => @division_id})
  @employees = @division.employees()
  erb(:divisioninfo)
end

post("/projects") do
  @divisions = Division.all()
  project = Project.new({:project_name => params.fetch("project_name"), :id => nil, :description => params.fetch("description"), :due_date => params.fetch("due_date")})
  if !project.save()
    @error_message = "Please add a description and name for the project that is less than 50 characters long."
  end
  @projects = Project.all()
  erb(:projects)
end

get("/project/:id") do
  id = params.fetch('id')
  @project = Project.find(id)
  @assigned_employees = @project.employees()
  @employees = Employee.all()
  erb(:projectinfo)
end

post("/project/:id") do
  id = params.fetch('id')
  @project = Project.find(id)
  @new_employee = Employee.find(params['employee_id'])
  @project.employees.push(@new_employee)
  @assigned_employees = @project.employees()
  @employees = Employee.all()
  erb(:projectinfo)
end

patch("/employee/:id") do
  name = params.fetch("name")
  @employee = Employee.find(params.fetch("id").to_i())
  @employee.update({:name => name})
  @assigned_projects = @employee.projects
  @projects = Project.all
  erb(:employeeinfo)
end

patch("/division/:id") do
  title = params.fetch("title")
  @division = Division.find(params.fetch("id").to_i())
  @division.update({:title => title})
  @employees = @division.employees()
  erb(:divisioninfo)
end

delete("/division/:id") do
  @division = Division.find(params.fetch("id").to_i())
  @division.delete()
  @divisions = Division.all
  erb(:divisions)
end

delete("/employee/:id") do
  @employee = Employee.find(params.fetch("id").to_i())
  @employee.delete()
  @employees = Employee.all
  erb(:employees)
end

delete("/employee/:id/project") do
  project = Project.find(params['project_id'])
  @employee = Employee.find(params['id'])
  @employee.projects.destroy(project)
  @employees = Employee.all
  @assigned_projects = @employee.projects
  @projects = Project.all
  erb(:employeeinfo)
end
