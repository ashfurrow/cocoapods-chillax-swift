CocoaPods' "Chillax, Swift" Plugin
==================================

A CocoaPods plugin to disable all compiler optimizations for specific pods.

Why?
----

So you're writing a hit new app and need an external dependency. The library you want to use is available as a CocoaPod – awesome! But it's written in Swift. Good thing CocoaPods 0.36 Beta 1 version support Swift pods! Using the beta version of CocoaPods, you install the library, try to compile, then BAM the compiler segfaults. 

```
Command failed due to signal: Segmentation fault: 11

0  swift                    0x0000000104a9bb68 llvm::sys::PrintStackTrace(__sFILE*) + 40
1  swift                    0x0000000104a9c054 SignalHandler(int) + 452
2  libsystem_platform.dylib 0x00007fff8d815f1a _sigtramp + 26
3  libsystem_platform.dylib 0x00007fae8cf15028 _sigtramp + 4285526312
4  swift                    0x000000010482a69f (anonymous namespace)::SimplifyCFGOpt::run(llvm::BasicBlock*) + 3487
5  swift                    0x00000001048298ef llvm::SimplifyCFG(llvm::BasicBlock*, llvm::TargetTransformInfo const&, llvm::DataLayout const*) + 31
6  swift                    0x000000010478cdc3 (anonymous namespace)::CFGSimplifyPass::runOnFunction(llvm::Function&) + 2051
7  swift                    0x00000001049aeced llvm::FPPassManager::runOnFunction(llvm::Function&) + 301
8  swift                    0x00000001049aeedb llvm::FPPassManager::runOnModule(llvm::Module&) + 43
9  swift                    0x00000001049af39f llvm::legacy::PassManagerImpl::run(llvm::Module&) + 975
10 swift                    0x0000000103e8d1f4 performIRGeneration(swift::IRGenOptions&, swift::Module*, swift::SILModule*, llvm::StringRef, llvm::LLVMContext&, swift::SourceFile*, unsigned int) + 3828
11 swift                    0x0000000103e8d473 swift::performIRGeneration(swift::IRGenOptions&, swift::SourceFile&, swift::SILModule*, llvm::StringRef, llvm::LLVMContext&, unsigned int) + 51
12 swift                    0x0000000103de26f4 frontend_main(llvm::ArrayRef<char const*>, char const*, void*) + 5444
13 swift                    0x0000000103ddfa6d main + 1677
14 libdyld.dylib            0x00007fff923b15c9 start + 1
```

This problem is often caused by the Swift compiler's opimizations. Disabling them fixes the segfault. 

![This is how you make me feel sometimes, Swift](http://gifs.ashfurrow.com/angry.gif)

Doncha wish that you could just tell Swift to Chillax? Well, now you can. 

How?
----

This plugin requires version 0.36 Beta 1 of CocoaPods. Create or modify a file named `Gemfile` in the root of your project's directory:

```ruby
source 'https://rubygems.org'

gem 'cocoapods', :git => 'https://github.com/CocoaPods/CocoaPods.git', :tag => '0.36.0.beta.1'
gem 'cocoapods-chillax-swift', '~> 0.2.0'
```

Great! Now from the command line in the same directory as the `Gemfile`, run `bundle install` to install both the pre-release version of CocoaPods and this plugin. You've installed the plugin, but you still need to tell CocoaPods which pods are segfaulting the compiler. Open your Podfile and add the following lines. 

```ruby
plugin 'cocoapods-chillax-swift', {
  :pods => ['XCGLogger']
}
```

In this example, we're disabling compiler optimizations for [XCGLogger](https://github.com/DaveWoodCom/XCGLogger). 

*Important*: from now on, instead of typing `pod install`, you *must* type `bundle exec pod install`. If you don't, then you're running the version of CocoaPods installed for the entire system instead of the version specified in the `Gemfile`. 

OK, next time you `bundle exec pod install`, you'll get a little extra message at the end of the process. 

```
> bundle exec pod install
Analyzing dependencies
Downloading dependencies
Using XCGLogger (0.0.1)
Generating Pods project
Integrating client project
Disabling select compiler optimizations
```

And you're good to go! 
