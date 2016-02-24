define usrs::managed_user (
  $home_dir = "/home/$title",
  $group    = $title,
) {
  
  File { 
    owner => $title,
    group => $group,
    mode  => 0640,
  }
  
  group { $group:
    ensure => present,
  }
  
  user { $title:
    ensure => present,
    gid    => $group,
  }
  
  file { $home_dir:
    ensure => directory,
  }
  
  file { "$home_dir/.ssh":
    ensure => directory,
    mode   => 0700,
  }

}  
    


