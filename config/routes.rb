XmlSample::Application.routes.draw do
 

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => 'xmlpage#new

   match ':controller(/:action(/:id(.:format)))'
end