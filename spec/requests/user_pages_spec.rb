require 'spec_helper'

describe "用户页面" do
  subject { page }

  describe "注册页面" do
    before { visit signup_path }

    it { should have_selector('h1', text: '注册') }
    it { should have_title(full_title('注册')) }

    let(:submit) { '保存' }

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

        describe "注册成功后自动登录" do
          before { click_button submit }
          
          let(:user) { User.find_by(email: "zgs225@gmail.com") }

          it { should have_link("注销") }
          it { should have_title(user.name) }
          it { should have_content("欢迎") }
        end
    end
  end

  describe "个人资料页面" do
      let(:user) { FactoryGirl.create(:user) }

      before { visit user_path(user) }

      it { should have_title(full_title(user.name)) }
      it { should have_content(user.name) }
  end

  describe "编辑个人资料" do
      let(:user) { FactoryGirl.create(:user) }
      
      before do
        sign_in user
        visit edit_user_path(user)
      end

      it { should have_title(full_title("编辑资料")) }
      it { should have_content("更改资料") }
      it { should have_link "换张脸吧", "http://gravatar.com/emails" }

      describe "更新成功" do
        let(:new_name) { "Wang Er" }
        let(:new_email) { "wanger@163.com" }

        before do
          fill_in "姓名", with: new_name
          fill_in "邮箱", with: new_email
          fill_in "密码", with: user.password
          fill_in "确认", with: user.password
          click_button "保存"
        end

        it { should have_title(full_title(new_name)) }
        it { should have_content "用户资料已更改" }
        it { should have_link "注销", signout_path }
        specify { expect(user.reload.name).to eq new_name }
        specify { expect(user.reload.email).to eq new_email }
      end
  end
end
