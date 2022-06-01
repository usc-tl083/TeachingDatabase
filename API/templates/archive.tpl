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
    <title>Archive Page</title>

    <body>
        <center><img src="https://i.imgur.com/GrJSEiU.png"/></center>
        <center><img src="https://i.imgur.com/6BxZHQt.png"/></center>
        </br>
        </br>

        <!-- Buttons -->
        <center>
            <h3>View Staff Details</h3>
            <!-- Link to the Staff Page -->
            <a href="/archive/staff"><button type="button" id="viewStaff" class="button">Staff</button></a><br><br>
            <!-- Back button -->
            <a onclick="goBack()"><button type="button" class="button">Back</button></a>
            <script>
                function goBack() {
                    window.history.back();    
                }
            </script>
        </center>
    </body>
</html>
