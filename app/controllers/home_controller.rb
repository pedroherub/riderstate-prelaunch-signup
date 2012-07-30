# -*- encoding : utf-8 -*-
class HomeController < ApplicationController

#layout "home"

http_basic_authenticate_with :name => "sntcasado", :password => "rider2011"

def welcome
  render :layout => "welcome"
end

end
