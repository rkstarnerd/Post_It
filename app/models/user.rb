class User < ActiveRecord::Base
  include SluggableGemille

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}

  sluggable_column :username

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator'
  end

  def two_factor_auth?
    !self.phone.blank?    
  end

  def generate_pin!
    self.update_column(:pin, rand(10 ** 6))
  end

  def send_pin_to_twilio
    # Instantiate a Twilio client
      client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])

      msg = "Enter your pin to continue the login process: #{self.pin}"

      # Create and send an SMS message
      client.account.sms.messages.create(
        from: TWILIO_CONFIG['from'],
        to:   self.phone,
        body: msg
      )
  end

  def remove_pin!
    self.update_column(:pin, nil)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["name"]
      user.password = SecureRandom.hex
    end
  end
end