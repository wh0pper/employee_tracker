require('spec_helper')

describe(Project) do
  describe("#employees") do
    it("adds a employee to a project") do
      test_project = Project.create({:project_name => "Build a house"})
      test_employee1 = Employee.create({:name => "John", :project_id => test_project.id})
      test_employee2 = Employee.create({:name => "Amy", :project_id => test_project.id})
      expect(test_project.employees()).to(eq([test_employee1, test_employee2]))
    end
  end
end
