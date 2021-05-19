
class acceso_uxxi {

 package { "openssh.x86_64":
    ensure => latest,
  }

file {'/etc/sudoers':
  path => '/etc/sudoers',
  backup => 'true'
} 
 
include acceso_uxxi::service
##################### GRUPOS SUDO ###################################
# BORRAR GRUPO
 file_line { 'Grp_sstt-del':
      ensure => absent,
      path => '/etc/sudoers',
      line => '%sstt ALL=(ALL) NOPASSWD: ALL',
  }  

# AGREGAR GRUPO  
  file_line { 'Grp_SSTT-Act.Tecnologica':
      ensure => present,
      path => '/etc/sudoers',
      line => '%SSTT-Act.Tecnologica ALL=(ALL) NOPASSWD: ALL',
  }  

  file_line { 'Grp_SSTT-Admin-Firewalls':
      ensure => present,
      path => '/etc/sudoers',
      line => '%SSTT-Admin-Firewalls ALL=(ALL) NOPASSWD: ALL',
  }

  file_line { 'Grp_SSTT-Implantaciones ':
      ensure => present,
      path => '/etc/sudoers',
      line => '%SSTT-Implantaciones  ALL=(ALL) NOPASSWD: ALL',
  }

  file_line { 'Grp_SSTT-Infraestructura ':
      ensure => present,
      path => '/etc/sudoers',
      line => '%SSTT-Infraestructura  ALL=(ALL) NOPASSWD: ALL',
  }
  
  file_line { 'Grp_SSTT-OPS':
      ensure => present,
      path => '/etc/sudoers',
      line => '%SSTT-OPS  ALL=(ALL) NOPASSWD: ALL',
  }
   
  file_line { 'Grp_ SSTT-UXXI':
      ensure => present,
      path => '/etc/sudoers',
      line => '%SSTT-UXXI  ALL=(ALL) NOPASSWD: ALL',
  }

  file_line { 'Grp_SSTT-Soporte':
      ensure => present,
      path => '/etc/sudoers',
      line => '%SSTT-Soporte  ALL=(ALL) NOPASSWD: ALL',
  }

      
################# GRUPOS SSH ###########################################  
 #BORRAR GRUPO 
  file_line { 'Groups-prueb':
        ensure => absent,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups root sstt',
        replace    => true
 } 

#AGREGAR GRUPO
  file_line { 'Groups-sstt':
        ensure => present,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups SSTT-Act.Tecnologica SSTT-Admin-Firewalls SSTT-Implantaciones SSTT-Infraestructura SSTT-OPS SSTT-UXXI SSTT-Soporte',
        notify            => Service[sshd],
        replace    => true
 } 


}
