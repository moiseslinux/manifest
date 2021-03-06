#
class motd_arsys (
  Boolean $dynamic_motdbanner                 = true,
  Optional[String] $template            = undef,
  Optional[String] $content             = undef,
  Optional[String] $issue_template      = undef,
  Optional[String] $issue_content       = undef,
  Optional[String] $issue_net_template  = undef,
  Optional[String] $issue_net_content   = undef,
  String $windows_motdbanner_title            = 'Message of the day',
) {

  if $template {
    if $content {
        warning(translate('Both $template and $content parameters passed to motdbanner, ignoring content'))
    }
    $motdbanner_content = epp($template)
  } elsif $content {
    $motdbanner_content = $content
  } else {
    $motdbanner_content = epp('motd_uxxi/motd.epp')
  }

  if $issue_template {
    if $issue_content {
        warning(translate('Both $issue_template and $issue_content parameters passed to motdbanner, ignoring issue_content'))
    }
    $_issue_content = epp($issue_template)
  } elsif $issue_content {
    $_issue_content = $issue_content
  } else {
    $_issue_content = false
  }

  if $issue_net_template {
    if $issue_net_content {
        warning(translate('Both $issue_net_template and $issue_net_content parameters passed to motdbanner, ignoring issue_net_content'))
    }
    $_issue_net_content = epp($issue_net_template)
  } elsif $issue_net_content {
    $_issue_net_content = $issue_net_content
  } else {
    $_issue_net_content = false
  }

  $owner = $facts['kernel'] ? {
    'AIX'   => 'bin',
    default => 'root',
  }

  $group = $facts['kernel'] ? {
    'AIX'   => 'bin',
    'FreeBSD' => 'wheel',
    default => 'root',
  }

  $mode = $facts['kernel'] ? {
    default => '0644',
  }

  File {
    owner => $owner,
    group => $group,
    mode  => $mode,
  }

  if $facts['kernel'] in ['Linux', 'SunOS', 'FreeBSD', 'AIX']  {
    file { '/etc/motdbanner':
      ensure  => file,
      backup  => false,
      content => $motdbanner_content,
    }

    if $facts['kernel'] != 'FreeBSD' {
      if $_issue_content {
        file { '/etc/issue':
          ensure  => file,
          backup  => false,
          content => $_issue_content,
        }
      }

      if $_issue_net_content {
        file { '/etc/issue.net':
          ensure  => file,
          backup  => false,
          content => $_issue_net_content,
        }
      }
    }

    if ($facts['osfamily'] == 'Debian') and ($dynamic_motdbanner == false) {
      if $facts['operatingsystem'] == 'Debian' and versioncmp($facts['operatingsystemmajrelease'], '7') > 0 {
        $_line_to_remove = 'session    optional     pam_motdbanner.so  motdbanner=/run/motdbanner.dynamic'
      } elsif $facts['operatingsystem'] == 'Ubuntu' and versioncmp($facts['operatingsystemmajrelease'], '16.00') > 0 {
        $_line_to_remove = 'session    optional     pam_motdbanner.so  motdbanner=/run/motdbanner.dynamic'
      } else {
        $_line_to_remove = 'session    optional     pam_motdbanner.so  motdbanner=/run/motdbanner.dynamic noupdate'
      }

      file_line { 'dynamic_motdbanner':
        ensure => absent,
        path   => '/etc/pam.d/sshd',
        line   => $_line_to_remove,
      }
    }
  } elsif $facts['kernel'] == 'windows' {
    registry_value { 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\policies\system\legalnoticecaption':
      ensure => present,
      type   => string,
      data   => $windows_motdbanner_title,
    }
    registry_value { 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\policies\system\legalnoticetext':
      ensure => present,
      type   => string,
      data   => $motdbanner_content,
    }
  }

file_line { 'RSA-ssh-login':
        after            => '# Authentication',
        path             => '/etc/ssh/sshd_config',
        line             => 'PermitRootLogin prohibit-password',
        match            => '^PermitRootLogin',
        replace    => true,
    }

file_line { 'KerberosAuthentication':
        
        path             => '/etc/ssh/sshd_config',
        line             => 'KerberosAuthentication yes',
        match            => '#KerberosAuthentication',
        replace    => true,
    }

# Se decide crear una clase aparte para lo que es group ssh y sudo
#file_line { 'Groups-AD':
#        path             => '/etc/ssh/sshd_config',
#        after            => 'AuthorizedKeysFile',
#        line             => 'AllowGroups uxxi root pruebas_ssh',
#        replace    => true,
#    }

file { '/tmp/banner':
      ensure  => file,
      backup  => false,
      content => template('/etc/puppetlabs/code/environments/CONF/banner/banner.epp'),
    }

file { '/tmp/banner_root':
      ensure  => file,
      backup  => false,
      content => template('/etc/puppetlabs/code/environments/CONF/banner/banner_root.epp'),
    }



file_line { 'ssh banner':
      path => '/etc/ssh/sshd_config',
      line => 'Banner /tmp/banner',
      match => '^#Banner ',
      replace    => true,
    }

#service { 'sshd':
#    ensure  => 'stopped',
#  }

file_line { 'ip root':
   #ensure => absent,
   path => '/etc/ssh/sshd_config',
   line => 'Match Address serverforeman.uxxi.net,172.23.30.41,172.23.32.67,172.23.30.25',
   match => '^Match Address 172.23.31.86',
}

file_line { 'ip root2':
   #ensure => absent,
   path => '/etc/ssh/sshd_config',
   line => '   PermitRootLogin yes',
}

file_line { 'root user block':
   path => '/etc/ssh/sshd_config',
   line => 'Match User root',
}
file_line { 'user root':
   path => '/etc/ssh/sshd_config',
   line => '   Banner /tmp/banner_root',
}

      
}
