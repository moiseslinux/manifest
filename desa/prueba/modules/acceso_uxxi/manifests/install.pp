class acceso_uxxi::install {

  $client_pkg        = openssh-clients
  $client_pkg_ensure = 'present'
  $install_options   = $ssh::install_options
  $install_manage    = $ssh::install_manage
  $server_pkg        = openssh-server
  $server_pkg_ensure = 'present'

  if $ssh::service_notify {
    $service_notify = Service['sshd_service']
  } else {
    $service_notify = undef
  }

  if $install_manage {
    package { 'ssh_client_pkg':
      ensure          => $client_pkg_ensure,
      name            => $client_pkg,
      install_options => $install_options,
      notify          => $service_notify,
    }

    package { 'ssh_server_pkg':
      ensure          => $server_pkg_ensure,
      name            => $server_pkg,
      install_options => $install_options,
      notify          => $service_notify,
    }
  }
  
}
