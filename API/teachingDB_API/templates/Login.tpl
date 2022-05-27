<!DOCTYPE html>

<html>
    <!-- Page Style-->
    <head>
        <title>
            Teaching Database Home Page
        </title>
        <style>
                
            body {
               /* background-image: img src="templates/images/pic-1.png"; */
                background-size: cover;
                background-position: center;
                font-family: sans-serif;
            }

            header {
                background-color: #fff;
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

            #hide1 {
                /* Hiding and showing the password */
                display: none;
            }

            .login-btn{
                /* login button */
                margin:40px auto 20px;
                width:80%;
                display: block;
                outline: none;
                padding: 10px 0;
                border: 1px solid #fff;
                cursor: pointer;
                background:transparent;
            }

            .login-btn input{
                /* login button */
                color: #fff;
                font-size: 16px;
            }

        </style>
        <link rel="stylesheet" href= "https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.1.1/css/fontawesome.min.css">
    </head>

    <!-- Title -->
    <body>

        <!-- Logo & Admin login Button -->
        <header>
            <img src="https://cdn.discordapp.com/attachments/951409007657103362/979707040865869824/usc_logo.png"/>
            <a href="/admin_page"><button type="button" class="button">Admin Login</button></a>
        </header>
        
        <!-- Password form -->
            <div class="form-box">
                <h1>Login Here</h1>

                <form action="/login" method="post"> 
                    <div class="input-box"> 
                        <input name="username" type="text" placeholder="Username">
                    </div>
                    <div class="input-box"> 
                        <input name="Password" type="password" placeholder="Password">
                        <span>
                            <i id="hide1" class="fa fa-eye-slash"></i>
                            <i id="hide2" class="fa fa-eye" ></i>
                        </span>
                    </div>
                    <div classs="login-btn">
                        <input value="LOGIN" type="submit"/>  
                    </div>
                </form>
            </div>
    </body>
</html>
