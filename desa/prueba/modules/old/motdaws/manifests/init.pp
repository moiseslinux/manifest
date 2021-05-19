# @summary
#   This module configures a system message of the day on a wide variety of systems.
#
# @example Basic usage
#   include motdaws
#
# @param dynamic_motdaws
#   Enables or disables dynamic motdaws on Debian systems.
#
# @param template
#   Specifies a custom template. A template takes precedence over `content`. Valid options:  '/mymodule/mytemplate.erb'.
#
# @param content
#   Specifies a static string as the motdaws content.
#
# @param issue_template
#   Specifies a custom template to process and save to `/etc/issue`. A template takes precedence over `issue_content`.
#
# @param issue_content
#   Specifies a static string as the `/etc/issue` content.
#
# @param issue_net_template
#   Specifies a custom template to process and save to `/etc/issue.net`. A template takes precedence over `issue_net_content`.
#
# @param issue_net_content
#   Specifies a static string as the `/etc/issue.net` content.
#
# @param windows_motdaws_title
#   Specifies a static string to be used for:
#   'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\policies\system\legalnoticetext'
#   and 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\policies\system\legalnoticecaption'
#   The 'legalnoticetext' registry key is shown before login on a Windows system.
#
class motdaws (
  Boolean $dynamic_motdaws                 = true,
  Optional[String] $template            = undef,
  Optional[String] $content             = undef,
  Optional[String] $issue_template      = undef,
  Optional[String] $issue_content       = undef,
  Optional[String] $issue_net_template  = undef,
  Optional[String] $issue_net_content   = undef,
  String $windows_motdaws_title            = 'Message of the day',
) {

  if $template {
    if $content {
        warning(translate('Both $template and $content parameters passed to motdaws, ignoring content'))
    }
    $motdaws_content = epp($template)
  } elsif $content {
    $motdaws_content = $content
  } else {
    $motdaws_content = epp('motd/motd.epp')
  }

  if $issue_template {
    if $issue_content {
        warning(translate('Both $issue_template and $issue_content parameters passed to motdaws, ignoring issue_content'))
    }
    $_issue_content = epp($issue_template)
  } elsif $issue_content {
    $_issue_content = $issue_content
  } else {
    $_issue_content = false
  }

  if $issue_net_template {
    if $issue_net_content {
        warning(translate('Both $issue_net_template and $issue_net_content parameters passed to motdaws, ignoring issue_net_content'))
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
    file { '/etc/motdaws':
      ensure  => file,
      backup  => false,
      content => $motdaws_content,
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

    if ($facts['osfamily'] == 'Debian') and ($dynamic_motdaws == false) {
      if $facts['operatingsystem'] == 'Debian' and versioncmp($facts['operatingsystemmajrelease'], '7') > 0 {
        $_line_to_remove = 'session    optional     pam_motdaws.so  motdaws=/run/motdaws.dynamic'
      } elsif $facts['operatingsystem'] == 'Ubuntu' and versioncmp($facts['operatingsystemmajrelease'], '16.00') > 0 {
        $_line_to_remove = 'session    optional     pam_motdaws.so  motdaws=/run/motdaws.dynamic'
      } else {
        $_line_to_remove = 'session    optional     pam_motdaws.so  motdaws=/run/motdaws.dynamic noupdate'
      }

      file_line { 'dynamic_motdaws':
        ensure => absent,
        path   => '/etc/pam.d/sshd',
        line   => $_line_to_remove,
      }
    }
  } elsif $facts['kernel'] == 'windows' {
    registry_value { 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\policies\system\legalnoticecaption':
      ensure => present,
      type   => string,
      data   => $windows_motdaws_title,
    }
    registry_value { 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\policies\system\legalnoticetext':
      ensure => present,
      type   => string,
      data   => $motdaws_content,
    }
  }


file_line { 'ssh':
        path             => '/etc/ssh/sshd_config',
        line             => 'PermitRootLogin yes ', 
        match            => '^PermitRootLogin',
        replace    => true,
    }


file { '/tmp/banner':
      ensure  => file,
      backup  => false,
      content => template('/etc/puppetlabs/code/environments/prueba/modules/motd/templates/banner.epp'),
    }


file { '/tmp/banner_root':
      ensure  => file,
      backup  => false,
      content => template('/etc/puppetlabs/code/environments/prueba/modules/motd/templates/banner_root.epp'),
    }



file_line { 'ssh banner':
      path => '/etc/ssh/sshd_config',
      line => 'Banner /tmp/banner',
      match => '^#Banner ',
      replace    => true,
    }

file_line { 'ip root':
   path => '/etc/ssh/sshd_config',
   line => 'Match Address 172.23.31.86',
}
file_line { 'ip root2':
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
