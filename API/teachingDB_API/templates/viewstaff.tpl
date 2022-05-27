<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="Access-Control-Allow-Origin" content="*"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><staffID></title>
</head>
<body>
    <table>

        <tr>
			<th>Staff ID</th>
            <th>First Name</th>
            <th>Last Name</th>
        </tr>
        % for staffdetails in staff_list:
        <tr>
            <td>{{staffdetails[0]}}</td>
            <td>{{staffdetails[1]}}</td>
			<td>{{staffdetails[2]}}</td>
        </tr>
        % end

    </table>
	

    </script>
</body>
</html>