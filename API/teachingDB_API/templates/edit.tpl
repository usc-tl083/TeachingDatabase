<Title>Edit User:</Title>
%#


<div width="250px">
    <form action="{{StaffID}}" method="POST">
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
                        <th><input type="text" size="20" maxlength="100" name='First_Name'></th>
                        <th><input type="text" size="20" maxlength="100" name='Last_Name'></th>
                        <th><input type="text" size="20" maxlength="100" name='Address'></th>
                        <th><input type="text" size="20" maxlength="100" name='PhoneNo'></th>
                    </tr>
                    % end
                </table>	
             </centre>
        </body>
        <input type="submit" name="save" value="save">
        <a onclick="goBack()"><button type="button" class="button">Back</button></a>   
    </form>
</div>

<script>
function goBack() {
    window.history.back();
}
</script>

