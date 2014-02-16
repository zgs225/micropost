require 'spec_helper'

describe "用户页面" do
  subject { page }

  describe "注册页面" do
    before { visit signup_path }

    it { should have_selector('h1', text: '注册') }
    it { should have_title(full_title('注册')) }

    let(:submit) { '注册' }

    describe "填写错误信息" do
        it "不能创建用户" do
            expect { click_button submit }.not_to change(User, :count)
        end
    end

    describe "填写正确的信息" do
        before do
            fill_in "姓名", with: "zgs225"
            fill_in "邮箱", with: "zgs225@gmail.com"
            fill_in "密码", with: "xxq665398"
            fill_in "确认", with: "xxq665398"
        end
        it "创建了用户" do
            expect { click_button submit }.to change(User, :count).by(1)
        end
    end
  end

  describe "个人资料页面" do
      let(:user) { FactoryGirl.create(:user) }

      before { visit user_path(user) }

      it { should have_title(full_title(user.name)) }
      it { should have_content(user.name) }
  end
end
