class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table(:projects) do |t|
      t.column(:project_name, :string)
      t.column(:due_date, :string)
      t.column(:description, :string)
      t.column(:division_id, :integer)

      t.timestamps()
    end
  end
end
