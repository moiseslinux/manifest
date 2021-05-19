class iptables { 
}
 

class iptables::install {
 if $facts['os']['name'] in ['RedHat','CentOS','OracleLinux'] {
      if $facts['os']['release']['major'] > '6'{
package { 'iptables-services':
  ensure => present,
    }
  }  
}
if $facts['os']['name'] in ['Ubuntu','Debian'] {
#      if $facts['os']['release']['major'] > '6'{
package { 'iptables':
  ensure => present,
   }
  }
} 

class iptables::service {
 if $facts['os']['name'] in ['RedHat','CentOS','OracleLinux'] {
  service { 'iptables':
    ensure => running,
    enable => true,
  }
}

if $facts['os']['name'] in ['Ubuntu','Debian'] {
  service { 'iptables':
    ensure => running,
    enable => true,
  }
}

}


