<!DOCTYPE html>

<html>
    <!-- Page Style-->
    <head>
        <title>
            Teaching Database Home Page
        </title>

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
    
            body {
               /* background-image: img src="templates/images/pic-1.png"; */
                background-size: cover;
                background-position: center;
                font-family: sans-serif;
            }

            .form-box {
                width: 500px;
                background: rgba(0,0,0,0.8);
                margin: 12% auto;
                padding: 50px 0;
                color: #fff;
                box-shadow: 0 0 20px 2px rgba(0,0,0,0.5);
            }

            h1 {
                text-align: center;
            }

        </style>
    </head>

    <!-- Title -->
    <body>
        <!-- Password -->
            <div class="form-box">
                <h1>Login Here</h1>

                <form action="/login" method="post"> 
                    <table>
                        <tr>
                            <td>Username:</td>
                            <td>
                                <input name="username" type="text" />
                            </td>
                        </tr>
                        <tr>
                            <td>Password:</td>
                            <td>
                                <input name="password" type="password" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input value="login" type="submit" />
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
    </body>
</html>
