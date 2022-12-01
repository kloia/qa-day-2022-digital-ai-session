class HomePage

  def initialize
    @btn_search_text = { id: 'search_box' }
    @btn_search_list = { xpath: '(//android.widget.TextView[@resource-id="com.ebay.mobile:id/search_suggestion_text"])[2]' }
    @btn_sign_in_page = { xpath: "//*[@resource-id='com.ebay.mobile:id/button_create_account']" }
  end

  def search_product(product_name)
    PageHelper.click_element(@btn_search_text)
    PageHelper.send_keys_with_keycodes(product_name)
  end

  def click_search_list
    PageHelper.click_element(@btn_search_list)
  end

  def verify_open_login_page
    PageHelper.is_element_enabled(@btn_sign_in_page).should == true
  end
end
