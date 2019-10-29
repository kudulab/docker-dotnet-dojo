load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "mono-runtime is installed and mono is invocable" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"dpkg -s mono-runtime && mono --version\""
  assert_output --partial "Mono"
  assert_equal "$status" 0
}
@test "msbuild is invocable" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"msbuild /version\""
  assert_output --partial "Microsoft (R) Build Engine"
  assert_equal "$status" 0
}
@test "locale are set and perl does not complain" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"perl --version\""
  refute_output --partial "Setting locale failed"
  assert_output --partial "This is perl 5"
  assert_equal "$status" 0
}
@test "nunit-console is installed and invocable" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"dpkg -s nunit-console && nunit-console --version\""
  assert_output --partial "NUnit-Console"
  assert_equal "$status" 0
}
@test "nuget is invocable" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"nuget help\""
  assert_output --partial "NuGet Version: 4.7"
  assert_equal "$status" 0
}
@test "multi-target dotnet core and mono projects can be built" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"\
    rm -rf spike-core2-mono5 && git clone git@github.com:ai-traders/spike-core2-mono5.git spike-core2-mono5 && cd spike-core2-mono5 && ./build.sh\""
  assert_output --partial "Done Building Project"
  assert_output --partial "Build succeeded."
  assert_equal "$status" 0
}
