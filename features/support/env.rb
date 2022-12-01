require 'em/pure_ruby'
require 'appium_lib'
require 'rspec'
require 'yaml'
require 'allure-cucumber'
require 'faker'
require 'open-uri'
require 'httparty'

Dir["#{Dir.pwd}/config/**/*.rb"].each { |file| require_relative file }
Dir["#{Dir.pwd}/global/*.rb"].each { |file| require_relative file }
Dir["#{Dir.pwd}/util/**/*.rb"].each { |file| require_relative file }
Dir["#{Dir.pwd}/resources/**/*.rb"].each { |file| require_relative file }
Dir["#{Dir.pwd}/model/**/*.rb"].each { |file| require_relative file }
Dir["#{Dir.pwd}/context/**/*.rb"].each { |file| require_relative file }

case BaseConfig.device_type
when 'local'
  $CAPS = YAML.load_file(File.expand_path("./config/device/device_config.yml"))
  `adb install -r "#{Dir.pwd}/apps/#{BaseConfig.app_name}_#{BaseConfig.release_version}-#{BaseConfig.build_version}.apk"`
  device = `adb devices -l`.strip.split("attached")[1]
  $CAPS[:caps][:udid] = device.split(" ")[0]
  $CAPS[:caps][:platformVersion] = `adb shell getprop ro.build.version.release`.strip
  $CAPS[:caps][:app] = "#{Dir.pwd}/apps/#{BaseConfig.app_name}"
else
  DigitalaiApiUtil.upload_apk_to_digital_ai
  $CAPS = YAML.load_file(File.expand_path("./config/digitalai/digitalai_config.yml"))
  $CAPS[:caps]['accessKey'] = DigitalaiConfig.digital_ai_access_key
  $CAPS[:appium_lib]['server_url'] = "#{DigitalaiConfig.digital_ai_url}/wd/hub"
  $CAPS[:caps]['release_version'] = BaseConfig.release_version
end

begin
  Appium::Driver.new($CAPS, true)
  Appium.promote_appium_methods Object

rescue Exception => e
  puts e.message
  Process.exit(0)
end

Allure.configure do |c|
  c.results_directory = 'output/allure-results'
  c.clean_results_directory = true
  c.logger = Logger.new(STDOUT, c.logging_level)
  c.environment_properties = {
    env: "#{BaseConfig.environment}",
    release_version: "#{BaseConfig.release_version}",
  }
end

$wait = Selenium::WebDriver::Wait.new timeout: 60
Selenium::WebDriver.logger.level = :error