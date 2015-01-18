include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  Chef::Log.info("[Start] Adding configuration to system log (rsyslog)")
  port = node[:papertrail][:port]

  Chef::Log.info("Adding config file to /etc/rsyslog.d ...")
  template "/etc/rsyslog.d/01-papertrail.conf" do
    source "01-papertrail.conf.erb"
    mode "0644"
    owner "root"
    group "root"
    variables({
      :port => port
    })
  end


  Chef::Log.info("Restarting rsyslog ...")
  execute "service rsyslog restart" do
    user "root"
    action :run
  end


  Chef::Log.info("Installing remote_syslog ...")
  gem_package 'remote_syslog'


  Chef::Log.info("Adding file to auto-start remote_syslog at boot ...")
  template "/etc/init.d/remote_syslog" do
    source "remote_syslog.sh.erb"
    mode "0755"
    owner "root"
    group "root"
  end


  Chef::Log.info("Adding configuration to remote_syslog ...")
  template "/etc/log_files.yml" do
    source "log_files.yml.erb"
    mode "0644"
    owner "root"
    group "root"
    variables({
      :app_src => node[:app_src],
      :port => port,
      :deploy => deploy
    })
  end


  Chef::Log.info("Starting remote_syslog ...")
  execute "service remote_syslog restart" do
    user "root"
    action :run
  end
end
