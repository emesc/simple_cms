Rails.application.routes.draw do

  # get 'demo/index'
  root 'demo#index'
  
  # last route that it tries
  # let's put this at the very bottom
  # not a good practice anymore to use this
  match ":controller(/:action(/:id))", via: [:get, :post]

  # MATCH ROUTE
  # get "demo/index" is a short form to:
  ### match "demo/index",
  ###    to: "demo#index"
  ###   via: :get

  # DEFAULT ROUTE
  # not best practice anymore
  # :controller/:action/:id
  # eg, GET /students/edit/52
  # go to the students controller, edit action, student id 52 
  # the way to write this is:
  ### match ':controller(/:action(/:id))',
  ###   via: :get
  # all in parenthesis are optional, default action is index
  # or write as
  # eg, you want to ask for a format of json
  ### match: ":controller(/:action(/:id(/:format)))",
  ###    via: :get

  # ROOT ROUTE
  # no match in the root route
  ### root to: "demo#index"
  # shortcut
  ### root "demo#index"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
