class instalaciones_uxxi {
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
user { 'uxxioper':
  ensure   => present,
  password => generate ("/usr/bin/python", "-c", $cmd),
  home        => '/home/uxxioper/',
  system      => true,                      #Makes sure user has uid less than 500
  managehome  => true,
}

file_line { 'User_uxxioper':
      path => '/etc/sudoers',
      line => '%uxxioper ALL=(ALL) NOPASSWD: ALL',
      ensure     => 'present',
        }  
#}


file_line { 'SSH-uxxioper':
        ensure => present,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups uxxioper',
        #notify            => Service[sshd],
        replace    => true
 }


file_line { 'ip_kuber':
   path => '/etc/ssh/sshd_config',
   line => 'Match Address 172.23.30.41,172.23.32.67,172.23.30.25',
}

file_line { 'user-uxxioper':
   path => '/etc/ssh/sshd_config',
   line =>  '    AllowUsers uxxioper',
   notify          => Service[sshd],
}
ssh_authorized_key { 'uxxioper@172.23.30.41':
  ensure => present,
  user   => 'uxxioper',
  type   => 'ssh-rsa',
  key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDdl7JY+tQZsXHeJQBPKFqJ79DoI5azxKcw+9VEfFz5ebT41B+5aUVCjQVbmSjDI9VzfZIUQztHVOmLEFyPevCzU6gS7/UpCPXMJBdGQlEi9ztGYpHg+UnMMj2e7ySJF6PtPKr19gdRuke3fsqXh9H9uv6S7d6JjDzZtaKoqAzEmQKOnF1SubNkz6XLsEZdfCI0BjJbEfebHLxEq+KGAATv8cx1K3KtTQauEWrUaOD2Avsw3x2mO41H/uDSypZmGqwEkAARr+bcYx8aXL+M+SLPfaQQ5c58EFdYBwM/BkoWp9+7LzIvI/oafVc55lXeU2y3ninJad9aiv33PySLvJDJ',
}

ssh_authorized_key { 'uxxioper@172.23.32.67':
  ensure => present,
  user   => 'uxxioper',
  type   => 'ssh-rsa',
  key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDdl7JY+tQZsXHeJQBPKFqJ79DoI5azxKcw+9VEfFz5ebT41B+5aUVCjQVbmSjDI9VzfZIUQztHVOmLEFyPevCzU6gS7/UpCPXMJBdGQlEi9ztGYpHg+UnMMj2e7ySJF6PtPKr19gdRuke3fsqXh9H9uv6S7d6JjDzZtaKoqAzEmQKOnF1SubNkz6XLsEZdfCI0BjJbEfebHLxEq+KGAATv8cx1K3KtTQauEWrUaOD2Avsw3x2mO41H/uDSypZmGqwEkAARr+bcYx8aXL+M+SLPfaQQ5c58EFdYBwM/BkoWp9+7LzIvI/oafVc55lXeU2y3ninJad9aiv33PySLvJDJ',
}
ssh_authorized_key { 'uxxioper@172.23.30.25':
  ensure => present,
  user   => 'uxxioper',
  type   => 'ssh-rsa',
  key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDdl7JY+tQZsXHeJQBPKFqJ79DoI5azxKcw+9VEfFz5ebT41B+5aUVCjQVbmSjDI9VzfZIUQztHVOmLEFyPevCzU6gS7/UpCPXMJBdGQlEi9ztGYpHg+UnMMj2e7ySJF6PtPKr19gdRuke3fsqXh9H9uv6S7d6JjDzZtaKoqAzEmQKOnF1SubNkz6XLsEZdfCI0BjJbEfebHLxEq+KGAATv8cx1K3KtTQauEWrUaOD2Avsw3x2mO41H/uDSypZmGqwEkAARr+bcYx8aXL+M+SLPfaQQ5c58EFdYBwM/BkoWp9+7LzIvI/oafVc55lXeU2y3ninJad9aiv33PySLvJDJ',
}


}
