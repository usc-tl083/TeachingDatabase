<!DOCTYPE html>
<html>
<head>
<!-- Background -->
<meta http-equiv="Access-Control-Allow-Origin" content="*"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>


<!-- Testing Navigator-->
<style>
    
    .button {
      background-color: lightgray;
      border: thick;
      color: black;
      padding: 15px 32px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 16px;
      margin: 4px 2px;
      cursor: pointer;
      width: 200px;
    }

    .container {
      position: relative;
    }
    
    .link {
      position: absolute;
      top: 0px;
      left: 0px;
      font-size: 18px;
      background-color: lightgray;
      border: thick;
      color: black;
      padding: 15px 32px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 16px;
      margin: 4px 2px;
      cursor: pointer;
      width: 200px;
    }
    
    </style>
    </head>

<!-- Title -->
<title>Admin Portal</title>

<body>
<center><img src="https://i.imgur.com/GrJSEiU.png"/></center>
<center><img src="https://i.imgur.com/6BxZHQt.png"/></center>
</br>
</br>

<!-- Buttons -->
<center>

<h3>View Staff Details</h3>
<a href="/staff"><button type="button" id="viewStaff" class="button">Staff</button></a><br><br>
<a href="/create_staff"><button type="button" class="button">Create Staff</button></a><br><br><br><br>
<a href="/Archive"><button type="button" class="button">Archive</button></a><br><br><br><br>

<h3>View AQF</h3>
<a href="/Admin_Page/aqfrecords"><button type="button" id="viewAQF" class="button">View AQF Levels</button></a><br><br><br><br>

<h3>Enter or View Approval</h3>
<a href="adminApp.html"><button type="button" id="viewAppButton" class="button">Enter Approval</button></a><br><br>
<a href="approvalRecords.html"><button type="button" id="viewApproval" class="button">View Approvals</button></a><br><br>
<a href="approvalDelete.html"><button type="button" id="deleteAppButton" class="button">Delete Approval</button></a><br><br><br><br>

<h3>Enter or View Review</h3>
<a href="adminRev.html"><button type="button" id="viewRevButton" class="button">Enter Review</button></a><br><br>
<a href="reviewRecords.html"><button type="button" id="viewReview" class="button">View Reviews</button></a><br><br>
<a href="reviewDelete.html"><button type="button" id="deleteRevButton" class="button">Delete Review</button></a><br><br><br><br>

<!-- Back button -->
<a href="/login"><button type="button" class="button">BACK</button></a>

</center>
</body>
</html>
