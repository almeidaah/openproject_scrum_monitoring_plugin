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
    puts "GRUPONOVOGRUPONOVOGRUPONOVOGRUPONOVOGRUPONOVOGRUPONOVOGRUPONOVOGRUPONOVO"
    respond_to do |format|
      if @group.save
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