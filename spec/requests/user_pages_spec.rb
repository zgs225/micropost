require 'spec_helper'

describe "用户页面" do
  subject { page }

  describe "注册页面" do
    before { visit signup_path }

    it { should have_selector('h1', text: '注册') }
    it { should have_title(full_title('注册')) }
  end
end
