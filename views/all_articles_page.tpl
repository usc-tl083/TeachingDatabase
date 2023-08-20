<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-teal.css">

    <title>Articles</title>
    <style>
        #articleDiv tr:hover {background-color: #ddd;}
        #articleDiv thead {
            position: sticky;
            top: 0;
            z-index: 2;
        }

        #myBtn {
            display: none; /* Hidden by default */
            position: fixed; /* Fixed/sticky position */
            bottom: 20px; /* Place the button at the bottom of the page */
            right: 30px; /* Place the button 30px from the right */
            z-index: 99; /* Make sure it does not overlap */
            border: none; /* Remove borders */
            outline: none; /* Remove outline */
            background-color: red; /* Set a background color */
            color: white; /* Text color */
            cursor: pointer; /* Add a mouse pointer on hover */
            padding: 15px; /* Some padding */
            border-radius: 10px; /* Rounded corners */
            font-size: 18px; /* Increase font size */
            }

            #myBtn:hover {
            background-color: #555; /* Add a dark-grey background on hover */
        }
    </style>
</head>
<body class="w3-container">
     <button onclick="topFunction()" id="myBtn" title="Go to top">Top</button> 

    <!-- Header -->
    <header class="w3-container w3-theme w3-padding">
        <div class="w3-center">
            <h1 id="allarticlestitle" class="w3-xxxlarge w3-animate-bottom">{{tpltitle}}</h1>
        </div>
        <div class="w3-center "w3-container">
            <a class="w3-button w3-theme" onclick="displayAllArticles()">Refresh Articles</a>
            <a class="w3-button w3-theme" onclick="getArticlePage(0)">New Article</a>
        </div>
    </header>
    <br>

    <div id="articleDiv" class="w3-center">
        
    </div>

    

    <script>

        function displayAllArticles() {
            table_id = "ArticleTable"
            document.getElementById('articleDiv').innerHTML = "";
            var myData = {
                "apiRequest"  : {
                    "requestFunction" : {
                        "functionName"      : "DisplayAllArticles",
                        "returnType"        : "DivSection",
                        "returnDataType"    : "http",
                        "targetDivID"       : "articleDiv",
                        "postRunFunction"   : ["tableRowCount(table_id)"]
                    }
                }
            };
            //console.log(myData);
            resourceRequest(myData);
        }

        function getArticlePage(articleID) {
            var myData = {
                "apiRequest"  : {
                    "requestFunction" : {
                        "functionName"  : "GetArticle",
                        "returnType"    : "NewPage"
                    },
                    "requestData"      : {
                        "pkliteratureid"    : articleID
                    }
                }
            };
            resourceRequest(myData);
        }

        function resourceRequest(jsonData) {
            const xhttp = new XMLHttpRequest();
            xhttp.onload = function() {
                // console.log(xhttp.responseText);
                // console.log(jsonData.apiRequest.requestFunction.returnType);
                // console.log(xhttp.status);
                if (xhttp.status == 200) {
                    if (jsonData.apiRequest.requestFunction.returnType == "NewPage") {
                        const myNewPage = window.open();
                        myNewPage.document.open();
                        myNewPage.document.write(xhttp.response);
                        myNewPage.document.close();
                    }
                    else if (jsonData.apiRequest.requestFunction.returnType == "DivSection") {
                        // console.log(xhttp.responseText);
                        const myDivParent = document.getElementById(jsonData.apiRequest.requestFunction.targetDivID);
                        myDivParent.innerHTML = xhttp.responseText;
                        for (const element of jsonData.apiRequest.requestFunction.postRunFunction) {
                            //console.log(element);
                            const F = new Function(element);  
                            F();
                        }
                    }
                    else if (jsonData.apiRequest.requestFunction.returnType == "Text") {
                        // console.log(xhttp.responseText);
                        for (const element of jsonData.apiRequest.requestFunction.postRunFunction) {
                            //console.log(element);
                            const F = new Function(element);  
                            F();
                        }
                    }
                }
                else if (xhttp.status == 204) {
                    if (jsonData.apiRequest.requestFunction.returnType == "DivSection") {
                        const myDivParent = document.getElementById(jsonData.apiRequest.requestFunction.targetDivID);
                        myDivParent.innerHTML = "";
                        for (const element of jsonData.apiRequest.requestFunction.postRunFunction) {
                            //console.log(element);
                            const F = new Function(element);  
                            F();
                        }
                    }
                }
                
            }
            xhttp.open("POST", "/");
            xhttp.setRequestHeader("Content-Type", "application/json");
            xhttp.send(JSON.stringify(jsonData));
        }

        function tableRowCount(table_id) {
            myelement = document.getElementById(table_id)
            var rows = 1
            if (myelement) {
                rows = myelement.rows.length;
            }
            document.getElementById("allarticlestitle").innerHTML = rows - 1 + " Articles";
        }

        // 'Go to top' Button
        // Get the button:
        let mybutton = document.getElementById("myBtn");

        // When the user scrolls down 20px from the top of the document, show the button
        window.onscroll = function() {scrollFunction()};

        function scrollFunction() {
        if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
            mybutton.style.display = "block";
        } else {
            mybutton.style.display = "none";
        }
        }

        // When the user clicks on the button, scroll to the top of the document
        function topFunction() {
        document.body.scrollTop = 0; // For Safari
        document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
        } 

        displayAllArticles();


    </script>
</body>
</html>