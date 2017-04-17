class RulesController < ApplicationController
   def index
    @rules = Rule.all
  end
end
