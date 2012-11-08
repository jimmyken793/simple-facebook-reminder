# coding: utf-8
class User
  module OmniauthCallbacks
    ["github","google","twitter","douban"].each do |provider|
      define_method "find_or_create_for_#{provider}" do |response|
        uid = response["uid"]
        data = response["info"]
        puts response
        if user = User.where("authorizations.provider" => provider , "authorizations.uid" => uid).first
          user.access_token = response['credentials']['token']
          user.save!
          user
        elsif user = User.find_by_email(data["email"])
          user.access_token = response['credentials']['token']
          user.save!
          user.bind_service(response)
          user
        else
          user = User.new_from_provider_data(provider, uid, data)

          if user.save(:validate => false)
            user.authorizations << Authorization.new(:provider => provider, :uid => uid )
            return user
          else
            Rails.logger.warn("User.create_from_hash failed，#{user.errors.inspect}")
            return nil
          end
        end
      end
    end

    def new_from_provider_data(provider, uid, data)
      User.new do |user|
        user.email = data["email"]

        user.login = data["nickname"]
        user.login.gsub!(/[^\w]/, "_")

        if User.where(:login => user.login).count > 0 || user.login.blank?
          user.login = "u#{Time.now.to_i}" # TODO: possibly duplicated user login here. What should we do?
        end
        user.access_token = response['credentials']['token']
        user.password = Devise.friendly_token[0, 20]
        user.location = data["location"]
        user.tagline = data["description"]
      end
    end
  end
end