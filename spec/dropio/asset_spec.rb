require File.dirname(__FILE__) + '/../spec_helper'

describe Dropio::Asset do
  before(:each) do
    @drop = Dropio::Drop.new
    @drop.name = "test_drop"
    @asset = Dropio::Asset.new
    @asset.name = "test_asset"
    @asset.drop = @drop

    @client = Dropio::Client.new
    @api = stub(Dropio::Api)
    @client.service = @api

    Dropio::Resource.stub!(:client).and_return(@client)
    Dropio::Resource.client.should == @client
    Dropio::Resource.client.service.should == @api
  end

  it "should have the attributes of an Asset" do
    @asset.should respond_to(:drop, :name, :type, :title, :description, :filesize, :created_at,
                             :status, :pages, :duration, :artist,
                             :track_title, :height, :width, :contents, :url)
  end

  it "should save itself" do
    @client.should_receive(:handle).with(:asset,{}).and_return(@asset)
    expected_hash = {:url=> "http://drop.io", :contents=>nil, :description=>nil, :title=>nil}
    @asset.url = expected_hash[:url]
    @api.stub!(:update_asset).and_return({})
    @asset.save
  end

  it "should destroy itself" do
    @client.should_receive(:handle).with(:response,{}).and_return({"result" => "Success"})
    @api.stub!(:delete_asset).with(@drop.name, @asset.id).and_return({})
    @asset.destroy!
  end

  it "should destroy roles" do
    @client.should_receive(:handle).with(:response,{}).and_return({"result" => "Success"})
    @api.stub!(:delete_role).with(@drop.name, @asset.id, "thumbnail", nil).and_return({})
    @asset.destroy_role!("thumbnail")
  end

  it "should destroy roles at locations" do
    @client.should_receive(:handle).with(:response,{}).and_return({"result" => "Success"})
    @api.stub!(:delete_role).with(@drop.name, @asset.id, "thumbnail", "DropioS3").and_return({})
    @asset.destroy_location!("thumbnail","DropioS3")
  end

  it "should send itself to another drop." do
    @target_drop = Drop.new
    @target_drop.name = "target_drop"
    @client.should_receive(:handle).with(:response,{}).and_return({"result" => "Success"})
    @api.stub!(:copy_asset).and_return({})
    @asset.send_to_drop(@target_drop)
  end

  it "should copy itself to another drop." do
    @target_drop = Drop.new
    @target_drop.name = "target_drop"
    @client.should_receive(:handle).with(:response,{}).and_return({"result" => "Success"})
    @api.stub!(:copy_asset).and_return({})
    @asset.copy_to(@target_drop)
  end

  it "should move itself to another drop." do
    @target_drop = Drop.new
    @target_drop.name = "target_drop"
    @client.should_receive(:handle).with(:response,{}).and_return({"result" => "Success"})
    @api.stub!(:move_asset).and_return({})
    @asset.move_to(@target_drop)
  end

  it "should find itself" do
    @client.should_receive(:handle).with(:asset,{}).and_return(@asset)
    @api.should_receive(:asset).with(@drop.name, @asset.id).and_return({})
    Asset.find(@drop, @asset.id).should == @asset
  end

  it "should generate a signed url" do
    @api.should_receive(:generate_asset_url)
    @asset.generate_url
  end

  it "should have an original file url" do
    @api.should_receive(:generate_original_file_url)
    @asset.original_file_url
  end

  
end
