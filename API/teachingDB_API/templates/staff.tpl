<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="Access-Control-Allow-Origin" content="*"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>staff</title>
</head>
<body>
    <table>

        <tr>
			<th>Staff ID</th>
            <th>First Name</th>
            <th>Last Name</th>
        </tr>
        % for staff in staff_list:
        <tr>
            <td>{{staff[0]}}</td>
            <td>{{staff[1]}}</td>
			<td>{{staff[2]}}</td>
        </tr>
        % end

    </table>
	
	<button id="savestaff">Save Staff</button>
    <button id="getstaff">Get Staff</button>
	<label>Staff ID: </label> <input name="staffid" id="Staff_id" value="" type="text"/>
	<label>Staff First Name: </label> <input name="stafffname" id="staff_f_name" value="" type="text"/>
	<label>Staff Last Name: </label> <input name="staflfname" id="staff_l_name" value="" type="text"/>
	<div id="div1"></div>

	<script>
      $(document).ready(function(){
			$("#savestaff").click(function(){
				$.ajax( {
					url: "http://172.23.20.82:80/saveStaff?staffDetail=" + buildJourneyXML(),
					dataType: "xml"
				})
				 .done( function(data) {

				 });

			});
			$("#getstaff").click(function(){
				$.ajax( {
					url: "http://172.23.20.82:80/getStaff?staffid=" + $("#Staff_id").val(),
					dataType: "text" // force the returned result as a string for printing
					// Use "xml" if you want to loop though the data object
					//dataType: "xml"
				})
				 .done( function(data) {
                    alert('Im here');
					$("#div1").text(data);
				    //lenData = data.documentElement.childNodes.length;

				    //alert(lenData);
				    //for (s = 0; s < lenData ;s++) {
                        //x = data.getElementsByTagName("journeyleg")[s].childNodes;
						
						// Loop through data 
                        //for (i = 0; i < x.length ;i++) {
                        //   if (x[i].nodeName == "latlng") {
                        //        alert(x[i].childNodes[0].nodeValue);
                                // get the lat and Lng
                        //        var str = x[i].childNodes[0].nodeValue;
                        //        str = str.replace('(','');
                        //       str = str.replace(')','');
                        //        str = str.replace(',','');
                                // split them into an array
                        //        var words = str.split(' ');
                                //alert(words[0]);
                                //alert(words[1]);
                                //path.push(new google.maps.LatLng(parseFloat(words[0]),  parseFloat(words[1])));
                        //   }
                        //}

                    //}

                    //poly.setPath(path);
				 });

			});
			$("#clearjourney").click(function(){
			   //initMap();

			});
	  });


     function buildStaffXML() {
        var stafftxt = "";

        // Get the journey Legs from the MVCArray
        for (i = 0; i < len ;i++) {
            stafftxt = stafftxt + '<journeyleg><pos>' + i + '</pos><latlng>' + path.getAt(i) + '</latlng></journeyleg>';
        }
        strxml = "<journeys><journey name='" + $("#journey_name").val() + "'>" + stafftxt + "</journey></journeys>";
        return strxml;
      }


    </script>
</body>
</html>