#Controller Sobrescrito do Padrão Groups controller devido à necessidade de salvar a relação entre os groups x contextos
class GruposController < ApplicationController

  layout 'admin'
  before_filter :require_admin

  # GET /grupos/new
  def new
    @group = Group.new
    #@contexts = Context.all
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render xml: @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id], include: [:users, :memberships])
    @contexts = Context.all
  end

  # POST /grupos
  def create
    @group = Group.new permitted_params.group

    respond_to do |format|
      if @group.save

        #@group_context = GroupContext.new
        #@context = params[:context]
        #@group_context.context_id = @context[:id]

        #@group_context.group_id = @group._id

        #@group_context.save

        flash[:notice] = l(:notice_successful_create)
        format.html { redirect_to(groups_path) }
        format.xml  { render xml: @group, status: :created, location: @group }
      else
        format.html { render action: 'new' }
        format.xml  { render xml: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.xml
  def update
    @group = Group.find(params[:id], include: :users)


    respond_to do |format|
      if @group.update_attributes(permitted_params.group)

        @group_context = GroupContext.where(:group_id => @group._id)
        GroupContext.destroy(@group_context)

        @group_context = GroupContext.new
        @context = params[:context]
        @group_context.context_id = @context[:id]
        @group_context.group_id = @group._id
        @group_context.save


        flash[:notice] = l(:notice_successful_update)
        format.html { redirect_to(groups_path) }
        format.xml  { head :ok }
      else
        format.html { render action: 'edit' }
        format.xml  { render xml: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.xml
  def destroy
    @group = Group.find(params[:id], include: :users)
    @group.destroy

    @group_context = GroupContext.where(:group_id => @group._id)
    GroupContext.destroy(@group_context)

    respond_to do |format|
      format.html { redirect_to(groups_url) }
      format.xml  { head :ok }
    end
  end

end