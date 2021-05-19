
class acceso_uxxi::moosshsudo {

include acceso_uxxi::service
include acceso_uxxi
##################### GRUPOS SUDO ###################################
# BORRAR GRUPO
  file_line { 'Grp_INT-moodle-del':
      ensure => absent,
      path => '/etc/sudoers',
      line => '%uxxi-int ALL=(ALL) NOPASSWD: /bin/su - moodle',
  }  
 

 # AGREGAR GRUPO
  file_line { 'Grp_INT-postgrep-del':
      ensure => absent,
      path => '/etc/sudoers',
      line => '%uxxi-int ALL=(ALL) NOPASSWD: /bin/su - postgres',
  }

# AGREGAR GRUPO  
  file_line { 'Grp_INT-moodle':
      ensure => present,
      path => '/etc/sudoers',
      line => '%UXXI-MO-Tecnico-Funciona ALL=(ALL) NOPASSWD: /bin/su - moodle',
  }  
 

 file_line { 'Grp_INT-postgrep':
      ensure => present,
      path => '/etc/sudoers',
      line => '%UXXI-MO-Tecnico-Funciona ALL=(ALL) NOPASSWD: /bin/su - postgres',
  }

   file_line { 'Grp_UXXI-INT-Tecnico-Funcional-moodle':
      ensure => present,
      path => '/etc/sudoers',
      line => '%UXXI-INT-Tecnico-Funcional ALL=(ALL) NOPASSWD: /bin/su - moodle',
  }  
 

 file_line { 'Grp_UXXI-INT-Tecnico-Funcional-post':
      ensure => present,
      path => '/etc/sudoers',
      line => '%UXXI-INT-Tecnico-Funcional ALL=(ALL) NOPASSWD: /bin/su - postgres',
  }
      
################# GRUPOS SSH ###########################################  
 #BORRAR GRUPO 
  file_line { 'Groups-AllowGroups-uxxi-int':
        ensure => absent,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups uxxi-int',
        replace    => true
 } 


  file_line { 'Groups-moodle':
        ensure => present,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups UXXI-MO-Tecnico-Funcional UXXI-INT-Tecnico-Funcional',
        notify          => Service[sshd],
        replace    => true
 } 
  

}

