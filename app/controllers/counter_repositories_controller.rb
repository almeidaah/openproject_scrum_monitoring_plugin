class CounterRepositoriesController < ApplicationController

  def create
    @counter_repository = CounterRepository.new
    @counter_repository.project_id = params[:project_id]
    @counter_repository.name = params[:name]
    @counter_repository.url = params[:url]

    @counter_repository.save!
    flash[:notice] = l(:notice_successful_create)

    @project = Project.find(params[:project_id])
    redirect_to :controller => 'projects/' << @project.identifier.downcase.tr(' ', '_'), :action => 'settings', :tab => 'repository'

  end

  def destroy
     @counter_repository = CounterRepository.find(params[:id])
     @counter_repository.destroy

     @project = Project.find(@counter_repository.project_id)
     flash[:notice] = l(:notice_successful_delete)
     redirect_to :controller => 'projects/' << @project.identifier.downcase.tr(' ', '_'), :action => 'settings', :tab => 'repository'
  end

end
