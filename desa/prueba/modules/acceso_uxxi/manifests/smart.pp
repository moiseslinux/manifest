class acceso_uxxi::smart (
$sudogrp = '',
$sshgrp = '',
) {
######## AGREGAR GRUPO SUDO ###############################
file_line { 'Grp_sstt':
      ensure => present,
      match   => "%$users ALL=(ALL) ALL",
      multiple => 'true',
      path => '/etc/sudoers',
      line => "%$sudogrp ALL=(ALL) ALL",
      
  }  

############## AGRGAR GRUPO SSH ################################

file_line { 'Groups-AD':
        path             => '/etc/ssh/sshd_config',
        match            => 'AllowGroups',
        after            => 'AuthorizedKeysFile',
        line             => "AllowGroups $sshgrp",
        replace    => true,
 } 

}