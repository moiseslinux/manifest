
class acceso_uxxi::devsshsudo {

include acceso_uxxi::service
include acceso_uxxi
##################### GRUPOS SUDO ###################################
# BORRAR GRUPO
   
  file_line { 'Grp_Devops1-del':
      ensure => absent,
      path => '/etc/sudoers',
      line => '%dev_uxxi_acceso_ssh ALL=(ALL) NOPASSWD: /bin/su - ora12as',
  }  
      
  file_line { 'Grp_Devops-del':
      ensure => absent,
      path => '/etc/sudoers',
      line => '%dev_uxxi_acceso_ssh ALL=(ALL) NOPASSWD: /bin/su - moodle',
  }

# AGREGAR GRUPO 
   file_line { 'Grp_Devops1':
      ensure => present,
      path => '/etc/sudoers',
      line => '%devops ALL=(ALL) NOPASSWD: /bin/su - ora12as',
  }  
      
  file_line { 'Grp_Devops':
      ensure => present,
      path => '/etc/sudoers',
      line => '%devops ALL=(ALL) NOPASSWD: /bin/su - moodle',
  }


################# GRUPOS SSH ###########################################  
 #BORRAR GRUPO 
  file_line { 'Groups-dev-ssh':
        ensure => absent,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups dev_uxxi_acceso_ssh',
        replace    => true
 } 

  file_line { 'Groups-DEV-ssh':
        ensure => absent,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups DEV_UXXI_Acceso_SSH',
        replace    => true
 }



#AGREGAR GRUPO
  file_line { 'Groups-devops2':
        ensure => present,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups devops',
        notify          => Service[sshd],
        replace    => true
 } 
  

}

