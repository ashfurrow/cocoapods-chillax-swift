module CocoaPodsKeys
  Pod::HooksManager.register('deoptimize', :post_install) do |context, user_options|
    require 'installer'

    Installer.new(context.sandbox_root, user_options).install!
  end
end
