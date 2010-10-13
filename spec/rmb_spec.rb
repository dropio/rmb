require File.dirname(__FILE__) + '/spec_helper.rb'

describe Rmb do
  it "should store the API key" do
    Rmb::Config.api_key = "83a05513ddddb73e75c9d8146c115f7fd8e90de6"
    Rmb::Config.api_key.should == "83a05513ddddb73e75c9d8146c115f7fd8e90de6"
  end
  
  it "should define exceptions which inherit from StandardError" do
    exception_names = [
      :MissingResourceError,
      :AuthorizationError,
      :RequestError,
      :ServerError
    ]
    
    exceptions = exception_names.map do |n|
      Rmb.const_get n
    end
    
    exceptions.each do |e|
      assert_nothing_raised do
        begin
          raise e
        rescue StandardError
        end
      end
    end
  end
end