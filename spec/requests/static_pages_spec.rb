require 'spec_helper'

describe "静态页面" do
  subject { page }

  shared_examples_for "所有静态页面" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "首页" do
    before { visit root_path }
    let(:heading) { '欢迎来到易博' }
    let(:page_title) { '' }

    it_should_behave_like "所有静态页面"
    it { should_not have_title(' | 首页') }
  end

  describe "帮助页面" do
    before { visit help_path }
    let(:heading) { '帮助' }
    let(:page_title) { '帮助' }

    it_should_behave_like "所有静态页面"
  end

  describe "关于页面" do
    before { visit about_path }
    let(:heading) { '关于' }
    let(:page_title) { '关于' }

    it_should_behave_like "所有静态页面"
  end

  describe "联系页面" do
    before { visit contact_path }
    let(:heading) { '联系' }
    let(:page_title) { '联系' }

    it_should_behave_like "所有静态页面"
  end

  it "框架中的链接全部正常" do
    visit root_path

    click_link "首页"
    expect(page).to have_title(full_title(''))

    click_link "帮助"
    expect(page).to have_title(full_title('帮助'))

    click_link "关于"
    expect(page).to have_title(full_title('关于'))

    click_link "联系"
    expect(page).to have_title(full_title('联系'))

    click_link "登录"
    expect(page).to have_title(full_title("登录"))
  end

  describe "显示粉丝数和关注数" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      user.follow!(other_user)
      visit root_path
    end
  end
end
