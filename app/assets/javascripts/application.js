// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

      $.noConflict();

       $(document).ready(function(){
      
       
       $('#lblerror').attr("value", "");
       $('div.errormessage').css('display', 'none');

       $(":checkbox").change(function(event){
       $("#errormessage").css("display", "none");
          var myid = $(this).attr('name');
            var isChecked = $(this).attr('checked');
            if (isChecked )
                  { 
                 var myRow = myid.match(/[0-9]+/); 
       
                 if (myid.indexOf('dlt') == 0)  
                     {
                       var dk1 = 'input[name="kp' + myRow + '"]';
                       var dlk1 = $(dk1);
                       if (dlk1.attr('checked'))
                         {   
                             var message = 'You have already selected to keep row number ' + myRow + '.';
                             $('#lblerror').attr("value", message);
                             $('#errormessage').css("display", "inline");

                         }
				
                    }
                  if (myid.indexOf('kp') == 0) 
                     {
                       var dk2 = 'input[name="dlt' + myRow + '"]';
                       var dlk2 = $(dk2);
                       if (dlk2.attr('checked'))
                         {  
                             var message = 'You have already selected to delete row number ' + myRow + '.';
                             $("#lblerror").attr("value", message);
                             $("#errormessage").css("display", "inline");

                         }
				
                    }

			
			}

        });

       var kNone = "Keep None";
       var kAll = "Keep All";
       var kr = $("#keep_rows")
       
       kr.click(function(event){
         
         if (kr.attr('value') == 'Keep All')
             {
             $('input[name*="dlt"]').each(function(){ this.checked = false; });
             $('input[name*="kp"]').each(function(){ this.checked = true; });
		 kr.attr('value',kNone );
             }

         else 
             {
             $('input[name*="kp"]').each(function(){ this.checked = false; });
		 kr.attr('value',kAll );
             }

       });

       var dNone = "Delete None";
       var dAll = "Delete All";
       var dr = $("#delete_rows")
       
       dr.click(function(event){
         if (dr.attr('value') == 'Delete All')
             {
             $('input[name*="dlt"]').each(function(){ this.checked = true; });
             $('input[name*="kp"]').each(function(){ this.checked = false; });
		 dr.attr('value',dNone );
             }

         else 
             {
             $('input[name*="dlt"]').each(function(){ this.checked = false; });
		 dr.attr('value',dAll );
             }

       });


       });


