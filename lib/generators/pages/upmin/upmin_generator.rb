require 'rails/generators'

module Pages
  module Generators
    class UpminGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Add Upmin for an admin interface. Requires Devise and role-based authentication."

      def add_upmin
        copy_file 'upmin.rb', 'config/initializers/upmin.rb'
        route = "  mount Upmin::Engine => '/admin'"
        inject_into_file 'config/routes.rb', route + "\n", :after => "routes.draw do\n"
        navlink = "    <li><%= link_to 'Admin', '/admin' %></li>"
        inject_into_file 'app/views/layouts/_navigation_links.html.erb', navlink + "\n", :after => "<% if current_user.admin? %>\n"
      end

    end
  end
end
