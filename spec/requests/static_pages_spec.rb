require 'spec_helper'

describe "静态页面" do
  let(:base_title) { "易博" }

  describe "首页" do
    it "需要包含标题 ‘易博’" do
      visit root_path
      expect(page).to have_content('易博')
    end

    it "需要有正确的首页标题" do
      visit root_path
      expect(page).to have_title("#{base_title}")
    end
  end

  describe "帮助页面" do
    it "需要包含标题 ‘帮助’" do
      visit help_path
      expect(page).to have_content('帮助')
    end

    it "需要有正确的帮助页面标题" do
      visit help_path
      expect(page).to have_title("#{base_title} | 帮助")
    end
  end

  describe "关于页面" do
    it "需要包含标题 ‘关于’" do
      visit about_path
      expect(page).to have_content('关于')
    end

    it "需要有正确的关于页面标题" do
      visit about_path
      expect(page).to have_title("#{base_title} | 关于")
    end
  end

  describe "联系页面" do
    it "需要包含标题‘联系’" do
      visit contact_path
      expect(page).to have_content('联系')
    end

    it "需要有正确的联系页面标题" do
      visit contact_path
      expect(page).to have_title("#{base_title} | 联系")
    end
  end
end
