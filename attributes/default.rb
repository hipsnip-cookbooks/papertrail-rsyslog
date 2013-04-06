#
# Cookbook Name:: papertrail
# Attributes:: default
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
default['papertrail']['port'] = 0
default['papertrail']['resume_retry_count'] = -1
default['papertrail']['syslog_selector'] = '*.*'
default['papertrail']['queue_disk_space'] = '100M'

default['papertrail']['enable_tls'] = true
default['papertrail']['certificate_src'] = 'https://papertrailapp.com/tools/syslog.papertrail.crt'
default['papertrail']['certificate_checksum'] = '7d6bdd1c00343f6fe3b21db8ccc81e8cd1182c5039438485acac4d98f314fe10'