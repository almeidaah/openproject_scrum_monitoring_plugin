#Controller Sobrescrito do Padrão Groups controller devido à necessidade de salvar a relação entre os groups x contextos
class GruposController < ApplicationController

  layout 'admin'
  before_filter :require_admin

  # GET /grupos/new
  def new
    @group = Group.new
    @contexts = Context.all
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render xml: @group }
    end
  end

  # POST /grupos
  def create
    @group = Group.new permitted_params.group

    puts permitted_params
    respond_to do |format|
      if @group.save
        
        puts @group.attributes
        @group_context = GroupContext.new
        @group_context.group_id = @group._id
        
        @context = Context.find(params[:context])
        @group_context.context = @context._id

        @group_context.save

        flash[:notice] = l(:notice_successful_create)
        format.html { redirect_to(groups_path) }
        format.xml  { render xml: @group, status: :created, location: @group }
      else
        format.html { render action: 'new' }
        format.xml  { render xml: @group.errors, status: :unprocessable_entity }
      end
    end
  end

end