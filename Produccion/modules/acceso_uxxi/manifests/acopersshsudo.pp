
class acceso_uxxi::acopersshsudo {

include acceso_uxxi::service
include acceso_uxxi
##################### GRUPOS SUDO ###################################
# BORRAR GRUPO
# file_line { 'Grp_XXX':
#      ensure => absent,
#      path => '/etc/sudoers',
#      line => '%supp ALL=(ALL) ALL'
#  }  

# AGREGAR GRUPO  
  file_line { 'Grp_UXXI-AC-Operaciones':
      ensure => present,
      path => '/etc/sudoers',
      line => '%UXXI-AC-Operaciones ALL=(ALL) NOPASSWD: ALL',
  }  
  
      
################# GRUPOS SSH ###########################################  
 #BORRAR GRUPO 
 # file_line { 'Groups-XXXXXX':
 #       ensure => absent,
 #       path             => '/etc/ssh/sshd_config',
 #       after            => 'AuthorizedKeysFile',
 #       line             => 'AllowGroups prue_sstt',
 #       replace    => true
 #} 

#AGREGAR GRUPO
  file_line { 'Groups-UXXI-Operaciones-AC':
        ensure => present,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups UXXI-AC-Operaciones',
        notify          => Service[sshd],
        replace    => true
 } 
  

}

