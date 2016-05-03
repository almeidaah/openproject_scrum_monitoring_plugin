require 'rugged'
class CounterRepository < ActiveRecord::Base
  unloadable  
  
  attr_accessible :name, :url, :project

  belongs_to :project

  def branches
    repo = Rugged::Repository.new(url)
    repo.branches
  end

end
