require 'uri'
require 'net/https'
require 'json'
require 'yaml'
require 'cgi'

###################################################################
##   Library :  Verzion App Sdk                                  ##
##   Author  :  Mahtab Alam                                      ##
###################################################################
module OmniAuth
  API_SERVER = "dev.vzwapi.dev.cloud.synchronoss.net"
  WEB_SERVER = "www.synchronoss.net"
  SDK_VERSION = "0.1.0"
end
class VerzionSession
###################################################################
##             Verzion app "clinet key"                          ##
##             Verzion app "cleint secret"                       ##
###################################################################
    def initialize(client_key, client_secret, locale=nil)
        super(locale)
        @client_key = client_key
        @client_secret = client_secret
        @request_token = nil
        @access_token = nil
    end

    def get_token(url_end, input_token, error_message_prefix) #: nodoc:
        response = do_get_with_token("https://#{OmniAuth::API_SERVER}:443/#{OmniAuth::API_VERSION}/oauth#{url_end}", input_token)
        parts = CGI.parse(response.body)
        OAuthToken.new(parts["oauth_token"][0], parts["oauth_token_secret"][0])
    end

    def do_get_with_token(url, token, headers=nil) # :nodoc:
        uri = URI.parse(url)
        request = Net::HTTP::Get.new(uri.request_uri)
        request.add_field('Authorization', build_auth_header(token))
        Verzion::do_http(uri, request)
    end

    def verzion_info
        response = @session.do_get "/account/info"
    end

    # serialize the VerzionSession.
    def serialize
        toreturn = []
        if @access_token
            toreturn.push @access_token.secret, @access_token.key
        end
        get_request_token
        toreturn.push @request_token.secret, @request_token.key
        toreturn.push @consumer_secret, @consumer_key
        toreturn.to_yaml
    end

    # Takes a serialized VerzionSession YAML String and returns a new VerzionSession object
    def self.deserialize(ser)
        ser = YAML::load(ser)
        session = VerzionSession.new(ser.pop, ser.pop)
        session.set_request_token(ser.pop, ser.pop)
        if ser.length > 0
            session.set_access_token(ser.pop, ser.pop)
        end
        session
    end

end
