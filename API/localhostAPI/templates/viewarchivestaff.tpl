<Title>User infomationr:</Title>
%# Send a GET request with the first and last names to the create_user


<div width="250px">
    <center>
        <form action="{{StaffID}}" method="POST">
            <body>            
                <table>
                    <tr>
                        <th>ID</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Address</th>
                        <th>Phoneno</th>
                    </tr>
                    % for staffdetails in staff_list:
                    <tr>
                        <td>{{staffdetails[0]}}</td>
                        <td>{{staffdetails[1]}}</td>
                        <td>{{staffdetails[2]}}</td>
                        <td>{{staffdetails[3]}}</td>
                        <td>{{staffdetails[3]}}</td>
                    </tr>
                    % end
                 </table>	           
            </body>  
            <input type="submit" name="save" value="Activate">
            <a onclick="goBack()"><button type="button" class="button">Back</button></a>
            <script>
                function goBack() {
                    window.history.back();
                }
            </script>
        </form>
    </center>
</div>