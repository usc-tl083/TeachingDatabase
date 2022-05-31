<Title>User infomationr:</Title>
%# Send a GET request with the first and last names to the create_user


<div width="250px">
    <center>
        <form action="<StaffID:int>" method="get">
            <body>            
                <table>
                    <tr>
                        <th>ID</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Email</th>
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
                        <td>{{staffdetails[5]}}</td>
                    </tr>
                    % end
                 </table>	            
            </body>
            <body>            
                <table>
                    <tr>
                        <th>AQF Level</th>
                        <th>Qualification</th>
                        <th>Subject Area</th>
                        <th>Institution Name</th>
                        <th>Country</th>
                        <th>Full Name Of Award</th>
                        <th>Award Year</th>
                    </tr>
                    % for qual in qual_results:
                    <tr>
                        <td>{{qual[0]}}</td>
                        <td>{{qual[1]}}</td>
                        <td>{{qual[2]}}</td>
                        <td>{{qual[3]}}</td>
                        <td>{{qual[4]}}</td>
                        <td>{{qual[5]}}</td>
                        <td>{{qual[6]}}</td>
                    </tr>
                    % end
                 </table>	            
            </body>
            <body>            
                <h3>Previouse Teaching Experience</h3>
                <table>
                    <tr>
                        <th>course</th>
                        <th>Role</th>
                        <th>Organisation</th>
                        <th>Start</th>
                        <th>Finish</th>
                    </tr>
                    % for course in course_results:
                    % for teach in teachex_results:
                    % for role in role_results:
                    <tr>
                        <td>{{course[0]}}</td>
                        <td>{{role[0]}}</td>
                        <td>{{teach[0]}}</td>
                        <td>{{teach[1]}}</td>
                        <td>{{teach[2]}}</td>
                    </tr>
                    % end
                    % end
                    % end
                 </table>	           
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
    </center>
</div>