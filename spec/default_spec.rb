require_relative 'spec_helper'


describe "papertrail-rsyslog::default" do
  context 'with the default attributes' do
    before(:all) do
      @chef_run = ChefSpec::ChefRunner.new(CHEF_RUN_OPTIONS) do |node|
        node.set['papertrail']['port'] = 12345
      end
      @chef_run.converge 'papertrail-rsyslog::default'
    end

    it { @chef_run.should install_package("rsyslog-gnutls") }
    it { @chef_run.should create_remote_file('/etc/syslog.papertrail.crt') }
    it { @chef_run.should create_file("/etc/rsyslog.d/10-papertrail.conf") }

    context "/etc/rsyslog.d/10-papertrail.conf file" do
      it 'enables TLS' do
        @chef_run.should create_file_with_content( "/etc/rsyslog.d/10-papertrail.conf", "$DefaultNetstreamDriverCAFile /etc/syslog.papertrail.crt")
        @chef_run.should create_file_with_content( "/etc/rsyslog.d/10-papertrail.conf", "$ActionSendStreamDriver gtls")
        @chef_run.should create_file_with_content( "/etc/rsyslog.d/10-papertrail.conf", "$ActionSendStreamDriverMode 1")
        @chef_run.should create_file_with_content( "/etc/rsyslog.d/10-papertrail.conf", "$ActionSendStreamDriverAuthMode x509/name")
      end

      it 'should set $ActionResumeRetryCount to "-1"' do
        @chef_run.should create_file_with_content( "/etc/rsyslog.d/10-papertrail.conf", "$ActionResumeRetryCount -1")
      end

      it 'should set $ActionQueueMaxDiskSpace to "100M"' do
        @chef_run.should create_file_with_content( "/etc/rsyslog.d/10-papertrail.conf", "$ActionQueueMaxDiskSpace 100M")
      end

      it 'should set the forwarding to "*.*     @@logs.papertrailapp.com:12345"' do
        @chef_run.should create_file_with_content( "/etc/rsyslog.d/10-papertrail.conf", "*.*     @@logs.papertrailapp.com:12345")
      end
    end

    context "/etc/rsyslog.d/10-papertrail.conf template" do
      it { @chef_run.template("/etc/rsyslog.d/10-papertrail.conf").should notify("service[rsyslog]", "restart") }
    end
  end


  context 'with TLS turned off' do
    before(:all) do
      @chef_run = ChefSpec::ChefRunner.new(CHEF_RUN_OPTIONS) do |node|
        node.set['papertrail']['port'] = 12345
        node.set['papertrail']['enable_tls'] = false
      end
      @chef_run.converge 'papertrail-rsyslog::default'
    end

    it { @chef_run.should_not install_package("rsyslog-gnutls") }
    it { @chef_run.should_not create_remote_file('/etc/syslog.papertrail.crt') }
    it { @chef_run.should create_file("/etc/rsyslog.d/10-papertrail.conf") }

    context "/etc/rsyslog.d/10-papertrail.conf file" do
      it 'should not enable TLS' do
        @chef_run.should_not create_file_with_content( "/etc/rsyslog.d/10-papertrail.conf", "$ActionSendStreamDriver gtls")
        @chef_run.should_not create_file_with_content( "/etc/rsyslog.d/10-papertrail.conf", "$ActionSendStreamDriverMode 1")
      end
    end
  end


  context 'with resume_retry_count set to 5' do
    context 'and syslog_selector set to cron.*' do
      context 'and queue_disk_space set to 300M' do
        before(:all) do
          @chef_run = ChefSpec::ChefRunner.new(CHEF_RUN_OPTIONS) do |node|
            node.set['papertrail']['port'] = 12345
            node.set['papertrail']['resume_retry_count'] = 5
            node.set['papertrail']['syslog_selector'] = "cron.*"
            node.set['papertrail']['queue_disk_space'] = "300M"
          end
          @chef_run.converge 'papertrail-rsyslog::default'
        end

        it { @chef_run.should create_file("/etc/rsyslog.d/10-papertrail.conf") }

        context "/etc/rsyslog.d/10-papertrail.conf file" do
          it 'should set $ActionResumeRetryCount to "5"' do
            @chef_run.should create_file_with_content( "/etc/rsyslog.d/10-papertrail.conf", "$ActionResumeRetryCount 5")
          end

          it 'should set $ActionQueueMaxDiskSpace to "300M"' do
            @chef_run.should create_file_with_content( "/etc/rsyslog.d/10-papertrail.conf", "$ActionQueueMaxDiskSpace 300M")
          end

          it 'should set the forwarding to "cron.*     @@logs.papertrailapp.com:12345"' do
            @chef_run.should create_file_with_content( "/etc/rsyslog.d/10-papertrail.conf", "cron.*     @@logs.papertrailapp.com:12345")
          end
        end
      end
    end
  end

  context 'with host set to logs2' do
    before(:all) do
      @chef_run = ChefSpec::ChefRunner.new(CHEF_RUN_OPTIONS) do |node|
        node.set['papertrail']['port'] = 12345
        node.set['papertrail']['host'] = 'logs2'
      end
      @chef_run.converge 'papertrail-rsyslog::default'
    end

    it { @chef_run.should create_file("/etc/rsyslog.d/10-papertrail.conf") }

    context "/etc/rsyslog.d/10-papertrail.conf file" do
      it 'should set the forwarding to "*.*     @@logs2.papertrailapp.com:12345"' do
        @chef_run.should create_file_with_content( "/etc/rsyslog.d/10-papertrail.conf", "*.*     @@logs2.papertrailapp.com:12345")
      end
    end
  end
end
