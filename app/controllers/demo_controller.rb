class DemoController < ApplicationController
  
  layout 'application'
  
  def index
    # render(template: "demo/hello")

  end

  def hello
    # render 'index'
    @array = [1, 2, 3, 4, 5]
    @id = params[:id].to_i
    @page = params['page'].to_i
  end

  def other_hello
    redirect_to(action: 'index')
  end

  def text_helpers
    
  end

  def escape_output
    
  end
end
