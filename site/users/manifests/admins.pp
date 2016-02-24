class users::admins {

  users::managed_user { 'robin' : 
    group => 'fundementals',
  }
  users::managed_users { 'jose' : }
  users::managed_users { 'alice' : }
  users::managed_users { 'chen' : }

}
