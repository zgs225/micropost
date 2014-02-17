require 'spec_helper'

describe "AuthenticationPages" do
  subject { page }

  describe "登陆页面" do
    before { visit signin_path }

    it { should have_title(full_title("登陆")) }
    it { should have_content("登陆") }

    describe "登陆失败" do
      before { click_button "登陆" }

      it { should have_title(full_title("登陆")) }
      it { should have_content("错误") }

      describe "点击其他页面后" do
        before { visit root_path }
        it { should_not have_content("错误") }
      end
    end

    describe "登陆成功" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        fill_in "邮箱", with: user.email.downcase
        fill_in "密码", with: user.password
        click_button "登陆"
      end

      it { should have_title(full_title(user.name)) }
      it { should have_link "资料",     href: user_path(user) }
      it { should have_link "注销",     href: signout_path }
      it { should_not have_link "登陆", href: signin_path }

      describe "注销登陆" do
        before { click_link "注销" }
        it { should have_link "登陆" }
      end
    end
  end
end
