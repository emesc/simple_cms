class PublicController < ApplicationController

  layout 'public'

  before_action :setup_navigation

  def index
    # intro text
  end

  def show
    # permalink is what's made available to me by that route
    @page = Page.where(permalink: params[:permalink], visible: true).first
    if @page.nil?
      redirect_to('index')
    else
      # display the page content using show.html.erb
    end
  end

  private

    def setup_navigation
      @subjects = Subject.visible.sorted 
    end
end
