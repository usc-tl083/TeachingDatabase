<!DOCTYPE html>

<html>
    <!-- Page Style-->
    <head>
        <title>
            Teaching Database Admin Login Page
        </title>
        <style>
                
            body {
                background-image: img src="https://cdn.discordapp.com/attachments/970976688114655242/979883795643785326/pic-1.png"; 
                background-size: cover;
                background-position: center;
                font-family: sans-serif;
            }

            .header {
                position: relative;
                z-index: 1030;
                background: #fff;
                border-bottom: 1px solid #9a9a9a;
            }

            .header-inner {
                max-width: 80rem;
                margin-left: 30px;
                margin-right: auto;
                width: 25%;
                display: flex;
                position: relative;
                height: 25%;
                justify-content: space-between;
                align-items: center;
                z-index: 1;
                padding-left: 1.1rem;
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
        <header class="header" id="header">
            <div class="header-inner">
                <a href="/" class="logo-link" aria-label="home">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 316.84 73.12" aria-label="USC logo">
                        <path style="fill:#1d1d1b" d="M181.75,2.09h-2.94a1.62,1.62,0,0,0-1.62,1.61V41q0,13.68-4.85,20c-3.24,4.25-7.47,6.38-14.57,6.38q-8.25,0-12.38-6.22t-4.23-17.08l-.11-28.41a43.24,43.24,0,0,0-.41-6.48A10.07,10.07,0,0,0,139.12,5a6.08,6.08,0,0,0-2.92-2.24,13.26,13.26,0,0,0-4.55-.68h-9.87a1.61,1.61,0,0,0-.18,3.21q3.48.39,4.57,2.8a18.49,18.49,0,0,1,1.3,7.57V41q0,31.13,28.21,31.13A35.21,35.21,0,0,0,168.58,70a20.56,20.56,0,0,0,8.56-6.11,24.87,24.87,0,0,0,4.76-9.77A53.82,53.82,0,0,0,183.36,41V3.7A1.61,1.61,0,0,0,181.75,2.09Z"></path>
                        <path style="fill:#1d1d1b" d="M231.41,35.41l-12.85-7.62q-2.51-1.47-4.49-2.82a22.54,22.54,0,0,1-3.4-2.82A11.36,11.36,0,0,1,208.48,19,9.43,9.43,0,0,1,207.7,15,9.12,9.12,0,0,1,211,7.63q3.25-2.71,8.87-2.72,7.89,0,12.76,4.6,4.56,4.29,6.4,14.05A1.7,1.7,0,0,0,240.67,25h0a1.7,1.7,0,0,0,1.7-1.7V12.74a7.76,7.76,0,0,0-2.09-5.27,17.28,17.28,0,0,0-5.43-4A31.36,31.36,0,0,0,227.28,1a44.31,44.31,0,0,0-8.51-.83Q208,.21,201.69,5a15.55,15.55,0,0,0-6.32,13.06A17.82,17.82,0,0,0,198.3,28.2q2.92,4.39,10,8.57l12.85,7.73a38.78,38.78,0,0,1,7.89,6A10.32,10.32,0,0,1,231.93,58a8.71,8.71,0,0,1-3.58,7.58q-3.58,2.57-9.5,2.56-8.72,0-13.75-4.6-4.71-4.29-6.46-14A1.72,1.72,0,0,0,197,48.05a1.7,1.7,0,0,0-1.7,1.7V60.27a7.72,7.72,0,0,0,2.09,5.28,17.21,17.21,0,0,0,5.43,4A31.28,31.28,0,0,0,210.36,72a43.61,43.61,0,0,0,8.51.84q12.65,0,19.43-5.22a17,17,0,0,0,6.79-14.21,14.9,14.9,0,0,0-3.29-9.77Q238.52,39.59,231.41,35.41Z"></path>
                        <path style="fill:#1d1d1b" d="M316.16,55.37l-.84-.65a1.71,1.71,0,0,0-2.53.46,26.75,26.75,0,0,1-9,9.43,25,25,0,0,1-13.37,3.81,20.45,20.45,0,0,1-10.6-2.56A21.13,21.13,0,0,1,272.72,59a30.39,30.39,0,0,1-4-9.87,52.32,52.32,0,0,1-1.25-11.54,59.75,59.75,0,0,1,1.77-15.83,27.6,27.6,0,0,1,4.91-10.13,17.27,17.27,0,0,1,7.31-5.38,25.29,25.29,0,0,1,9-1.57q8.67,0,13.94,5.07,4.89,4.7,7,13.22a1.74,1.74,0,0,0,3.43-.41q-.06-3.66-.31-7.12a12.79,12.79,0,0,0-2.4-7,24.47,24.47,0,0,0-8.93-5.9Q297.11,0,287.29,0a32.28,32.28,0,0,0-13.73,2.93,33.64,33.64,0,0,0-10.92,8,37.22,37.22,0,0,0-7.21,11.91,41.09,41.09,0,0,0-2.61,14.78,41.56,41.56,0,0,0,2.3,14,32.62,32.62,0,0,0,6.69,11.28,30.39,30.39,0,0,0,10.81,7.53,37.37,37.37,0,0,0,14.67,2.71q11,0,18.08-4.07A32.11,32.11,0,0,0,316.6,57.63,1.73,1.73,0,0,0,316.16,55.37Z"></path>
                        <polygon style="fill:#febe18" points="59.06 68.34 59.06 3.2 59.63 3.2 71.07 32.61 94.66 15.15 86.03 45.16 116.56 45.72 94.92 64.41 118.06 72.02 43.69 72.02 59.06 68.34 59.06 68.34"></polygon>
                        <polygon style="fill:#0088ce" points="0 3.2 0 72.08 26.51 64.47 1.54 45.73 33.1 45.23 23.43 15.16 47.75 32.62 59.06 3.84 59.06 3.2 0 3.2"></polygon>
                    </svg>
                </a>
                <a href="/home"><button type="button" class="button">Staff Login</button></a>
            </div>    
        </header>
        
        <!-- Password form -->
            <div class="form-box">
                <h1>Login Here</h1>

                <!-- If successful will take user to Admin Form -->
                <form action="/" method="post"> 
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
