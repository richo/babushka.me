class BabushkaController < ApplicationController
  def tarball
    babushka 'babushka tarball'
    render nothing: true
  end
end
