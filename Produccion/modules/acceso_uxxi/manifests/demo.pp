
class acceso_uxxi::encusshsudo {

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
  file_line { 'Grp_Encuesta':
      ensure => present,
      path => '/etc/sudoers',
      line => '%o_uxxi-ac_encuestas ALL=(ALL) NOPASSWD: su - ora12as',
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
  file_line { 'Groups-encuestas':
        ensure => present,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups o_uxxi-ac_encuestas',
        notify          => Service[sshd],
        replace    => true
 } 
  

}

