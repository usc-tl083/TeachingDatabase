<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="Access-Control-Allow-Origin" content="*"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AQFLevel</title>
</head>
<body>
    <table>

        <tr>
			<th>AQFLevel_ID</th>
            <th>Qualified_Degree</th>
            <th>AQFLEVEL</th>
            <th>Qualification_Level_Required_To_Teach</th>
        </tr>
         % for aqf in aqf_list:
        <tr>
            <td>{{aqf[0]}}</td>
            <td>{{aqf[1]}}</td>
			<td>{{aqf[2]}}</td>
            <td>{{aqf[3]}}</td>
        </tr>
        % end


    </table>

<div style="
height:100%;
width:100%;">

<br><br><br><br>
<center><a href="/admin_portal"><button type="button" class="button">BACK</button></a></center>
</div>
	
</body>
</html>