<!DOCTYPE html>
<html lang="en">
<head>
    <title>{{tpltitle}}</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-teal.css">
</head>
<body class="w3-container">
    <!-- Header -->
    <header class="w3-container w3-theme w3-padding" id="myHeader">
        <div class="w3-center">
            <h4 class="w3-xxxlarge w3-animate-bottom">{{tpltitle}}</h4>
        </div>
    </header>
    
    <!-- Buttons -->
    <div class="w3-center">
        <br>
        <div class="w3-container" id="projectbuttons" style="display: block">
            <!-- <a href="/articles" target="_blank" class="w3-button w3-theme">Articles</a> -->
            <a class="w3-button w3-theme" onclick="getAllArticlesPage()">Articles</a>
        </div>
        <br>
        <div class="w3-container">
            <a href="/w3stemplate" target="_blank" class="w3-button w3-theme">W3 Schools Web Template</a>
            <a href="/w3smodal" target="_blank" class="w3-button w3-theme">W3 Schools Modal</a>
        </div>
        <br>
    </div>
    <!-- Modal -->
    <div id="modalDiv" class="w3-modal">
        
    </div>

<script>
    function getAllArticlesPage() {
        var myData = {
            "apiRequest"  : {
                "requestFunction" : {
                    "functionName"  : "GetAllArticles",
                    "returnType"     : "NewPage",
                    "returnDataType" : "http"
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
                }
            }
            
        }
        xhttp.open("POST", "/");
        xhttp.setRequestHeader("Content-Type", "application/json");
        xhttp.send(JSON.stringify(jsonData));
    }

</script>
    

</body>
</html>