<Title>User infomationr:</Title>
%# Send a GET request with the first and last names to the create_user


<div width="250px">
    <form action="<StaffID:int>" method="get">
        <body>
            <centre>
                <table>

                    <tr>
                        <th>ID</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Address</th>
                        <th>Phoneno</th>
                    </tr>
                    % for staffdetails in staff_results:
                    <tr>
                        <td>{{staffdetails[0]}}</td>
                        <td>{{staffdetails[1]}}</td>
                        <td>{{staffdetails[2]}}</td>
                        <td>{{staffdetails[3]}}</td>
                        <td>{{staffdetails[4]}}</td>
                    </tr>
                    % end
                 </table>	
            </centre>
        </body>
  
        <a><button type="button" onClick="location.href='/staff/edit/{{staffdetails[0]}}'">Edit</button></a>
        <a><button type="button" onClick="location.href='/staff/archive/{{staffdetails[0]}}'">archive</button></a>
        <a onclick="goBack()"><button type="button" class="button">Back</button></a>
        <script>
            function goBack() {
                window.history.back();
            }
        </script>
    </form>
</div>