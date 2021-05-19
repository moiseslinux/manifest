
class acceso_uxxi::invtecsshsudo {

include acceso_uxxi::service
include acceso_uxxi
##################### GRUPOS SUDO ###################################
# BORRAR GRUPO
 file_line { 'Grp_Inv-ora12as-del':
      ensure => absent,
      path => '/etc/sudoers',
      line => '%uxxi-inv-tecnico ALL=(ALL) NOPASSWD: /bin/su - ora12as',
  }  

  file_line { 'Grp_Inv-postgrep-del':
      ensure => absent,
      path => '/etc/sudoers',
      line => '%o_uxxi ALL=(ALL) NOPASSWD: /bin/su - ora12as',
  }

# AGREGAR GRUPO  
  file_line { 'Grp_UXXI-INV-Tecnico-ora12as':
      ensure => present,
      path => '/etc/sudoers',
      line => '%UXXI-INV-Tecnico ALL=(ALL) NOPASSWD: /bin/su - ora12as',
  }  

  file_line { 'Grp_Inv-postgrep':
      ensure => present,
      path => '/etc/sudoers',
      line => '%UXXI-INV-Tecnico ALL=(ALL) NOPASSWD: /bin/su - ora12as',
  }

      
################# GRUPOS SSH ###########################################  
 #BORRAR GRUPO 
  file_line { 'Groups-XXXXXX':
        ensure => absent,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups uxxi-inv-tecnico',
        replace    => true
 } 

#AGREGAR GRUPO
  file_line { 'Groups-inv':
        ensure => present,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups UXXI-INV-Tecnico',
        notify          => Service[sshd],
        replace    => true
 } 
  

}

