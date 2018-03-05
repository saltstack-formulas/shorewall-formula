# encoding: utf-8

title 'Test Shorewall installation'

describe package('shorewall') do
  it { should be_installed }
end

describe file('/etc/shorewall/interfaces') do
  # Default config
  its('content') { should include 'net  eth0  dhcp,tcpflags,logmartians,nosmurfs' }
end

describe file('/etc/shorewall/zones') do
  # Default config
  its('content') { should include 'fw      firewall' }
  its('content') { should include 'net    ipv4    -    -    -' }
end

describe file('/etc/shorewall/policy') do
  # Default config
  its('content') { should include '$FW    net    ACCEPT    -    -' }
  its('content') { should include 'net    $FW    ACCEPT    -    -' }
end

describe file('/etc/shorewall/rules') do
  its('content') { should include 'ACCEPT  net  $FW  -  -  -  -  -  -  -  -  -  -' }
  its('content') { should include 'ACCEPT  $FW  net  -  -  -  -  -  -  -  -  -  -' }
end
