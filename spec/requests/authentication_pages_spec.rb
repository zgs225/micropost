require 'spec_helper'

describe "AuthenticationPages" do
  subject { page }

  describe "登录页面" do
    before { visit signin_path }

    it { should have_title(full_title("登录")) }
    it { should have_content("登录") }

    describe "登录失败" do
      before { click_button "登录" }

      it { should have_title(full_title("登录")) }
      it { should have_content("错误") }

      describe "点击其他页面后" do
        before { visit root_path }
        it { should_not have_content("错误") }
      end
    end

    describe "登录成功" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        fill_in "邮箱", with: user.email.downcase
        fill_in "密码", with: user.password
        click_button "登录"
      end

      it { should have_title(full_title(user.name)) }
      it { should have_link "资料",     href: user_path(user) }
      it { should have_link "注销",     href: signout_path }
      it { should have_link "设定",     href: edit_user_path(user) }
      it { should_not have_link "登录", href: signin_path }

      describe "注销登录" do
        before { click_link "注销" }
        it { should have_link "登录" }
      end
    end
  end

  describe "未登录用户" do
    let(:user) { FactoryGirl.create(:user) }

    describe "访问编辑页面" do
      before { visit edit_user_path(user) }
      it { should have_content "登录" }
    end

    describe "提交编辑表单" do
      before { patch user_path(user) }
      specify { expect(response).to redirect_to(signin_path) }
    end

    describe "不能访问粉丝页面" do
      before { visit followers_user_path(user) }
      it { should have_title full_title('登录') }
    end

    describe "不能访问关注页面" do
      before { visit following_user_path(user) }
      it { should have_title full_title('登录') }
    end

    describe "访问一个受保护的页面" do
      before do
        visit edit_user_path user
        fill_in "邮箱", with: user.email
        fill_in "密码", with: user.password
        click_button "登录"
      end

      describe "登陆后" do
        it "需要跳转到编辑页面" do
          expect(page).to have_title("编辑资料")
        end
      end
    end
  end
end
