<!DOCTYPE html>

<html>
    <!-- Page Style-->
    <head>
        <title>
            Teaching Database Home Page
        </title>
        <style>
                
            body {
                background-image: img src="https://cdn.discordapp.com/attachments/970976688114655242/979883795643785326/pic-1.png"; 
                background-size: cover;
                background-position: center;
                font-family: sans-serif;
            }

            header {
                background-color: #ccc;
                padding: 30px;
            }

            .form-box {
                /* Form container*/
                width: 500px;
                background: rgba(0,0,0,0.8);
                margin: 12% auto;
                padding: 50px 0;
                color: #fff;
                box-shadow: 0 0 20px 2px rgba(0,0,0,0.5);
            }

            h1 {
                /* Heading */
                text-align: center;
                margin-bottom: 40px;
            }

            .input-box {
                /* laying out input boxes */
                margin:31px auto;
                width: 80%;
                border-bottom: 1px solid #fff;
                padding-top: 10px;
                padding-bottom: 5px;
            }

            .input-box input{
                /* making the input boxes more transparent */
                width: 90%;
                border: none;
                outline: none;
                background: transparent;
                color: #fff;
            }

            ::placeholder {
                /* make the placeholder text white */
                color: #ccc;
            }

            .fa {
                margin-right: 10px;
            }

            .eye {
                position: absolute;
            }

            #hide1 {
                /* Hiding and showing the password */
                display: none;
            }

            .login-btn{
                /* login button */
                
            }

            .form-box input[type=submit]{
                /* login button */
                margin:40px auto 20px;
                width:80%;
                display: block;
                outline: none;
                padding: 10px 0;
                border: 1px solid #fff;
                cursor: pointer;
                background:transparent;
                color: #fff;
                font-size: 16px;
            }

        </style>
        <link rel="stylesheet" href= "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    </head>

    <!-- Title -->
    <body>

        <!-- Logo & Admin login Button -->
        <header>
            <img src="https://cdn.discordapp.com/attachments/951409007657103362/979707040865869824/usc_logo.png" style="width:25%;height:25%;"/>
            <a href="/admin_page"><button type="button" class="button">Admin Login</button></a>
        </header>
        
        <!-- Password form -->
            <div class="form-box">
                <h1>Login Here</h1>

                <!-- If successful will take user to Admin Form -->
                <form action="/admin" method="post"> 
                    <div class="input-box"> 
                        <i class="fa-solid fa-user"></i>
                        <input name="username" type="text" placeholder="Username">
                    </div>
                    <div class="input-box"> 
                        <i class="fa-solid fa-key"></i>
                        <input name="Password" type="password" placeholder="Password" id="myInput">
                        <span class="eye" onclick="eyePassword()">
                            <i id="hide1" class="fa fa-eye"></i>
                            <i id="hide2" class="fa fa-eye-slash" ></i>
                        </span>
                    </div>
                    
                    <input value="LOGIN" type="submit"/>  
                  
                </form>
            </div>

            <script>
                function eyePassword(){
                    var x = document.getElementById("myInput");
                    var y = document.getElementById("hide1");
                    var z = document.getElementById("hide2");

                    if(x.type === 'password'){
                        x.type = "text";
                        y.style.display = "block";
                        z.style.display = "none";
                    }
                    else{
                        x.type = "password";
                        y.style.display = "none";
                        z.style.display = "block";
                    }
                }
            </script>
    </body>
</html>
