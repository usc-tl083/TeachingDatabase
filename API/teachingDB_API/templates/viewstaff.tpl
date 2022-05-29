<!DOCTYPE html>
<html lang="en">
    <head>
	    <meta charset="UTF-8">
        <meta http-equiv="Access-Control-Allow-Origin" content="*"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        % for staffdetails in staff_list:
        <title>Staff: {{staffdetails[0]}} {{staffdetails[1]}}</title>
    </head>
    <body>
        <table>
            <tr>
                <th>First Name</th>
                <th>Last Name</th>
            </tr>
            % for staffdetails in staff_list:
            <tr>            
                <td>{{staffdetails[0]}}</td>
                <td>{{staffdetails[1]}}</td>
            </tr>
            % end
        </table>
        </script>
    </body>
</html>