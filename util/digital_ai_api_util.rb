require_relative 'api_util'

class DigitalaiApiUtil
  @auth = "Bearer #{DigitalaiConfig.digital_ai_access_key}"

  def self.get_report_uri(report_id)
    header =
      { 'Content-Type' => 'application/json', 'Connection' => 'Keep-Alive', 'Authorization' => @auth }
    response = ApiUtil.get_request(DigitalaiConfig.digital_ai_url, '/reporter/api/tests/' + report_id.to_s,
                                   header)
    response["keyValuePairs"]["reportUrl"]
  end

  def self.checkUploadApk
    header =
      { 'Content-Type' => 'application/json', 'Connection' => 'Keep-Alive', 'Authorization' => @auth }
    query = {
      'osType' => "android",
      'releaseVersion' => BaseConfig.release_version,
      'buildVersion' => BaseConfig.build_version,
      'packageName' => "#{BaseConfig.app_name}",
      'fileType' => "apk"
    }
    ApiUtil.get_request_with_query(DigitalaiConfig.digital_ai_url,
                                   "/api/v1/applications",
                                   query,
                                   header)
  end

  def self.upload_apk(file_path)
    body = { file: file_path }
    header =
      { 'Content-Type' => 'multipart/form-data', 'Connection' => 'Keep-Alive', 'Authorization' => @auth }
    response = ApiUtil.post_request_multipart("#{DigitalaiConfig.digital_ai_url}/api/v1/applications/new", body, header)
    response
  end

  def self.upload_apk_to_digital_ai
    check_apk = DigitalaiApiUtil.checkUploadApk
    puts "Check apk status => #{check_apk}"
    if check_apk.empty?
      response = DigitalaiApiUtil.upload_apk(File.open("apps/#{BaseConfig.app_name}_#{BaseConfig.release_version}-#{BaseConfig.build_version}.apk"))
      if response["status"] != "SUCCESS"
        raise "Failed to upload apk to digital.ai"
      end
    end
  end

end