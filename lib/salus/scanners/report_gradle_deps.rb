require 'salus/scanners/base'

# Report Java library usage

module Salus::Scanners
  class ReportGradleDeps < Base
    UNKNOWN_VERSION = ''.freeze

    def run
      shell_return =
        run_shell("bin/parse_gradle_deps", chdir: nil)

      if !shell_return.success?
        report_error(shell_return.stderr)
        return
      end
      pp shell_return.stdout

      # dependencies = nil
      # begin
      #   dependencies = JSON.parse(shell_return.stdout)
      # rescue JSON::ParserError
      #   err_msg = "Could not parse JSON returned by bin/parse_gradle_deps's stdout!"
      #   report_stderr(err_msg)
      #   report_error(err_msg)
      #   return
      # end

      # dependencies.each do |dependency|
      #   group_id = dependency['group_id']
      #   artifact_id = dependency['artifact_id']
      #   report_dependency(
      #     'build.gradle',
      #     type: 'gradle',
      #     name: artifact_id.nil? ? group_id : "#{group_id}/#{artifact_id}",
      #     version: dependency['version'].nil? ? UNKNOWN_VERSION : dependency['version']
      #   )
      # end
    end

    def should_run?
      @repository.build_gradle_present?
    end

    def self.supported_languages
      ['java']
    end
  end
end
