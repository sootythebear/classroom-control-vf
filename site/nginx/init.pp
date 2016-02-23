class nginx {
 
  package { 'nginx' :
    ensure => present,
  }
  
  file { 'docroot':
    ensure  => directory,
    path    => "/var/www",
    require => Package['nginx'],
  }
  
  file { 'index.html':
    ensure  => file,
    path    => "/var/www/index.html",
    source  => 'puppet:///modules/nginx/index.html',
  }
  
  file { 'config':
    ensure  => file,
    path    =>  "/etc/nginx/nginx.conf",
    source  => 'puppet:///modules/nginx/nginx.conf',
  }
  
  file { 'block':
    ensure  => file,
    path    =>  "/etc/nginx/conf.d/default.conf",
    source  => 'puppet:///modules/nginx/default.conf',
  }
  
  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => File['/var/www/index.html'],
  }
  
}
  
