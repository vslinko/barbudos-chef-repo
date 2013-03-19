include_recipe "nginx"
include_recipe "nodejs"
include_recipe "mongodb"

template "#{node["nginx"]["dir"]}/sites-available/bar-barbudos.ru" do
  source "bar-barbudos.ru.erb"
  variables :port => node["barbudos_application"]["port"]
  notifies :reload, "service[nginx]"
end

nginx_site "bar-barbudos.ru"

application "barbudos" do
  path "/var/www"
  owner "www-data"
  group "www-data"
  repository "git://github.com/rithis/barbudos.git"

  nodejs do
    entry_point "node_modules/.bin/coffee barbudos.coffee"
  end

  action File.exists?("/var/www/current") ? :deploy : :force_deploy
end
