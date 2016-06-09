class GroupVersionsController < ApplicationController

  def update

    if request.put? && params[:version]

    	@version =  params[:version]

		@group_version = GroupVersion.where(:version_id => params[:id])
		
		if @group_version.first.nil? then
	        @group_version = GroupVersion.new
    	    @group_version.version_id = params[:id]
        	@group_version.context_id = params[:context_id]
        	@group_version.save
    	end

        flash[:notice] = l(:notice_successful_update)
        redirect_to edit_version_path(@version)

    end
  end

  def destroy
    @group_version = GroupVersion.where(:version_id => params[:version_id]).all
    @group_version[0].destroy
    @version = Version.find(params[:version_id])
    redirect_to edit_version_path(@version)
  end

end