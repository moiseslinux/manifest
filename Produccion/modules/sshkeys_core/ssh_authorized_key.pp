ssh_authorized_key { 'nick@magpie.example.com':
  ensure => present,
  user   => 'nick',
  type   => 'ssh-rsa',
  key    => 'AAAAB3Nza[...]qXfdaQ==',
}
