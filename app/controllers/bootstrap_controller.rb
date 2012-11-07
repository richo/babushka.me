class BootstrapController < ApplicationController
  def up
    deprecated_hard = (params[:ref] || '')[/\bhard\b/]
    ref = (params[:ref] || '').sub(/^hard,?/, '').sub(/,?hard$/, '')
    ref = 'master' if ref.blank?

    origin = params[:origin] || 'benhoskings'

    render action: 'up', layout: false, locals: {ref: ref, deprecated_hard: deprecated_hard, origin: origin}
  end
end
