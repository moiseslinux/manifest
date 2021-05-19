
class acceso_uxxi::colsshsudo {

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
  file_line { 'Grp_Colombia':
      ensure => present,
      path => '/etc/sudoers',
      line => '%SSTT_Acceso_SSH_Colombia ALL=(ALL) NOPASSWD: ALL',
  }  

  file_line { 'Grp_Colombia-ora12as':
      ensure => present,
      path => '/etc/sudoers',
      line => '%SSTT_Acceso_SSH_Colombia ALL=(ALL) NOPASSWD: /bin/su - ora12as',
  }
  

################# GRUPOS SSH ###########################################  
 #BORRAR GRUPO 
  file_line { 'Groups-col_am':
        ensure => absent,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups o_todos_america',
        notify          => Service[sshd],
        replace    => true
 } 

#AGREGAR GRUPO
  file_line { 'Groups-Colombia':
        ensure => present,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups SSTT_Acceso_SSH_Colombia',
        notify          => Service[sshd],
        replace    => true
 } 
  

}

