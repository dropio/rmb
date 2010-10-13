class Rmb::Drop < Rmb::Resource
  
  attr_accessor :name, :email, :description, :expires_at, :expiration_length, 
                :max_bytes, :current_bytes, :asset_count, :chat_password, :password, 
                :admin_password, :admin_email, :email_key
  
  # Gets a list of assets associated with the Drop. Paginated at 
  def assets(page = 1, order = :oldest)
    Rmb::Resource.client.assets(self, page, order)
  end
  
  # Finds a drop with +name+
  def self.find(name)
    Rmb::Resource.client.drop(name)
  end
  
  # Finds all the drops associated with an API account by page
  def self.find_all(page = 1)
    Rmb::Resource.client.all_drops(page)
  end
  
  # Creates a drop with an +attributes+ hash.
  # Valid attributes: name (string), expiration_length (string), password (string), and admin_password (string)
  # Descriptions can be found here: http://backbonedocs.drop.io/Ruby-API-Client-Library:Drop
  def self.create(attributes = {})
    Rmb::Resource.client.create_drop(attributes)
  end
  
  # Changes the name of a drop.
  def change_name(new_name)
    Rmb::Resource.client.change_drop_name(self,new_name)
  end
  
  # Empties the drop, including it's assets.
  def empty
    Rmb::Resource.client.empty_drop(self)
  end
  
  # Promotes a nickname in the drop chat to admin.
  def promote(nick)
    Rmb::Resource.client.promote_nick(self,nick)
  end
  
  # Saves the Drop.
  def save
    Rmb::Resource.client.update_drop(self)
  end
  
  # Deletes the Drop from the system including all associated assets.
  def destroy!
    Rmb::Resource.client.delete_drop(self)
  end
  
  # Adds a file to the Drop from a given +url+
  def add_file_from_url(url, description = nil, convert_to = nil, pingback_url = nil)
    Rmb::Resource.client.add_file_from_url(self,url,description, convert_to, pingback_url)
  end
  
  # Adds a file to the Drop given the +file_path+.
  def add_file(file_path, description = nil, convert_to = nil, pingback_url = nil, output_locations = nil)
    Rmb::Resource.client.add_file(self, file_path, description, convert_to, pingback_url, output_locations)
  end
  
  # Creates a note with a +title+ and +contents+
  def create_note(contents, title = nil, description = nil)
    Rmb::Resource.client.create_note(self, contents, title, description)
  end
  
  # Creates a link with a +url+, +title+, and +description+.
  def create_link(url, title = nil, description = nil)
    Rmb::Resource.client.create_link(self, url, title, description)
  end
  
  # Creates a subscription to receive POSTs from rmb.io.
  def create_pingback_subscription(url, events = {})
    Rmb::Resource.client.create_pingback_subscription(self,url,events)
  end
  
  # Gets a list of Subscription objects.
  def subscriptions(page = 1)
    Rmb::Resource.client.subscriptions(self, page)
  end
  
  # Generates an authenticated URL that will bypass any login action.
  def generate_url
    Rmb::Resource.client.generate_drop_url(self)
  end
  
end
