
class acceso_uxxi::gfijde {

include acceso_uxxi::service
include acceso_uxxi
#$services = [ smb, nmb, winbind, sshd ]
##################### GRUPOS SUDO ###################################
# BORRAR GRUPO
 file_line { 'Grp_gfi_jde-del':
      ensure => absent,
      path => '/etc/sudoers',
      line => '%gfi_jde ALL=(ALL) NOPASSWD: ALL'
  }  

# AGREGAR GRUPO  
  file_line { 'Grp_gfi_jde':
      ensure => present,
      path => '/etc/sudoers',
      line => '%ssh_gfi_jde ALL=(ALL) NOPASSWD: ALL',
  } 
  
 
      
################# GRUPOS SSH ###########################################  
 #BORRAR GRUPO 
  file_line { 'Groups-gfi_jde-delssh':
        ensure => absent,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups gfi_jde',
        replace    => true
 } 

#AGREGAR GRUPO
  file_line { 'Groups-gfi_jde':
        ensure => present,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups ssh_gfi_jde',
        notify           => Service[sshd],
        replace          => true
 } 
  

}

