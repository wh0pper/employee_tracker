class Project < ActiveRecord::Base
  has_and_belongs_to_many(:employees)

  validates(:description, {:presence => true, :length => { :maximum => 50 }})
  validates(:project_name, {:presence => true, :length => { :maximum => 45 }})
  before_save(:normalize)

  private

  def normalize
    self.project_name = project_name.downcase.titleize
    self.description = description.downcase.capitalize
  end

end
