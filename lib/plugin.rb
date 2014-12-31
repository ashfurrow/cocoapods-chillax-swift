module CocoaPodsChillaxSwift
  Pod::HooksManager.register('cocoapods-chillax-swift', :post_install) do |context, user_options|
    require_relative 'installer'

    Installer.new(context.sandbox_root, user_options).install!
  end
end
