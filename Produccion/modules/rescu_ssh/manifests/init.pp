class rescu_ssh {
include acceso_uxxi::service
file_line { 'RSA-ssh-login':
        after            => '# Authentication',
        path             => '/etc/ssh/sshd_config',
        #line             => 'PermitRootLogin prohibit-password',
        #match            => '^PermitRootLogin',
        line             => '#PermitRootLogin',
        match            => '^PermitRootLogin',
        replace    => true,
        notify          => Service[sshd],
    }

exec { 'cp':
  #path    => '',
  command => '/usr/bin/cp -r /etc/ssh/sshd_config /etc/ssh/sshd_config-or',
}


file { '/etc/ssh/sshd_config':
      ensure  => file,
      backup  => false,
      content => template('/etc/puppetlabs/code/environments/CONF/resc-ssh/sshd'),
      notify          => Service[sshd],
    }


}
