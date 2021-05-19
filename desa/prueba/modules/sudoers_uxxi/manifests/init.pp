
class sudoers_uxxi {
 $group = "/etc/puppetlabs/code/environments/prueba/modules/sudoers_uxxi/template/devops.erb"
 file_line { 'rule':
      ensure => present,
      multiple => 'false',
      path => '/etc/sudoers',
      line => '##GRUPOS_UXXI',
            
  }  

 file_line { 'Grp_devops':
      ensure => absent,
      match   => "^GRUPOS_UXXI",
      multiple => 'false',
      path => '/etc/sudoers',
      line => '%supp ALL=(ALL) ALL',
      #line => template ('/etc/puppetlabs/code/environments/prueba/modules/sudoers_uxxi/template/devops.erb'), 
  }  
  file_line { 'Grp_sstt':
      ensure => present,
      match   => "^GRUPOS_UXXI",
      multiple => 'false',
      path => '/etc/sudoers',
      line => '%sstt ALL=(ALL) ALL'
  }  

}
