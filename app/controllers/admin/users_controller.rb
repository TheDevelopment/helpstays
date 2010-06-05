class Admin::UsersController < AdminController
  access_rule "admin"

  active_scaffold :user do |config|
    #config.actions = :list
    config.columns  = [:name, :login, :phone_number, :organisations, :houses]

  end
end
