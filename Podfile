# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'https://github.com/kymodular/PrivatePods.git'
source 'https://github.com/CocoaPods/Specs.git'

target 'MainProject' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  use_frameworks!

  # Pods for MainProject
  pod "A_Category"
  pod "A"
#  pod "D_Category", :path=> "../D_Category"
  pod "D_Category"
  pod "D"
  
  pod "RNModule_Category"
  pod "RNModule"
  
  pod 'HandyFrame'

  # auto input depend start

pod "FlutterModule_Category"
pod "FlutterModule"
  # auto input depend end
  
  target 'MainProjectTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MainProjectUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
