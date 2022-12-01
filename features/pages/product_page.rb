class ProductPage
  def initialize
    @btn_info_text = { id: 'text_slot_1' }
    @btn_product = { xpath: '(//android.widget.RelativeLayout[@resource-id="com.ebay.mobile:id/search_item_card_header"])[1]' }
    @btn_add_cart = { xpath: '(//android.widget.Button[@resource-id="com.ebay.mobile:id/cta_button"])[1]' }
    @btn_spinner = { id: 'spinner_selection_option' }
    @btn_recommend_list = { xpath: '(//android.widget.FrameLayout)[4]' }
    @btn_buy_it_now = { id: 'buy_bar_button' }
  end

  def click_second_product
    PageHelper.click_element(@btn_info_text)
    PageHelper.click_element(@btn_product)
  end

  def add_product_to_cart
    PageHelper.scroll_until_element(@btn_add_cart, 'down')
    PageHelper.click_element(@btn_add_cart)
    if PageHelper.is_element_enabled(@btn_spinner)
      PageHelper.click_element(@btn_spinner)
      PageHelper.click_element(@btn_recommend_list)
      PageHelper.click_element(@btn_buy_it_now)
    end
  end

end
