class Userhash
      
  def initialize(i, app_hash)
       @i = i
       @app_hash = app_hash
  end

  def app_hash
     @app_hash
  end

  def h_size
    @app_hash.size
  end

  def i
	@i
  end

  def i=(value)
	@i=value
  end

  def app_hash=(value)
      @app_hash=value
  end


  def app_merge=(value)
    @app_hash.merge!(value)
  
  end

  def app_update(value, int)
     @app_hash[int].replace(value)
  end

   def delete_all
    @app_hash.clear
   end

  def delete_row=(mykey)
    @app_hash.delete(mykey)
  end
   
end

