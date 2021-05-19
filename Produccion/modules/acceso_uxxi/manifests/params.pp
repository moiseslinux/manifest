class acceso_uxxi::params {

  case $::osfamily {
    'RedHat': {
      $client_pkg   = 'openssh-clients'
      $server_pkg   = 'openssh-server'
      $service_name = 'sshd'
    }

    'Debian': {
      $client_pkg   = 'openssh-client'
      $server_pkg   = 'openssh-server'
      $service_name = 'sshd'
    }

    default: {
      fail("OS Family $::osfamily is not supported.")
    }
  }
  
}