load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "/usr/bin/entrypoint.sh returns 0" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"pwd && whoami\""
  # this is printed on test failure
  echo "output: $output"
  assert_output --partial "dojo init finished"
  assert_output --partial "dotnet-dojo"
  refute_output --partial "root"
  assert_equal "$status" 0
}

@test "can git clone using ssh dotnet-example from github" {
  # always git clone the master branch which is expected to have passing tests
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"rm -rf dotnet-example &&\
    git clone git@github.com:ai-traders/dotnet-example.git\""
  assert_output --partial "Cloning into 'dotnet-example'..."
  assert_equal "$status" 0
}

# checkout such git ref of dotnet/dotnet-docker that does not use .NET core 2.2
@test "can git clone using https from github" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"rm -rf dotnet-docker-samples &&\
    git clone https://github.com/dotnet/dotnet-docker/ dotnet-docker-samples &&\
    cd dotnet-docker-samples &&\
    git checkout 08ba4044b109ac06134a8a1232605add8aa41d71\""
  assert_output --partial "Cloning into 'dotnet-docker-samples'..."
  assert_equal "$status" 0
}

@test "/run/user/<uid> is created" {
  host_user_id=$(stat -c %u .)
  # usually the directory will be" /run/user/1000
  run /bin/bash -c "dojo -c=Dojofile.to_be_tested \"stat -c %U /run/user/${host_user_id}\""
  # this is printed on test failure
  echo "output: $output"
  assert_output --partial "dojo"
  refute_output --partial "No such file or directory"
  refute_output --partial "root"
  assert_equal "$status" 0
}
