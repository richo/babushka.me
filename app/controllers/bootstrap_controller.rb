class BootstrapController < ApplicationController
  def up
    # This param used to be comma-separated options ('hard'/'next')
    # but is now a ref, defaulting to 'master'.
    ref = ((params[:ref] || '').split(',').push('master') - %w[hard next]).first

    render action: 'up', layout: false, locals: {ref: ref}
  end
end
