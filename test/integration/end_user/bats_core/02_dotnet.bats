load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "msbuild is invocable" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"msbuild /version\""
  assert_output --partial "Microsoft (R) Build Engine"
  assert_equal "$status" 0
}
@test "dotnet is invocable" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"dotnet --info\""
  assert_output --partial "Microsoft.NETCore.App 6.0.7"
  assert_output --partial "6.0.302"
  assert_equal "$status" 0
}
@test "dotnet core projects can be built" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"\
    rm -rf myproj && mkdir myproj && cd myproj && dotnet new classlib && dotnet restore && dotnet build\""
  assert_output --partial "Restore succeeded"
  assert_output --partial "Build succeeded"
  assert_equal "$status" 0
}
@test "DOTNET_CLI_TELEMETRY_OPTOUT is set" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"env | grep DOTNET\""
  assert_output --partial "DOTNET_CLI_TELEMETRY_OPTOUT=1"
  assert_equal "$status" 0
}
@test "paket is invocable" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"paket --version\""
  assert_output --partial "Paket version 7.1.5"
  assert_equal "$status" 0
}
@test "fake is invocable" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"fake --version\""
  assert_output --partial "FAKE 5 - F# Make (5.22.0)"
  assert_equal "$status" 0
}
