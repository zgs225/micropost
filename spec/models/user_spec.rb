require 'spec_helper'

describe User do
    before { @user = User.new(name: 'yuez',
                              email: 'zgs225@gmail.com', 
                              password: 'foobar',
                              password_confirmation: 'foobar') }

    subject { @user }

    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:authenticate) }
    it { should respond_to(:remember_token) }

    it { should be_valid }

    describe "当 name 不存在时" do
        before { @user.name = '' }

        it { should_not be_valid }
    end

    describe "当 name 长度太长时" do
        before { @user.name = 'a'*51 }

        it { should_not be_valid }
    end

    describe "当 email 格式不正确时" do
        it "不能通过验证" do
            addresses = %W[user@foo,bar user@foo foo@bar. foo.org]

            addresses.each do |invalid_address|
                @user.email = invalid_address
                expect(@user).not_to be_valid
            end
        end
    end

    describe "当 email 格式正确时" do
        it "可以通过验证" do
            addresses = %W[user@foo.bar zgs225@gmail.com 843097013@qq.com public@foo.bar.com]

            addresses.each do |valid_address|
                @user.email = valid_address
                expect(@user).to be_valid
            end
        end
    end

    describe "当 email 不是唯一时" do
        before do
            user_with_same_email = @user.dup
            user_with_same_email.email = @user.email.upcase
            user_with_same_email.save
        end

        it { should_not be_valid }
    end

    describe "当 password 不存在时" do
        before { @user = User.new(name: 'yuez',
                                  email: 'zgs225@gmail.com', 
                                  password: '',
                                  password_confirmation: '') }

        it { should_not be_valid }
    end

    describe "当 password 两次输入的密码不一致时" do
        before { @user.password_confirmation = 'dismatch' }

        it { should_not be_valid }
    end

    describe "当 authenticate 之后返回正确的值" do
        before { @user.save }
        let(:found_user) { User.find_by_email(@user.email) }

        describe "password 正确" do
            it { should eq found_user.authenticate(@user.password) }
        end

        describe "password 不正确" do
            let(:user_for_invalid_passowrd) { @user.authenticate('invalid') }

            it { should_not eq user_for_invalid_passowrd }
            specify { expect(user_for_invalid_passowrd).to be_false }
        end
    end

    describe "当 password 小于6位时" do
        before { @user.password = @user.password_confirmation = 'a' * 5 }

        it { should_not be_valid }
    end

    describe "记住登录状态" do
      before { @user.save }
      its(:remember_token) { should_not be_blank }
    end
end
