action :create do
  config = {
    "uchiwa" => node["uchiwa"]["settings"],
    "sensu" => node["uchiwa"]["datacenters"]
  }

  template "#{node['uchiwa']['sensu_homedir']}/uchiwa.json" do
    user node["uchiwa"]["owner"]
    group node["uchiwa"]["group"]
    mode 0640
    notifies :restart, "service[uchiwa]" if node["uchiwa"]["manage_service"]
    variables(:config => JSON.pretty_generate(config))
  end
end
