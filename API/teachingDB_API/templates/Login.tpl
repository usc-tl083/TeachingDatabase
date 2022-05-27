<!DOCTYPE html>
<html>

<!-- Page Style-->
<head>
    <title>
        Teaching Database Home Page
    </title>

    <style>
        .textStyle {
            color: black;
            text-align: center;
            font-family: sans-serif;
            font-size: 30px;
        }

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
    
        .topleft {
            position: absolute;
            top: 0px;
            left: 0px;
            font-size: 18px;
        }    
</style>
</head>

<!-- Title -->
<body>
    <center><img src="https://i.imgur.com/GrJSEiU.png"/></center>
    <center><img src="https://i.imgur.com/6BxZHQt.png"/></center>

    </br>
    </br>
    <!-- Password -->
    <center>
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
    </center>
</body>
</html>
