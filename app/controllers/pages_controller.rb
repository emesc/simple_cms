class PagesController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in

  def index
    @pages = Page.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    # create a new page to be ready to show a web form
    @page = Page.new({name: "Default"})
    @subjects = Subject.order("position ASC")
    @page_count = Page.count + 1
  end

  def create
    # process that form
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = "Page successfully created."
      redirect_to(action: 'index')
    else
      @subjects = Subject.order("position ASC")
      @page_count = Page.count + 1
      render 'new'
    end
  end

  def edit
    # find it so that it can be displayed on the form for editing
    @page = Page.find(params[:id])
    @subjects = Subject.order("position ASC")
    @page_count = Page.count
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Page updated successfully."
      redirect_to(action: 'show', id: @page.id)
    else
      @subjects = Subject.order("position ASC")
      @page_count = Page.count
      render 'edit'
    end
  end

  def delete
    # find the page so that it can be displayed and ask the user if he/she's sure
    @page = Page.find(params[:id])
  end

  def destroy
    page = Page.find(params[:id]).destroy
    flash[:notice] = "Page #{page.name} destroyed successfully"
    redirect_to(action: 'index')
  end

  private

    def page_params
      params.require(:page).permit(:subject_id, :name, :permalink, :position, :visible)
    end
end
