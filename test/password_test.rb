require_relative 'test_helper'

describe Password::Password do
  before do
    @my_policy = {
      :difok => 8,
      :minlen => 15,
      :dcredit => 1
    }
    @p = Password::Password.new({:policy=>@my_policy})
  end

  it "should not be nil" do
    @p.wont_be_nil
  end

  describe "default endpoints" do
    it "should not be nil" do
      @p.endpoints.wont_be_nil
    end
    it "should have 2 endpoints" do
      @p.endpoints.size.must_be :==, 2
    end
  end

  describe "with custom endpoint" do
    before do
      @pp =  Password::Password.new({:policy=>@my_policy,:endpoints=>{:foo=>"/bar"}})
    end

    it "should have the custom endpoint" do
      @pp.endpoints[0].wont_be_nil
      @pp.endpoints[0].name.must_be :==, :foo
    end
  end
end
