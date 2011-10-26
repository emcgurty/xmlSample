require 'rexml/document'
require 'builder'
class XmlpageController < ApplicationController 

include REXML

def new

flash[:notice] = ""
strMessage = "Application Loaded"
if !(params[:icount].nil?)
      @hash_temp = Hash.new
      @intCount = params[:icount].to_i
      @i = 1
		while @i <= @intCount do
                              @hash_temp[@i.to_s] = { "identifier" => params["identifier" + @i.to_s ], 
                              "product" => params["product" + @i.to_s ], 
                              "description" => params["description" + @i.to_s ], 
                              "price" => params["price" + @i.to_s ], 
                              "status"=>params["status" + @i.to_s ],
                              "searchresult"=>params["searchresult" + @i.to_s ] }
					@i = @i + 1
               
           end
           @uh = Userhash.new(1,@hash_temp)
          
          
end

if (params[:commit] == 'Build Rows')

 if !(params[:num_rows].to_s.strip.blank?)
           if is_numeric?(params[:num_rows].to_s)
			intParam = params[:num_rows].to_i
                      if (intParam > 0) && (intParam < 21)
				build_rows
                        strMessage = "Build Rows Successful."
                      else
				strMessage = "Build row value must be numeric and greater than 0 and less than 21."
                      end
            else
               strMessage = "Build row value must be numeric and greater than 0 and less than 21."
  
            end
      else
        strMessage = "Please provide a numeric value greater than 0 and less than 21 in 'Enter the number of sample rows'."
      end
      

       
elsif (params[:commit] == 'Reload')
      getXML
      strMessage = "Reload Rows Successful."
elsif (params[:commit] == 'Search')
         if (params[:txtSearch].strip.blank?)
             strMessage = "Please provide a search value."
         else
            mySelection = params[:search_item]
            search(mySelection, params[:txtSearch].to_s)
            strMessage = "Search successful."
        end 
elsif (params[:commit] == 'Clear Search')
         clear_search
elsif (params[:commit] == 'Selected Keep')

params.each do |e|
          if e[1] == "1"
               mye = e[0].gsub("kp",'').strip
                    if is_numeric?(mye)
                    if (params["identifier" + mye].to_s.strip.empty? or 
                            params["product" + mye].to_s.strip.empty? or
                            params["description" + mye].to_s.strip.empty? or 
                            params["price" + mye].to_s.strip.empty?  or  
                            (!is_numeric?(params["price" + mye].to_s.strip)) )
                            strMessage = "No null values and price must be a numeric value."
				
                      else
			
                            if (params["status" + mye].to_s == "new")
                               strStatus = "new"
                             elsif (params["status" + mye].to_s == "")
                               strStatus = "changed"
				     end
                            
                              @hash_temp = Hash.new
                              @hash_temp = { "identifier" => params["identifier" + mye], 
                              "product" => params["product" + mye], 
                              "description" => params["description" + mye], 
                              "price" => params["price" + mye], 
                              "status"=>strStatus,
                              "searchresult"=>true }
                             
                 	  		
                              @uh.app_update  @hash_temp, mye
                              strMessage = "Row successfully marked to be changed in XML."

                       end

                  end # close numeric
	     end  # closes true		
      end  #closes do
                           
elsif (params[:commit] == 'Selected Delete')
        params.each do |e|
          if e[1] == "1"
               mye = e[0].gsub("dlt",'').strip
                   if is_numeric?(mye)
				      @hash_temp = Hash.new
                              @hash_temp = { "identifier" => params["identifier" + mye], 
                              "product" => params["product" + mye], 
                              "description" => params["description" + mye], 
                              "price" => params["price" + mye], 
                              "status"=>"deleted",
					"searchresult"=>true }
			            @uh.app_update @hash_temp, mye
                              strMessage = "Row successfully marked for delete from XML."

                     
                  end
	     end		
      end
           
 elsif (params[:commit] == 'Clear All')
   clear_all
   strMessage = "Cleared All Rows Successful."
 elsif (params[:commit] == 'Port')
   port
   strMessage = "Your changes have been successfully written to your XML file."


else
 strMessage = getXML

end
 
flash[:notice] = strMessage

  @itemvals = @uh.app_hash

 
end

private 

def port

      
        items_path =   "C:\\xmlSample\\doc\\items.xml"
        items_path_bak =   "C:\\xmlSample\\doc\\items_bak.xml"
        # Look for the existing items.xml file
             xmlfile = File.rename(items_path, items_path_bak)   
             xmlfile = File.open(items_path, 'w')
             
	  	if xmlfile 
		  begin
                  xmlfile.write(generate_xml)  
                  
              rescue
                 ## Later

              end
            end
end


 def generate_xml
    doc = Builder::XmlMarkup.new( :target => output_string = "", :indent => 2 )
    doc.instruct! 
    doc.dataroot {
      
      @uh.app_hash.each do |element_data|
         doc.items { 
         if (element_data[1]["status"] != "deleted")
        	 doc.identifier( element_data[1]["identifier"] )
             doc.product( element_data[1]["product"] )
             doc.description( element_data[1]["description"] )
             doc.price( element_data[1]["price"] )

         end
       }
     end

     }  

    return output_string
  end

def is_numeric?(i)
    i.to_i.to_s == i || i.to_f.to_s == i
    
end

def build_rows
      intParam = params[:num_rows].to_i
      if (intParam > 0)   
             newRows = intParam 
             @i = @uh.h_size
             while newRows > 0 do
               @i = @i + 1
               @hash_temp = Hash.new
               @hash_temp[@i.to_s]  = { "identifier" =>"", 
                              "product" => "", 
                              "description" => "", 
                              "price" => "", 
                              "status"=>"new", 
                              "searchresult"=>true }
               @uh.app_merge = @hash_temp
               newRows = newRows - 1
              end         
      end
       
end

def clear_all
       @i = "1"
       @uh.delete_all
       @hash_temp = Hash.new
       @hash_temp[@i] = { "identifier" => "", 
                      "product" => "", 
                      "description" => "", 
                      "price" => "", 
                      "status"=>"",
			    "searchresult"=>true }
       @uh.app_hash = @hash_temp
end

  

  
  
   def search(intSelection, searchValue)
      ## Obviously I could use Reg Expression for better searches
      ## and in serialization I think I could have used AREL
      intSe = intSelection.to_i
      @uh.app_hash.each do |e|
       if (intSe == 0)  #identifier
         if (e[1]["identifier"].to_s != searchValue)
             e[1]["searchresult"] = false
         else
           e[1]["searchresult"] = true
         end
       elsif (intSe == 1)  #product
         if (e[1]["product"].to_s != searchValue)
             e[1]["searchresult"] = false
         else
          e[1]["searchresult"] = true
         end
       elsif (intSe == 2)  #description
         if (e[1]["description"].to_s != searchValue)
             e[1]["searchresult"] = false
         else
             e[1]["searchresult"] = true
         end
      elsif (intSe == 3)  #price
         if (e[1]["price"].to_s != searchValue)
             e[1]["searchresult"] = false
         else
 		e[1]["searchresult"] = true
	   end
      end # if
     end  # end do
   end   #end search

  
 def clear_search
      @uh.app_hash.each do |e|
         e[1]["searchresult"] = true
      end
end
  
def getXML()
  
        #need to create a hash of item class objects
        items_path =   "C:\\xmlSample\\doc\\items.xml"
        # Look for the existing items.xml file
         	if File.exists?(items_path)

            xmlfile = File.open(items_path, 'r')
            
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

            @uh = Userhash.new(1,@hash_temp)
        strMessage = "Application loaded with the following items.xml values."
          else

              xmlfile = File.new(items_path, 'w')
              xmlfile.write(generate_new_xml)
              
            @hash_temp = Hash.new
            @hash_temp["1"]      = { "identifier" => "", 
                              "product" => "", "description" => "", 
                              "price" => "", "status"=>"", "searchresult"=>true}
              @uh = Userhash.new(1,@hash_temp)
              strMessage = "Application loaded. Items.xml was not found, and was created with no values."
         
         end  #closes if
     end  #closes getXL

     def generate_new_xml
     
		doc = Builder::XmlMarkup.new( :target => output_string = "", :indent => 2 )
		doc.instruct! 
	      doc.dataroot {}
     
            return output_string 
     end

end


