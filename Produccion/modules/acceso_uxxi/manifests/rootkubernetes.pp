
class acceso_uxxi::rootkubernetes {

include acceso_uxxi::service
include acceso_uxxi
      
################# GRUPOS SSH KUBERNETES ###########################################  
file_line { 'root kubernetes':
   path     => '/etc/ssh/sshd_config',
   multiple          => true,
   #match    => '^Match Address serverforeman.uxxi.net',
   after    => '^serverforeman.uxxi.net',
   line     => 'Match Address 172.23.30.41,172.23.32.67,172.23.30.25',
   #line     => 'Match Address h16049.ocuarsys,h16067.redocu.lan,h16050.redocu.lan',
   #line     => 'serverforeman.uxxi.net,172.23.30.41,172.23.32.67,172.23.30.25',
   replace  => true,
   notify   => Service[sshd],
  }   
}
