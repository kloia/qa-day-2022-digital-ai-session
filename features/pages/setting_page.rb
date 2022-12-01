class SettingPage

  def initialize
    @btn_close = { accessibility_id: 'Close' }
  end

  def click_close_button
    PageHelper.click_element(@btn_close)
    self
  end

end