Description [![Build Status](https://travis-ci.org/hipsnip-cookbooks/papertrail-rsyslog.png)](https://travis-ci.org/hipsnip-cookbooks/papertrail-rsyslog)
===========
A simple cookbook for setting up a server to stream logs into Papertrail via a secure
TCP connection.


Requirements
============
Built to run on systems with Rsyslog installed. Tested on Ubuntu 12.04


Attributes
==========

    ['papertrail']['port'] = The Papertrail log destination port number (required)
    ['papertrail']['syslog_selector'] = The syslog tags and types to stream into Papertrail (defaults to "*.*")
    ['papertrail']['resume_retry_count'] = The number of times to retry the sending of failed messages (defaults to unlimited)
    ['papertrail']['queue_disk_space'] = The maximum disk space allowed for queues (default to 100M)
    ['papertrail']['enable_tls'] = Whether to encrypt all log traffic going into Papertrail (default to True)
    ['papertrail']['certificate_src'] = The URL of the certificate file on the Papertrail server
    ['papertrail']['certificate_checksum'] = The sha256 checksum for the Papertrail certificate file


Usage
=====
First, make sure you set the ['papertrail']['port'] attribute in your Role/Environment,
to the destination port created in Papertrail. Then include the `papertrail::default` recipe
in you run list to start streaming all syslog entries to Papertrail.


### Tailing log files
This functionality is currently not available, but will be provided via the Opscode Rsyslog cookbook
(included as a dependency), where there is an open pull request for it at the time of this writing.


Development
============
Please refer to the Readme [here](https://github.com/hipsnip-cookbooks/cookbook-development/blob/master/README.md)


License and Author
==================

Author:: Adam Borocz ([on GitHub](https://github.com/motns))

Copyright:: 2013, HipSnip Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
