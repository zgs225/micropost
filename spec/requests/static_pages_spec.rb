require 'spec_helper'

describe "静态页面" do

  describe "首页" do
    it "需要包含标题 ‘易博’" do
      visit '/static_pages/home'
      expect(page).to have_content('易博')
    end

    it "需要有正确的首页标题" do
      visit '/static_pages/home'
      expect(page).to have_title("易博 | 首页")
    end
  end

  describe "帮助页面" do
    it "需要包含标题 ‘帮助’" do
      visit '/static_pages/help'
      expect(page).to have_content('帮助')
    end

    it "需要有正确的帮助页面标题" do
      visit '/static_pages/help'
      expect(page).to have_title('易博 | 帮助')
    end
  end

  describe "关于页面" do
    it "需要包含标题 ‘关于’" do
      visit '/static_pages/about'
      expect(page).to have_content('关于')
    end

    it "需要有正确的关于页面标题" do
      visit '/static_pages/about'
      expect(page).to have_title('易博 | 关于')
    end
  end
end
