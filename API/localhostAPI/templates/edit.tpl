<Title>Edit User:</Title>
%#


<div width="250px">
    <center>
        <form action="{{StaffID}}" method="POST">
            <body>
            
                <table>
                    % for staffdetails in staff_list:
                    <tr>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Address</th>
                        <th>Phone Number</th>
                        <th></th>
                    </tr>
                    % end
                    <tr>
                        <th><input type="text" size="20" maxlength="100" name='First_Name' value='{{staffdetails[0]}}'></th>
                        <th><input type="text" size="20" maxlength="100" name='Last_Name' value='{{staffdetails[1]}}'></th>
                        <th><input type="text" size="100" maxlength="100" name='Address' value='{{staffdetails[2]}}'></th>
                        <th><input type="text" size="20" maxlength="100" name='PhoneNo' value='{{staffdetails[3]}}' ></th>
                    </tr>                   
                </table>	             
            </body>
           
            <input type="submit" name="save" value="save">
            <a href="/staff"><button type="button" class="button">Back</button></a>   
        </form>
    </center>    
</div>

<script>
function goBack() {
    window.history.back();
}
</script>

