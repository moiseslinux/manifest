
class acceso_uxxi::rrhhsshsudo {

include acceso_uxxi::service
include acceso_uxxi
##################### GRUPOS SUDO ###################################
# BORRAR GRUPO
  file_line { 'Grp_Rrhh_nomina12-del':
      ensure => absent,
      path => '/etc/sudoers',
      line => '%uxxi-rrhh ALL=(ALL) NOPASSWD: /bin/su - nomina12',
  }  
  
  file_line { 'Grp_Rrhh_oracle12-del':
      ensure => absent,
      path => '/etc/sudoers',
      line => '%uxxi-rrhh ALL=(ALL) NOPASSWD: /bin/su - oracle12',
  }

  file_line { 'Grp_Rrhh_ora12as_del':
      ensure => absent,
      path => '/etc/sudoers',
      line => '%uxxi-rrhh ALL=(ALL) NOPASSWD: /bin/su - ora12as',
  }


# AGREGAR GRUPO  
  file_line { 'Grp_Rrhh_nomina12':
      ensure => present,
      path => '/etc/sudoers',
      line => '%UXXI-RRHH-Tecnico ALL=(ALL) NOPASSWD: /bin/su - nomina12',
  }  
  
  file_line { 'Grp_Rrhh_oracle12':
      ensure => present,
      path => '/etc/sudoers',
      line => '%UXXI-RRHH-Tecnico ALL=(ALL) NOPASSWD: /bin/su - oracle12',
  }

  file_line { 'Grp_Rrhh_ora12as':
      ensure => present,
      path => '/etc/sudoers',
      line => '%UXXI-RRHH-Tecnico ALL=(ALL) NOPASSWD: /bin/su - ora12as',
  }


      
################# GRUPOS SSH ###########################################  
 #BORRAR GRUPO 
  file_line { 'Groups-rrhh-del':
        ensure => absent,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups uxxi-rrhh',
        replace    => true
 } 

#AGREGAR GRUPO
  file_line { 'Groups-rrhh':
        ensure => present,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups UXXI-RRHH-Tecnico',
        notify          => Service[sshd],
        replace    => true
 } 
  

}

