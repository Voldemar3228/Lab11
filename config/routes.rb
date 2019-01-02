Rails.application.routes.draw do
  root 'laba10#input'
  get 'laba10/input'
  get 'laba10/output'
  get 'allxml' => 'laba10#allinxml'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
