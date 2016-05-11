class GroupContextController < ApplicationController

  layout 'admin'

  def destroy(groupcontext)
      @groupcontext = groupcontext
      @groupcontext.destroy
  end

end