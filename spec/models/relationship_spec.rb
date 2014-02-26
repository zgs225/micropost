require 'spec_helper'

describe Relationship do
  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }
  let(:relationship) { follower.relationships.build(followed_id: followed.id) }

  subject { relationship }

  it { should be_valid }

  describe "关系表正常的功能" do
    it { should respond_to(:follower) }
    it { should respond_to(:followed) }
    its(:follower) { should eq follower }
    its(:followed) { should eq followed }
  end

  describe "followed_id 不能为空" do
    before { relationship.followed_id = nil }
    it { should_not be_valid } 
  end

  describe "follower_id 不能为空" do
    before { relationship.follower_id = nil }
    it { should_not be_valid } 
  end
end
