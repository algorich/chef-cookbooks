node[:deploy].each do |application, deploy|

  default[:papertrail][:log_files] = {
    'rails' => [],
    'common' => []
  }

end

