class TagsController < ApplicationController
  autocomplete :tag, :name, full: true
  
  
end