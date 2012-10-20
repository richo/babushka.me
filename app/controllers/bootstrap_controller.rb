class BootstrapController < ApplicationController
  def up
    ref = (params[:ref] || '').sub(/^hard,?/, '').sub(/,?hard$/, '')
    ref = 'master' if ref.blank?

    render action: 'up', layout: false, locals: {ref: ref}
  end
end
