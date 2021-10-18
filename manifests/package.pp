#
# @summary Manage the Qualys agent's package installation
#
# Install or uninstall the Qualys agent package
#
class qualys_agent::package {

  if $qualys_agent::manage_package {
    # Force package remove if agent ensure is "absent"
    $ensure = $qualys_agent::ensure ? {
      present => $qualys_agent::package_ensure,
      absent  => 'absent',
    }

    package { 'qualys_agent':
      ensure => $ensure,
      name   => $qualys_agent::package_name,
    }
    # Do not create an ordering dependency if we are removing the agent
    $package_dep = $qualys_agent::ensure ? {
      present => Package['qualys_agent'],
      absent  => undef,
    }
  } else {
    $package_dep = undef
  }
}
