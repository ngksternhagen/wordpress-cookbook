@test "check for testrail install" {
  export welcome=""
  wget -O - http://localhost/index.php?/setup/install | egrep "${welcome}"
}
