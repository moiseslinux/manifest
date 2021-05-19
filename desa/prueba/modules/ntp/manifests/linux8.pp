class ntp::linux8 {
##if $operatingsystemrelease =~ /^8.*/ {
  package { chrony:
    ensure => 'installed',
    }
  file_line { 'ntp':
      ensure => present,
      match   => "^pool",
      path => '/etc/chrony.conf',
      line => 'pool es.pool.ntp.org iburst',
      multiple => 'false',
  }  
  service  {  'chronyd' : 
    ensure => 'running',
    enable  =>  true , 
  }
   }

#}chronyd

