require('spec_helper')

describe(Project) do
  describe("#employees") do
    it("adds a employee to a project") do
      test_project = Project.create({:project_name => "Build a house", :description => "A really big project"})
      test_employee1 = Employee.create({:name => "John", :project_ids => [test_project.id()]})
      test_employee2 = Employee.create({:name => "Amy", :project_ids => [test_project.id()]})
      expect(test_project.employees()).to(eq([test_employee1, test_employee2]))
    end
  end


  it("validates presence of description") do
   project = Project.new({:project_name => "a project", :description => "a big project"})
   expect(project.save()).to(eq(true))
 end

 it("validates presence of project name") do
  project = Project.new({:project_name => "", :description => "a big project"})
  expect(project.save()).to(eq(false))
end

end
