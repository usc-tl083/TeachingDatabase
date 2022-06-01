<!DOCTYPE html>
<html lang="en">
    <head>
	    <meta charset="UTF-8">
        <meta http-equiv="Access-Control-Allow-Origin" content="*"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>staff</title>
    </head>
    <center>
        <body>
            <table>

                <tr>
			        <th>Staff ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                </tr>
                % for staff in staff_list:
                <tr>
                    <td><a href="/staff/{{staff[0]}}"><button type="button" class="button">{{staff[0]}}</button></a></td>
                    <td>{{staff[1]}}</td>
			        <td>{{staff[2]}}</td>
                </tr>
                % end
            </table>
            <a href="create_staff"><h3>Add a New Staff Member<h3></a>
            <a href="/Admin_Page"><button type="button" class="button">Back</button></a>
        </body>
    </center>
</html>