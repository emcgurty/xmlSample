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
      
       
       function showMessage(msg) 
           {
             $('#lblerror').attr("value", msg);
             $('#errormessage').css("display", "inline");
           }


      $('#lblerror').attr("value", "");
       $('div.errormessage').css('display', 'none');

       $(":checkbox").change(function(event){
          $("#errormessage").css("display", "none");
          var myid = $(this).attr('name');
            var isChecked = $(this).attr('checked');
            if (isChecked )
                  { 
                 var myRow = myid.match(/[0-9]+/); 
                 ///($('myid:contains("dlt")'))
                 if (myid.indexOf('dlt') == 0)  
                     {
                       var dk1 = 'input[name="kp' + myRow + '"]';
                       var dlk1 = $(dk1);
                       if (dlk1.attr('checked'))
                         {   
                             showMessage('You have already selected to keep row number ' + myRow + '.');

                         }
				
                    }
                  if (myid.indexOf('kp') == 0) 
                     {
                       var dk2 = 'input[name="dlt' + myRow + '"]';
                       var dlk2 = $(dk2);
                       if (dlk2.attr('checked'))
                         {  
                             showMessage('You have already selected to delete row number ' + myRow + '.');

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

       var numRows = $("#num_rows")

       numRows.change(function(event) {
          var nr = numRows.val().replace(/^\s\s*/, '').replace(/\s\s*$/, '');
          var isNum = /^\d+$/;
          if (!isNum.test(nr))
             {
                 showMessage("Please enter a numeric value.");
                 var setNum ='input[name="num_rows"]'
		     $(setNum).focus();
                 $(setNum).select();         ////Doesn't work
                 //numRows.focus().select();         ////Doesn't work either
             }
         else
            {
         
          if ((nr < 0) || (nr > 20)) 
                {
                 showMessage("The number you have entered must be greater than 0 and less than 20.");
                 }
		}
      
   });

   });


