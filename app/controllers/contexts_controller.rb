class ContextsController < ApplicationController

  layout 'admin'
  
  def index
    @contexts = Context.page(params[:page])
    render action: 'index', layout: false if request.xhr?
  end

  def new
    @context = Context.new
    @types = Type.find(:all)
  end

  def create
    @context = Context.new(params[:context])

    if @context.save
      @context.update_correction_factors(params[:correction_factors], @context.id)

      flash[:notice] = l(:notice_successful_create)
      redirect_to action: 'index'
    else
      render action: 'new'
    end
  end

  def edit
    @context = Context.find(params[:id])
    @types = Type.find(:all)
  end

  def update
    @context = Context.find(params[:id])
    @context.update_correction_factors(params[:correction_factors], @context.id)

    if @context.update_attributes(params[:context])
      flash[:notice] = l(:notice_successful_update)
      redirect_to action: 'index'
    end
  end

  def destroy
      @context = Context.find(params[:id])
      
      @correction_factors = CorrectionFactor.where(:context_id => @context.id).all
      CorrectionFactor.destroy(@correction_factors)
      
      @context.destroy

      flash[:notice] = l(:notice_successful_delete)
      redirect_to action: 'index'
  end
   
end
