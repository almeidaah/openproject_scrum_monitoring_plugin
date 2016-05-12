class BranchesController < ApplicationController

  def new
    @work_package = WorkPackage.find(params[:work_package_id])
    @repositories = CounterRepository.where(:project_id => @work_package.project_id).all
  end

  def create
    @work_package = WorkPackage.find(params[:work_package])
    @branches = Array.new
    params[:branch][:branch_ids].each do |val|
      branch_name = val.split(',')[0][1]
      if Branch.where(:work_package_id => @work_package.id, :name => branch_name).first.nil?
        repository_id = val.split(',')[0][0]
        repository = CounterRepository.find(repository_id)
        branch = Branch.new
        #substring para ignorar o repotitory_id, adicionado por causa do radiobutton em tela
        branch.name = branch_name[2..branch_name.length]
        branch.counter_repository = repository
        branch.work_package = @work_package
        branch.save!
        @branches << branch
      end
    end
    redirect_to work_package_path(@work_package)

  end

  def destroy
    @work_package = WorkPackage.find(params[:work_package_id])
    branch = Branch.find(params[:branch_id])
    branch.destroy
    redirect_to work_package_path(@work_package)
  end

end
