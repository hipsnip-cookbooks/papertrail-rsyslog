#
# Cookbook Name:: papertrail
# Recipe:: default
#
# Copyright 2013, HipSnip Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Make sure a port number has been set
# @TODO: Better ways to Error out in Chef?
raise "You have to set a Papertrail destination port number in the attribute ['papertrail']['port']" if node['papertrail']['port'].zero?

include_recipe "rsyslog::default"

if node['papertrail']['enable_tls']
  package 'rsyslog-gnutls' do
    action :install
  end

  remote_file '/etc/syslog.papertrail.crt' do
    source   node['papertrail']['certificate_src']
    checksum node['papertrail']['certificate_checksum']
    mode     0644
  end
end

# Add papertrail to all syslog entries for now
template "/etc/rsyslog.d/10-papertrail.conf" do
  source "rsyslog-main.erb"
  mode "0644"
  notifies :restart, "service[rsyslog]"
end