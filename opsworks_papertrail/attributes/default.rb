node[:deploy].each do |application, deploy|

  default[:papertrail] = {
    'host' => 'logs.papertrailapp.com'
  }

  default[:papertrail][:log_files] = {
    'rails' => [],
    'common' => []
  }

end

