include_recipe "nginx"
include_recipe "nodejs"
include_recipe "mongodb"

template "#{node["nginx"]["dir"]}/sites-available/bar-barbudos.ru" do
  source "bar-barbudos.ru.erb"
  variables :port => node["barbudos_application"]["port"]
  notifies :reload, "service[nginx]"
end

nginx_site "bar-barbudos.ru"

application_settings = data_bag_item("barbudos", "application")

application "barbudos" do
  path "/var/www"
  owner "www-data"
  group "www-data"
  repository "git://github.com/rithis/barbudos.git"
  symlinks "config.json" => "config.json"

  before_symlink do
    template "/var/www/shared/config.json" do
      group "www-data"
      owner "www-data"
      source "config.json.erb"
      variables(
        :email_service => application_settings["email_service"],
        :email_user => application_settings["email_user"],
        :email_password => application_settings["email_password"],
        :sms24x7_username => application_settings["sms24x7_username"],
        :sms24x7_password => application_settings["sms24x7_password"],
        :sms24x7_callback => application_settings["sms24x7_callback"],
        :notification_email => application_settings["notification_email"],
        :notification_phones => application_settings["notification_phones"]
      )
    end
  end

  nodejs do
    entry_point "node_modules/.bin/coffee barbudos.coffee 2>&1 1>/var/www/shared/log"
  end

  action File.exists?("/var/www/current") ? :deploy : :force_deploy
end
