require('spec_helper')

describe(Division) do
  describe("#employees") do
    it("adds a division ID to an employee") do
      test_division = Division.create({:title => "Human Resources"})
      test_employee1 = Employee.create({:name => "John", :division_id => test_division.id})
      test_employee2 = Employee.create({:name => "Amy", :division_id => test_division.id})
     expect(test_division.employees()).to(eq([test_employee1, test_employee2]))
    end
  end
end
