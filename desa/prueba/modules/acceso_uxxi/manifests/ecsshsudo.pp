
class acceso_uxxi::ecsshsudo {

include acceso_uxxi::service
include acceso_uxxi
##################### GRUPOS SUDO ###################################
# BORRAR GRUPO
 file_line { 'Grp_Economico-XXX':
      ensure => absent,
      path => '/etc/sudoers',
      line => '%uxxi-ec ALL=(ALL) NOPASSWD: /bin/su - ora12as'
  }  

# AGREGAR GRUPO  
  file_line { 'Grp_Economico_ora12as_UXXI-EC-Mantenimiento':
      ensure => present,
      path => '/etc/sudoers',
      line => '%UXXI-EC-Mantenimiento   ALL=(ALL) NOPASSWD: /bin/su - ora12as',
  }  

  file_line { 'Grp_Economico_ora12as_ UXXI-EC-Coordinador-Mantenimiento-Jefe-Tecnico':
      ensure => present,
      path => '/etc/sudoers',
      line => '%UXXI-EC-Coordinador-Mantenimiento-Jefe-Tecnico   ALL=(ALL) NOPASSWD: /bin/su - ora12as',
  }  
      
################# GRUPOS SSH ###########################################  
 #BORRAR GRUPO 
  file_line { 'Groups-Economico-xx':
        ensure => absent,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups uxxi-ec',
        replace    => true
 } 

#AGREGAR GRUPO
  file_line { 'Groups-Economico-ssh':
        ensure => present,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups UXXI-EC-Mantenimiento UXXI-EC-Coordinador-Mantenimiento-Jefe-Tecnico',
        notify          => Service[sshd],
        replace    => true
 } 
  

}

