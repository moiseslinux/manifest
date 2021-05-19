class sshkeys_uxxi {

###para cambiar passw de root
#user { 'existe_root_user' :
#    ensure     => present,
#    name       => 'xrootx',
#    comment    => 'Usuario de sistemas',
#    password   => '$6$PhZaD188$Ef5dXTdZ4DM0CBVnBGmPW8C2TniviSTocYsr/Ca92hGybPpVcy3EGI1MuU2iMw.4gQxJz2Uur9uFytv.3wlPn.',
#  }

# PARA BORRAR RSA
#  ssh_authorized_key { 'USER':
#    ensure  => absent, >>>>>>>>>>>>>>>> BORRAR
#    user    => 'root',
#    type    => 'ssh-rsa',
#    key     => 'AAAAB3NzaC:wq!uuu1yc2EAAAADAQABAAABAQC6H9McMKS9R/R9e3I9b06nDIzFjP/TKvAC+Ob7UIxWJcagogTq+ZBF2Kbzkf13RFD3tsH2fs77dfqPvf1UT8aMLMp7c7qpnrIKi0xID7f3tWnp8N/mJ+XsBoX1JRYvW+7UrA0QsRkroLYknfpxY9DLxcKC1cZUHSNRwR2GCuay0Rc4evecoO7aq5S4gAXFYKgwcb0bHeeU8IdYOS4FWkZJtTEPiMc5Aiej8x/vgQmtWVcDxungefiF91Liiq0hr43sucx3Bswr89zCGPZlyKq2Tly4ZTdc6xDlZe/Cubg4OrfeV4UVE5OXPMNWey7WULDW8kEKzlulOhXGSlmncFID',
#    name    => 'USER@MACHINE-DOMINIO',
#    #require => User ['existe_root_user']
#  }

# PARA AGREAGR RSA
#  ssh_authorized_key { 'USER':
#    ensure  => present, >>>>>>>>>>>>>>>>>>>>>>>AGREAGR
#    user    => 'root',
#    type    => 'ssh-rsa',
#    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDDl8FZnknrJlZKWkOjHI8lIvnpqm+z2GvoNTPHGpRjP5GhstY0Ko8o4ZcykMvPH9e7/AeVLd7PIV8ffLhzharSbfMJVzflgvku0oe8+DgyYE3P54Ifw6d84lQge0OnxnDGIS8MHih4f/Ouu/WKKlTqa5eL1j/gXM+pD5p+30Tc2GuVGXcqUaoYyWSdsHzwlm2fYj4Tt0Izpd56Z+oEa43lgprsxhQBoULWcwX21EOgDSR/L9/yCM9Trydg8dRVHCSFNxmRBrryKctsEh6bWagWusIvc25FlcVqCZW5y4IhFdWBXZOxm2ZESdziOAEcXZXYKYrHFxcIiIfBhlenPG1x',
#    name    => 'USER@MACHINE-DOMINIO',
#    #require => User ['existe_root_user']
#  }



ssh_authorized_key { 'ROOT-FOREMAN':
    ensure  => present,
    user    => 'root',
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDGF6+t0HTnWc2iLQsBWPU0NMlCbBHEWSmyjTqZrMQgRvR4hdXGiPrNzv6ChO9GiiNqjQN1R7kprXk5PEPTWNTbE6JoYXx0bGXwMFyAYSlVh5fBSXo8kceE/+7wo5rFyZ/CsnIFRdApnEgwplvIVqWWgMUxMZqEfExW8bA3LcKXZB0Obp1JqVhQjvqcdJGKU8UEdgt5q2S11bV3Ffn7HD3sgCfwEBZfSPsQ5EeENol5L+zl3LV6elsNxxkYM6O5vNkkplaMJ0/mVatOg601wm+awPnuTUmmte8diBAkYE7h2KF/z2guBJbepkaCb2RueC540nH7SEieVCwwB5mN5F1F',
    name    => 'root@serverforeman.uxxi.net',
    #require => User ['existe_root_user']
  }


# Gestión de claves públicas de PROXY FOREMAN
  ssh_authorized_key { 'ROOT-PROXY-FOREMAN':
    ensure  => present,
    user    => 'root',
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDkkHCxr7zJ6AJctsPr+Z86BDvPtR7RVNe0ZLNlJZ7ukOSy3IAx5ZmktgkR0qD+TRRj4s7ujK209uxeYqPS4GnDPPHF6UWAJHLWioUjidnZoFAw2WBDgy7NqyOU3HD18l+PVrk+YwzcemXz7ug3aMkfTLSlmM2y3CoHm103aHc+M+BdQXwrpBpqhbMp0Ey0Ypr7A7S7LNBor1xk9X8c9QujIuZx+d1dg2Ey2P2uUmFNdcxmWTtVwpTq/uUxL88YU031l7GhsHVlzYqBBh7dSq71N5US999QLlPiijWoIBn44dbn4viuDljDFWop6a7bTaU/0YH1WwAdRIcqrVoJAooT',
    name    => 'foreman-proxy@serverforeman.uxxi.net',
    #require => User ['existe_root_user']
  }


}
