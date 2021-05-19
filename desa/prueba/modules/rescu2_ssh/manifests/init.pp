class rescu2_ssh {
include acceso_uxxi::service
#file_line { 'RSA-ssh-login':
#        after            => '# Authentication',
#        path             => '/etc/ssh/sshd_config',
#        #line             => 'PermitRootLogin prohibit-password',
#        #match            => '^PermitRootLogin',
#        line             => '#PermitRootLogin',
#        match            => '^PermitRootLogin',
#        replace    => true,
#        notify          => Service[sshd],
#    }
#
#exec { 'cp':
#  path    => ['/usr/bin', '/usr/sbin', '/bin', ], 
#  command => 'cp -r /etc/ssh/sshd_config /etc/ssh/sshd_config-or',
#}
#
#
#file { '/etc/ssh/sshd_config':
#      ensure  => file,
#      backup  => false,
#      content => template('/etc/puppetlabs/code/environments/CONF/resc-ssh/sshd'),
#      notify          => Service[sshd],
#    }
$pass="password"
$shatag="\$6\$"
$cmd="import crypt, base64, os, sys; sys.stdout.write(crypt.crypt('$pass', '$shatag' + base64.b64encode(os.urandom(16))[:8]))"
user { 'etoro':
  ensure   => present,
  password => generate ("/usr/bin/python", "-c", $cmd),
}

file_line { 'Res_user':
      ensure => present,
      path => '/etc/sudoers',
      line => 'etoro ALL=(ALL) NOPASSWD: ALL',
  }


file_line { 'SSH-user':
        ensure => present,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups etoro',
        notify            => Service[smb,nmb,winbind,sshd],
        replace    => true
 }
}
