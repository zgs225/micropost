require 'spec_helper'

describe Post do
  let(:user) { FactoryGirl.create(:user) }

  before do
    @post = user.posts.build({ content: "Lorem ipsum"})
  end

  subject { @post }

  it { should respond_to :content }
  it { should respond_to :user_id }
  it { should respond_to :user }
  its(:user) { should eq user }
  it { should be_valid }

  describe "微博的用户id不能为空" do
    before { @post.user_id = '' }
    it { should_not be_valid }
  end
end
