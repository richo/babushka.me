BabushkaMe::Application.routes.draw do
  match '/deps/search.:format/:q', :to => 'deps#search', :via => :get, constraints: {q: /[^\/]+/}
  match '/runs.:format', :to => 'runs#create', :via => :post

  match '/a_new_tarball', :to => 'babushka#tarball', :via => :post

  match "/up", :to => "bootstrap#up", :via => :get, :format => :sh
  match "/up/:opts", :to => "bootstrap#up", :via => :get, :format => :sh

  match '/docs' => redirect("/")
  match '/rdoc' => redirect("http://rubydoc.info/github/benhoskings/babushka/master/frames")
  match '/mailing_list' => redirect("http://groups.google.com/group/babushka_app")

  match "/refs/heads/:refname" => redirect("http://github.com/benhoskings/babushka/tree/%{refname}"), refname: /[0-9a-z_\-\.]+/i
  match "/issues/:id" => redirect("http://github.com/benhoskings/babushka/issues#issue/%{id}"), id: /\d+/
  match "/:id" => redirect("http://github.com/benhoskings/babushka/commit/%{id}"), id: /[0-9a-f]{7,40}/i
end
