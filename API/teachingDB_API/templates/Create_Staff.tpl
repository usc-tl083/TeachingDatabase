<h2>Create a new User:</h2>
%# Send a GET request with the first and last names to the create_user


<div width="250px">
<form action="/create_staff" method="GET">
    Title:
    <input type="text" size="20" maxlength="100" name="Title">
    First Name:
  <input type="text" size="20" maxlength="100" name="First_Name">
  <br />
  Last Name:
  <input type="text" size="20" maxlength="100" name="Last_Name">
  Email:
  <input type="text" size="20" maxlength="100" name="EmailID">
  Phone No:
  <input type="text" size="20" maxlength="100" name="PhoneNo">
  <input type="submit" name="save" value="save">
  <center><a href="/staff"><button type="button" class="button">BACK</button></a></center>
</form>
</div>