class AddDivisionId < ActiveRecord::Migration[5.1]
  def change
    add_column(:employees, :division_id, :integer)
  end
end
