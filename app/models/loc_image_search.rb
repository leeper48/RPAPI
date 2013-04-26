require "json"
require "net/http"
require "net/https"

class LOCSearchForImages
  def initialize
    @endpoint = "http://z3950.loc.gov:7090/voyager?version=1.1&operation=searchRetrieve&query="
    #http://z3950.loc.gov:7090/voyager?version=1.1&operation=searchRetrieve&query=dinosaur&maximumRecords=1&recordSchema=dc
  #@phrase = "tree"
  end

  # token received from CreateSession/RenewSession API call
  def loc_search_for_images(phrase)
    request = {
      :RequestHeader => { :Token => token},
      :SearchForImages2RequestBody => {
        :Query => { :SearchPhrase => phrase},
        :ResultOptions => {
          :IncludeKeywords => false,
          :ItemCount => 30,
          :ItemStartNumber => 1,
          :RefinementOptionsSet => "AssetFamily" 
        },
        :Filter => { :ImageFamilies => ["creative"] }
      }
    }
    response = post_json(request)

    #status = response["ResponseHeader"]["Status"]
    #images = response["SearchForImagesResult"]["Images"]
  end

  def post_json(request)
    #You may wish to replace this code with your preferred library for posting and receiving JSON data.
    uri = URI.parse(@endpoint)
    http = Net::HTTP.new(uri.host, 443)
    http.use_ssl = false

    response = http.post(uri.path, request.to_json, {'Content-Type' =>'application/json'}).body
    JSON.parse(response)
  end
end