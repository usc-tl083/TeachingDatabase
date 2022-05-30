<Title>Create a new User:</Title>
%# Send a GET request with the first and last names to the create_user


<div width="250px">
    <form action="/create_staff" method="GET">
        <body>
            <center>
                <h3>Staff Details</h3>
                <table>

                    <tr>
			            <th>Title</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Email</th>
                        <th>Address</th>
                        <th>Phone Number</th>
                    </tr>
                    <tr>
                        <th><input type="text" size="20" maxlength="100" name="Title"></th>
                        <th><input type="text" size="20" maxlength="100" name="First_Name"></th>
                        <th><input type="text" size="20" maxlength="100" name="Last_Name"></th>
                        <th><input type="text" size="20" maxlength="100" name="EmailID"></th>
                        <th><input type="text" size="20" maxlength="100" name="Address"></th>
                        <th><input type="text" size="20" maxlength="100" name="PhoneNo"></th>
                    </tr>
                </table>
            </centre>
        </body>


        <body>
            <center>
                <h3>Qualification</h3>
                <table>
                    <tr>
			            <th>Qualification</th>
                        <th>AQF level ID</th>
                        <th>Subject Area</th>
                        <th>Institution</th>
                        <th>Institution Country</th>
                        <th>Award</th>
                        <th>Award year</th>
                    </tr>
                    <tr>
                        <th><input type="text" size="30" maxlength="100" name="NameOfQualification"></th>
                        <th><input type="text" size="20" maxlength="100" name="AQFLevel_ID"></th>
                        <th><input type="text" size="30" maxlength="100" name="Subject_Area"></th>
                        <th><input type="text" size="50" maxlength="100" name="Institution_Name"></th>
                        <th><input type="text" size="20" maxlength="100" name="Institution_Country"></th>
                        <th><input type="text" size="20" maxlength="100" name="Full_Name_Of_Award"></th>
                        <th><input type="text" size="20" maxlength="100" name="Awarded_Year"></th>
                    </tr>
                </table>
            </centre>
        </body>
        <input type="submit" name="save" value="save">
        <a onclick="goBack()"><button type="button" class="button">Back</button></a>
        <script>
            function goBack() {
                window.history.back();
            }
        </script>
    </form>
</div>