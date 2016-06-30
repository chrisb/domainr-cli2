module Domainr
  module CLI2
    class Base < Thor
      API_KEY_STORAGE_LOCATION = '~/.domainr-cli2'.freeze
      DEFAULT_COMMAND          = 'search'.freeze
      STATUS_FETCH_PREFIX      = 'Fetching status... '.freeze

      class_option :verbose, type: :boolean, default: false
      class_option :status, type: :boolean, default: true

      def self.rewrite_arguments(arguments)
        options_removed = arguments.reject { |a| a =~ /^\-/ }
        arguments.unshift(DEFAULT_COMMAND) if options_removed.count == 1 && !Domainr::CLI2::Base.commands.keys.include?(options_removed.first)
        arguments
      end

      desc 'version', 'print the version number'
      def version
        puts Domainr::CLI2::VERSION
      end

      desc "search TERM", "Execute a fuzzy search for domains like TERM"
      def search(name)
        results = client.search(name)
        if results.any?
          puts "Found #{results.count.to_s.green} possible domains."
          print_and_flush STATUS_FETCH_PREFIX if options[:status]
          puts results_table(results)
        else
          puts "Nothing available for that."
        end
      end

      desc 'status DOMAIN', 'Check the status of a single domain'
      def status(domain)
        table = ::Terminal::Table.new headings: %w(Status Domain)
        table << [colorize_status(get_status(domain)), domain]
        puts table
      end

      desc "api_key API_KEY", "Set your Mashape API key"
      def api_key(api_key)
        File.open(path_to_api_key, 'w') { |f| f.write(api_key) }
      end

      private

      def warn_api_key
        STDERR.puts "\nUh oh! You need to set a Mashape API key before you can use this tool.\n".red
        STDERR.puts "To obtain one, visit: https://github.com/domainr/api/wiki\nThen use #{'domainr api_key <your-api-key>'.yellow} to set your key.\n\n"
        exit
      end

      def path_to_api_key
        File.expand_path(API_KEY_STORAGE_LOCATION)
      end

      def read_api_key
        return @api_key if @api_key
        warn_api_key unless File.exist?(path_to_api_key)
        @api_key = File.open(path_to_api_key).read.strip
        warn_api_key unless @api_key
        debug "Read API key: #{@api_key.inspect}"
        @api_key
      end

      def results_table(results)
        ::Terminal::Table.new headings: %w(Status Domain Path) do |table|
          results.each.with_index do |result, index|
            status = options[:status] ? get_status(result.domain, index+1, results.count) : nil
            table.add_row [
              colorize_status(status),
              result.domain,
              url_for_result(result)
            ]
          end
        end
      end

      def debug(info)
        return unless options[:verbose]
        puts "[#{'DEBUG'.yellow}] #{info}"
      end

      def url_for_result(result)
        "http://#{result.domain}#{result.path}"
      end

      def colorize_status(status)
        return 'UKNOWN'.yellow if status.nil?
        summary = status.summary
        friendly_summary(summary)
          .upcase
          .send(color_for_summary(summary))
          .bold
      end

      def friendly_summary(summary)
        case summary.downcase.to_sym
        when :active, :undelegated, :tld, :pending
          'unavailable'
        when :inactive
          'available'
        when :priced, :marketed
          'for sale'
        else
          summary
        end
      end

      def color_for_summary(summary)
        case summary.downcase.to_sym
        when :active, :undelegated, :tld, :pending
          :red
        when :inactive
          :green
        when :priced, :marketed
          :yellow
        else
          :to_s
        end
      end

      def print_and_flush(text)
        print "#{text}\r"
        $stdout.flush
      end

      def get_status(domain, current, total)
        debug "Fetching status for: #{domain.inspect}"
        print_and_flush "#{STATUS_FETCH_PREFIX} #{current}/#{total}" if options[:status]
        client.status(domain).first
      end

      def client
        @client = Domainr::Client.new mashape_key: read_api_key
      end
    end
  end
end
