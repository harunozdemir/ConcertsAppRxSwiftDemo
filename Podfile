# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
use_frameworks!

def network
  pod 'AlamofireImage'
  pod 'Kingfisher'
end

def rx_pod
  pod 'RxAlamofire', '~> 5'
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
#  pod 'RxTest', '~> 5'
end

def app_pod
  pod "ViewAnimator"
end

target 'ConcertsApp' do
  app_pod
  network
  rx_pod
end

target 'ConcertsAppTests' do
  inherit! :search_paths
  rx_pod
end
