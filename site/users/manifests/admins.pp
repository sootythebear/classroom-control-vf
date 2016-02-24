class users::admins {

  users::managed_user { 'robin' : 
    group => 'fundementals',
  }
  users::managed_user { 'jose' : }
  users::managed_user { 'alice' : }
  users::managed_user { 'chen' : }

}
