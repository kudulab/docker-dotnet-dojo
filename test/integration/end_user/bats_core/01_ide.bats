load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "/usr/bin/entrypoint.sh returns 0" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"pwd && whoami\""
  # this is printed on test failure
  echo "output: $output"
  assert_output --partial "ide init finished"
  assert_output --partial "dotnet-ide"
  refute_output --partial "root"
  assert_equal "$status" 0
}

@test "can git clone using ssh dotnet-example from github" {
  # always git clone the master branch which is expected to have passing tests
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"rm -rf dotnet-example &&\
    git clone git@github.com:ai-traders/dotnet-example.git\""
  assert_output --partial "Cloning into 'dotnet-example'..."
  assert_equal "$status" 0
}

@test "can git clone using https from github" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"rm -rf dotnet-docker-samples &&\
    git clone https://github.com/dotnet/dotnet-docker/ dotnet-docker-samples\""
  assert_output --partial "Cloning into 'dotnet-docker-samples'..."
  assert_equal "$status" 0
}
