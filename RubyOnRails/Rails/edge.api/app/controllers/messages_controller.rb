class MessagesController < ApplicationController

  def index
    Publisher.publish("hello", "Hello, world!")
  end

end
