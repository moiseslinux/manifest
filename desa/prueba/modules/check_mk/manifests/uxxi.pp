class { 'check_mk':
  filestore => 'https://s3-eu-west-1.amazonaws.com/ocusoft/',
  package   => 'check-mk-agent-1.4.0p21-1.noarch.rpm',
}
