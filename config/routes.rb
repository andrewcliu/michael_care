Rails.application.routes.draw do
  devise_for :admins,:controllers => {
  																		:sessions => "sessions",
                                      :registrations => "registrations"
  																	}
	root 'static_pages#index'

	resources 'admins'
	resources 'events'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
