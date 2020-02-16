platform :ios, '12.2'

use_frameworks!

workspace 'bootstrap'

def core_pods
    pod 'SnapKit', '~> 5.0.0'
    pod 'RxViewController'
    pod 'Kingfisher', '~> 5.0'
    pod 'RxCocoa', '~> 5.0'
    pod 'RxSwift', '~> 5.0'
    pod 'R.swift' 
    pod 'Moya-ObjectMapper/RxSwift', :git => 'https://github.com/814349837/Moya-ObjectMapper', :commit => '6347b7bde5'
    pod 'Swinject'
    pod 'RxDataSources', :git => "https://github.com/RxSwiftCommunity/RxDataSources.git"
end

target 'core' do
    project 'core/core'
    core_pods
end

target 'feature' do
    project 'feature/feature'
    core_pods
end

target 'domain' do
    project 'domain/domain'
    core_pods
end

def board_pods
    core_pods
end

def data_pods    
    core_pods
    pod 'Moya/RxSwift', "~> 14.0.0-alpha.1"
    pod 'Moya-ObjectMapper/RxSwift', :git => 'https://github.com/814349837/Moya-ObjectMapper', :commit => '6347b7bde5'
    pod 'KeychainAccess'
end

target 'data' do
    project 'data/data.project'
    data_pods
end

def app_pods
  core_pods

  pod 'KeychainAccess'
end

#application
def application_pods
    app_pods
    core_pods
end

target 'bootstrap' do
    project 'bootstrap/bootstrap.project'
    application_pods
end
