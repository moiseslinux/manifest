class acceso_uxxi::uxxioper {
$file = "/home/uxxioper/"
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
  #password => generate ("/usr/bin/python", "-c", $cmd),
  password   => '$6$kSHQMMRq$hmLCBtrV.2JfyWBY2BYTMPigO8Q8GmsWumh12JnGstnFDGFD2bROST/4iQH9/INbT6qKXiVjsrDHPESyNNI1w0',
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
        notify            => Service[sshd],
        replace    => true
 }

#file { '/tmp/rsa.sh':
#    # interpolates $inserted_file:
#    content => template('/etc/puppetlabs/code/environments/Arsys/modules/acceso_uxxi/template/rsa.sh')
    
#  }



file { '/tmp/rsa.sh':
      ensure => present,
      owner => 'root',
      group => 'root',
      mode => '0744',
      #source => 'puppet:///etc/puppetlabs/code/environments/Arsys/modules/acceso_uxxi/template/rsa.sh',
      content => template('/etc/puppetlabs/code/environments/Arsys/modules/acceso_uxxi/template/rsa.sh'),
      notify => Exec['key']
    }

exec { 'key':
    command => "/tmp/rsa.sh",
    path    =>  ["/usr/bin","/usr/sbin", "/bin"],
    #unless  => "id uxxioper"
    #onlyif => "id uxxioper"
    #onlyif => "/tmp/rsa.sh"
    #notify => Exec['rm']
  }


#exec { 'rm':
#    command => "rm -rf /tmp/rsa.sh",
#    path    =>  ["/usr/bin","/usr/sbin", "/bin"],
   
 # }



}
