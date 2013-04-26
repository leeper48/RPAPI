module WelcomeHelper
  def sessiontoken()
    require './app/models/create_session_sample.rb'
    sess = CreateSessionSample.new
    sess.create_session
  end

  def imgsearch(schphrase)
    require './app/models/search_for_images_sample.rb'
    @imgsch = SearchForImagesSample.new
    @found = @imgsch.search_for_images(sessiontoken, schphrase)
  end
end
