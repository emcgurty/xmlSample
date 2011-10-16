require 'rexml/document'


class Userhash1
      
include REXML


  def initialize()
  
       puts "IN INITIALIZE"
         #need to create a hash of item class objects
        items_path =   "C:\\xmlSample\\doc\\items.xml"
        # Look for the existing items.xml file
         	xmlfile = File.open(items_path, 'r')
		if xmlfile 
		  # Load the data into @hash
		  xmldoc = Document.new(xmlfile)
     
            aprice = [] 
            @i = -1
            xmldoc.elements.each("dataroot/items/price") do |e|
            @i = @i +1
            aprice[@i] = e.text
            end

            aproduct = [] 
            @i = -1
            xmldoc.elements.each("dataroot/items/product") do |e|
            @i = @i +1
            aproduct[@i] = e.text
            end

            adescription = [] 
            @i = -1
            xmldoc.elements.each("dataroot/items/description ") do |e|
            @i = @i +1
            adescription[@i] = e.text
            end


            aidentifier = [] #Array.new (myIndex)
            @i = -1
            xmldoc.elements.each("dataroot/items/identifier ") do |e|
            @i = @i +1
            aidentifier[@i] = e.text
            puts "ID"
            puts aidentifier[@i]
            end

            @i = -1
            @hash_temp = Hash.new
            aidentifier.each do |e|
               @hash_t1 = Hash.new
               @i = @i + 1
               @hash_t1      = { "identifier" => aidentifier[@i], 
                              "product" => aproduct[@i], "description" => adescription [@i], 
                              "price" => aprice[@i], "status"=>"", "searchresult"=>true}
               if !(@hash_temp.nil?)
                     @hash_temp[(@i+1).to_s] = @hash_t1
               end
               end

            @hash_temp
         end
     end
  end  

