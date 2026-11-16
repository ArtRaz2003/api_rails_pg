Rails.application.routes.draw do
  scope module: "api" do
    namespace :v1 do
      resources :jobs do
        resources :applies
      end
      resources :companies do
        match "mark_deleted", to: "companies#mark_deleted", via: :put
        resources :jobs
      end
      resources :geeks do
        resources :applies
      end
      resources :applies

      match "/:id/mark_deleted", to: "companies#mark_deleted", via: :put
    end
  end

  match "*path", to: "application#catch_404", via: :all
end