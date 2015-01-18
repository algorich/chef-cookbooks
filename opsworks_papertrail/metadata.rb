name             "opsworks_papertrail"
maintainer       "Douglas"
maintainer_email "d.camata@gmail.com"
license          "MIT"
description      "Configure and send logs to papertrail."
version          "0.1"

recipe 'opsworks_papertrail::setup', 'Set up papertrail.'

depends 'deploy'
