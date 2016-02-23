class nginx {
 
  package { 'nginx' :
    ensure => present,
    before => [File['block'],File['config']],
  }
  
  file { 'docroot':
    ensure  => directory,
    path    => "/var/www",
  }
  
  file { 'index':
    ensure  => file,
    path    => "/var/www/index.html",
    source  => 'puppet:///modules/nginx/index.html',
    notify  => Service['nginx'],
  }
  
  file { 'config':
    ensure  => file,
    path    =>  "/etc/nginx/nginx.conf",
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  
  file { 'block':
    ensure  => file,
    path    =>  "/etc/nginx/conf.d/default.conf",
    source  => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  
  service { 'nginx':
    ensure    => running,
    enable    => true,
    require => [File['docroot'],File['index']],
    subscribe => [File['config'],File['block']],
  }
  
}
  
