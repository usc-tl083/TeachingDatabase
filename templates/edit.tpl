<Title>Edit User:</Title>
%#


<div width="250px">
    <form action="{{StaffID}}" method="POST">
        <body>
            <centre>
                <table>
                    % for staffdetails in staff_list:
                    <tr>
                        <th>{{staffdetails[0]}}</th>
                        <th>{{staffdetails[1]}}</th>
                        <th>{{staffdetails[2]}}</th>
                        <th>{{staffdetails[3]}}</th>
                        <th></th>
                    </tr>
                    % end
                    <tr>
                        <th><input type="text" size="20" maxlength="100" name='First_Name' placeholder='First name'></th>
                        <th><input type="text" size="20" maxlength="100" name='Last_Name' placeholder='Last name'></th>
                        <th><input type="text" size="20" maxlength="100" name='Address' placeholder='Address'></th>
                        <th><input type="text" size="20" maxlength="100" name='PhoneNo' placeholder='Phone number' ></th>
                    </tr>
                   
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

