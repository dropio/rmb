class Rmb::Subscription < Rmb::Resource
  attr_accessor :id, :username, :message, :type, :drop
  
  # Destroys the given subscription
  def destroy!
    Rmb::Resource.client.delete_subscription(self)
    nil
  end
  
end