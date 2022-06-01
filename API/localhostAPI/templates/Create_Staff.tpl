<Title>Create a new User:</Title>
%# Send a GET request with the first and last names to the create_user


<div width="250px">
    <form action="/create_staff" method="GET">
    <fieldset>
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
                        <th><input type="text" size="20" maxlength="100" name="Title" required autofocus
                            list="titles">
                        </th>
                        <th><input type="text" size="20" maxlength="100" name="First_Name" required></th>
                        <th><input type="text" size="20" maxlength="100" name="Last_Name" required></th>
                        <th><input type="email" size="20" maxlength="100" name="EmailID" required></th>
                        <th><input type="text" size="20" maxlength="100" name="Address" required></th>
                        <th><input type="tel" size="20" maxlength="100" name="PhoneNo" 
                            pattern="^\({0,1}((0|\+61)(2|4|3|7|8)){0,1}\){0,1}( |-){0,1}[0-9]{2}( |-){0,1}[0-9]{2}( |-){0,1}[0-9]{1}( |-){0,1}[0-9]{3}$"
                            required>
                        </th>
                    </tr>
                </table>
            </center>
        </body>

        <datalist id="titles">
            <option value="Mr">
            <option value="Mrs">
            <option value="Miss">
            <option value="Dr">
            <option value="Prof">
        </datalist>

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
                        <th><input type="text" size="30" maxlength="100" name="NameOfQualification" required></th>
                        <th><input type="text"  size="20" maxlength="100" name="AQFLevel_ID" required></th>
                        <th><input type="text" size="30" maxlength="100" name="Subject_Area" required></th>
                        <th><input type="text" size="50" maxlength="100" name="Institution_Name" required></th>
                        <th><input type="text" size="20" maxlength="100" name="Institution_Country" required></th>
                        <th><input type="text" size="20" maxlength="100" name="Full_Name_Of_Award"></th>
                        <th><input type="text" size="20" maxlength="100" name="Awarded_Year"></th>
                    </tr>
                </table>
            </centre>
        </body>
        
        <input type="submit" name="save" value="save">
        <a href="/staff"><button type="button" class="button">Back</button></a>
        </fieldset>
    </form>
</div>