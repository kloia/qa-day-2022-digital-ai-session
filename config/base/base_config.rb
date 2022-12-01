module BaseConfig

  @short_wait_time = 5
  def self.short_wait_time
    @short_wait_time
  end

  @moderate_wait_time = 15
  def self.moderate_wait_time
    @moderate_wait_time
  end

  @wait_time = 30
  def self.wait_time
    @wait_time
  end


  @device_type = ENV['device_type'] || 'cloud'
  #     Available options
  #       * local - runs on the local connected device
  #       * cloud - runs on the digital.ai's device cloud environment
  def self.device_type
    @device_type
  end

  @release_version = ENV['release_version'] || '6.87.0.1'
  def self.release_version
    @release_version
  end

  @build_version = ENV['build_version'] || '6087001'
  def self.build_version
    @build_version
  end

  @app_name = 'com.ebay.mobile'
  def self.app_name
    @app_name
  end


end