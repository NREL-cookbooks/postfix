require_recipe "postfix"

execute "rebuild-transport" do
  command "postmap /etc/postfix/transport"
  action :nothing
  notifies :restart, "service[postfix]"
end

template "/etc/postfix/transport" do
  source "transport.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :run, "execute[rebuild-transport]"
end
