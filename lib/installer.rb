module CocoaPodsChillaxSwift
  class Installer
    def initialize(sandbox_root, user_options)
      @sandbox_root = sandbox_root
      @options = user_options
    end

    def install!

      Pod::UI.section 'Disabling select compiler optimizations' do

        project = Xcodeproj::Project.open File.join(@sandbox_root, 'Pods.xcodeproj')

        unoptimized_pod_names = @options["pods"]

        targets = project.targets.select { |target|
          unoptimized_pod_names.select { |pod_name|
            target.display_name.end_with? pod_name
          }.count > 0
        }

        targets.each do |target|
          target.build_configurations.each do |config|
            config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
          end
        end

        project.save
      end
    end
  end
end
