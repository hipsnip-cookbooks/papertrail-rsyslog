name             "papertrail-rsyslog"
maintainer       "HipSnip Ltd."
maintainer_email "adam@hipsnip.com"
license          "Apache 2.0"
description      "Installs/Configures rsyslog streaming into Papertrail"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.1.1"
supports 'ubuntu', ">= 12.04"

depends "rsyslog", "~> 1.5.0"

attribute "papertrail/port",
  :display_name => "Port number",
  :description => "The port number on the papertrail service that we should be sending log entries to",
  :required => "required"

attribute "papertrail/syslog_selector",
  :display_name => "Syslog Selector",
  :description => "The syslog tags that should be piped into Papertrail - defaults to all",
  :type => "string",
  :default => "*.*"

attribute "papertrail/resume_retry_count",
  :display_name => "Retry Count",
  :description => "The number of times to retry the sending of failed messages (defaults to unlimited)",
  :default => "-1"

attribute "papertrail/queue_disk_space",
  :display_name => "Queue Disk Space",
  :description => "The maximum disk space allowed for queues",
  :type => "string",
  :default => "100M"

attribute "papertrail/enable_tls",
  :display_name => "Enable TLS",
  :description => "Whether to encrypt all log traffic going into papertrail",
  :default => "true"

attribute "papertrail/certificate_src",
  :display_name => "Certificate Source",
  :description => "The URL of the certificate file on the Papertrail server",
  :type => "string",
  :default => "https://papertrailapp.com/tools/syslog.papertrail.crt"

attribute "papertrail/certificate_checksum",
  :display_name => "Certificate Checksum",
  :description => "The sha256 checksum for the Papertrail certificate file",
  :type => "string",
  :default => "7d6bdd1c00343f6fe3b21db8ccc81e8cd1182c5039438485acac4d98f314fe10"