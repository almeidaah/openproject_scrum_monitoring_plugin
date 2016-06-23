class BranchesController < ApplicationController

  def new
    @version = Version.find(params[:version_id])
    @repositories = CounterRepository.where(:project_id => params[:project_id]).all
  end

  def create
    @version = Version.find(params[:version])

    @branches = Array.new
    params[:branch][:branch_ids].each do |val|
      branch_name = val.split(',')[0][1]
      if Branch.where(:version_id => @version.id, :name => branch_name).first.nil?
        repository_id = val.split(',')[0][0]
        repository = CounterRepository.find(repository_id)

        branch = Branch.new
        branch.name = branch_name.split(',')[1]
        branch.counter_repository = repository
        branch.version_id = @version.id

        branch.save!
        @branches << branch
      end
    end
    redirect_to edit_version_path(@version)

  end

  def destroy
    @version = Version.find(params[:version_id])
    @branch = Branch.find(params[:branch_id])
    @branch.destroy
    redirect_to edit_version_path(@version)
  end

end
