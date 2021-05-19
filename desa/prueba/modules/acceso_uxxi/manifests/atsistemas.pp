class acceso_uxxi::atsistemas {

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
  file_line { 'Grp_atsistemas':
      ensure => present,
      path => '/etc/sudoers',
      line => '%ssh_at_sistemas ALL=(ALL) NOPASSWD: ALL',
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
  file_line { 'Groups-atsistemas':
        ensure => present,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups ssh_at_sistemas',
        notify          => Service[sshd],
        replace    => true
 } 
  

}

