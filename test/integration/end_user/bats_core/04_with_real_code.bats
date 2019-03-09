load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "dotnet core sample project is runnable" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"cd dotnet-docker-samples/samples/dotnetapp/dotnetapp && dotnet build && dotnet run Hello .NET Core\""
  assert_output --partial "Platform: .NET Core"
  assert_equal "$status" 0
}

@test "dotnet-example project with FAKE and paket is runnable" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"cd dotnet-example && ./build.sh\""
  assert_output --partial "Hello World!"
  assert_equal "$status" 0
}
