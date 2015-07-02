require_relative "../src/lib/password/password"
require "minitest/autorun"


describe Password::Password do
  before do
    @my_policy = {
      :difok => 8,
      :minlen => 15,
      :dcredit => 1
    }
    @p = Password::Password.new @my_policy
  end

  it "should not be nil" do
    @p.wont_be_nil
  end

  describe "endpoints" do
    it "should not be nil" do
      @p.endpoints.wont_be_nil
    end
    it "should have 2 endpoints" do
      @p.endpoints.size.must_be :==, 2
    end
  end

end
