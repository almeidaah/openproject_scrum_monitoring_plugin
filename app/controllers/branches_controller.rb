class BranchesController < ApplicationController

  def new
    @work_package = WorkPackage.find(params[:work_package_id])
    @repositories = CounterRepository.where(:project_id => @work_package.project_id).all
  end

  def append
    @work_package = WorkPackage.find(params[:work_package_id])
    @branches = []

    params[:branch][:branch_ids].each do |val|
      branch_name = val.split(',')[1]
      if Branch.where(:work_package_id => @work_package.id, :name => branch_name).first.nil?
        repository_id = val.split(',')[0]
        repository = CounterRepository.find(repository_id)
        branch = Branch.new
        branch.name = branch_name
        branch.counter_repository = repository
        branch.work_package = @work_package
        branch.save!
        @branches << branch
      end
    end

  end

  def destroy
    @work_package = WorkPackage.find(params[:work_package_id])
    branch = Branch.find(params[:branch_id])
    branch.destroy
  end

end
