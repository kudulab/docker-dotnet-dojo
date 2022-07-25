load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "dotnet core sample project is runnable" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"cd dotnet-docker-samples/samples/dotnetapp && dotnet build && dotnet run Hello .NET Core\""
  assert_output --partial "Build succeeded"
  assert_output --partial "0 Error(s)"
  assert_output --partial ".NET 6.0.7"
  assert_equal "$status" 0
}

@test "dotnet-example project with FAKE and paket is runnable" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"cd dotnet-example && ./build.sh\""
  assert_output --partial "Hello World!"
  assert_equal "$status" 0
}

@test "dotnet-example project can be built and unit tested" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"cd dotnet-example && ./tasks _build && ./tasks _utest\""
  assert_output --partial "A total of 1 test files matched the specified pattern"
  assert_equal "$status" 0
}
