log_level                :info
log_location             STDOUT
node_name                'nadarashwin'
client_key               '~/chef-repo/.chef/nadarashwin.pem'
validation_client_name   'test_phase-validator'
validation_key           '~/chef-repo/.chef/test_phase.pem'
chef_server_url          'https://chefserver/organizations/test_phase'
syntax_check_cache_path  '~/chef-repo/.chef/syntax_check_cache'
cookbook_path [ '~/chef-repo/cookbooks' ]

