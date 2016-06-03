require 'rugged'

class Branch < ActiveRecord::Base

  unloadable

  attr_accessible :name, :counter_repository, :work_package, :diff

  belongs_to :work_package
  belongs_to :counter_repository

    def update_diff(branch_id)
        branch = Branch.find(branch_id)
        branch.diff = branch.get_diff
        branch.save!
      end

  def get_diff
    count = 0
    puts "========================================GET DIFFFFFF========================================================="
    repo = Rugged::Repository.new(counter_repository.url)
    diff = repo.diff(name, 'master')

    diff.each_patch do |patch|
      patch.hunks.each do |hunk|
        hunk.lines.each do |line|

    puts "===========================DENTRO DO CONTADOR================================"
          count = count + 1 if (line.new_lineno == -1 && !line.content.blank?)          
        end
      end
    end
    count
  end
end
