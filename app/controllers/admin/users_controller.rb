class Admin::UsersController < AdminController
  access_rule "admin"

  active_scaffold :user do |config|
    config.actions = :list

  end
end
