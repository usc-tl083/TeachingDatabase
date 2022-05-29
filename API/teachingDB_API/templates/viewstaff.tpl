<Title>User infomationr:</Title>
%# Send a GET request with the first and last names to the create_user


<div width="250px">
<form action="<StaffID:int>" method="GET">
<body>
<centre>
    <table>

        <tr>
            <th>ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Address</th>
            <th>Phoneno</th>
            <th></th>
        </tr>
        % for staffdetails in staff_list:
        <tr>
            <td>{{staffdetails[0]}}</td>
            <td>{{staffdetails[1]}}</td>
            <td>{{staffdetails[2]}}</td>
            <td>{{staffdetails[3]}}</td>
            <td>{{staffdetails[4]}}</td>
        </tr>
        % end

    </table>	

    </script>
</centre>
</body>

<a href="/staff"><button type="button" class="button">Back</button></a>    
<a><button type="button" onClick="location.href='/edit{{staffdetails[0]}}'">Edit</button></a>




</form>