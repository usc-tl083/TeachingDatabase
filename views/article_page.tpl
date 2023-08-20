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

    <div class="w3-theme">
        <div class="w3-container">
            <h2><a href="https://doi.org/{{article[0]['DOI']}}" target="_blank">{{tpltitle}}</a></h2>
        </div>
        <!-- <form class="w3-container"> -->
            <div class="w3-container">
                <p><label><b>Proccessed</b></label>
                <input onchange='saveArticleData(this);' type="checkbox" id="processed" {{article[0]['processed']}}></input></p>
            </div>
            <div class="w3-container">     
                <label><b>Title</b></label>
                <input class="w3-input" onchange='saveArticleData(this);' value='{{article[0]['title']}}' type="text" id="title" />
            </div>
            <div class="w3-container">   
                <label><b>Authors</b></label>    
                <input class="w3-input" onchange='saveArticleData(this);' value='{{article[0]['authors']}}' type="text" id="authors" />
            </div>
            <!-- <div class="w3-container"> -->
            <!--     <label><b>Comments</b></label> -->   
            <!--     <input class="w3-input" onchange='saveArticleData(this);' value='{{article[0]['comments']}}' type="text" id="comments" /> -->       
            <!-- </div> -->

            <div>
            <div class="w3-container"> 
                <div class="w3-quarter">   
                    <label><b>Publish Date</b></label>    
                    <input class="w3-input" onchange='saveArticleData(this);' value='{{article[0]['publishdate']}}' type="text" id="publishdate" />
                </div>
                <div class="w3-quarter">   
                    <label><b>Relevance</b></label>    
                    <input class="w3-input" onchange='saveArticleData(this);' value='{{article[0]['relevance']}}' type="text" id="relevance" />
                </div>
                <div class="w3-half">   
                    <label><b>Search term</b></label>    
                    <input class="w3-input" onchange='saveArticleData(this);' value='{{article[0]['searchterms']}}' type="text" id="searchterms" />
                </div>
            </div>
            </div>

            <div class="w3-container w3-padding">   
                <label><b>Absract</b></label>    
                <textarea class="w3-input" onchange='saveArticleData(this);' type="text" rows="5" id="abstract">{{article[0]['abstract']}}</textarea>
            </div>
            
            <!-- <a class="w3-button w3-theme" onclick="getNotesTable()">Articles</a> <!-- 
        <!-- </form> -->
    </div>

    <div>
        <h2 class="w3-theme">Literature Notes 
            <button id="addNote" style="font-size: medium" class="w3-btn" onclick="addNote()">(Add)</button>
            <button id="refreshNote" style="font-size: medium" class="w3-btn" onclick="getNotesTable()">(Refresh)</button>
        </h2>
        <div id="noteTableDiv" class="w3-responsive w3-card-4">
            
        </div>
    </div>


    <!-- The Modal -->
    <div id="modalDiv" class="w3-modal">

    </div>
    

	<script>

        function saveArticleData(element) {
            var myData = { 
                "apiRequest"  : {
                    "requestFunction" : {
                        "functionName"      : "SaveArticle",
                        "returnType"        : "Text",
                        "postRunFunction"   : []
                    },
                    "requestData"      : {
                        "pkliteratureid"    : {{article[0]['pkliteratureid']}}
                    }
                }
            };
            
            if (element.type == "checkbox") {
                myData["apiRequest"]["requestData"][element.id] = element.checked;
            } else {
                myData["apiRequest"]["requestData"][element.id] = element.value;
            }
            // console.log(myData);
            resourceRequest(myData);
        }

        function saveNoteData(element, noteID) {
            var myData = { 
                "apiRequest"  : {
                    "requestFunction" : {
                        "functionName"      : "SaveNote",
                        "returnType"        : "Text",
                        "postRunFunction"   : ["getNotesTable()"]
                    },
                    "requestData"      : {
                        "pkliteraturenoteid"    : noteID
                    }
                }
            };
            myData["apiRequest"]["requestData"][element.id] = element.value;
            console.log(myData);
            resourceRequest(myData);
        }

        function addNote() {
            element = document.getElementById('nonvalue')
            var myData = {
                "apiRequest"  : {
                    "requestFunction" : {
                        "functionName"      : "AddNote",
                        "returnType"        : "DivSection",
                        "returnDataType"    : "http",
                        "targetDivID"       : "modalDiv",
                        "postRunFunction"   : ["document.getElementById('modalDiv').style.display='block'",
                                                "getNotesTable()"]
                    },
                    "requestData"      : {
                        "pkliteraturenoteid"    : 0,
                        "literatureid"          : {{article[0]['pkliteratureid']}},
                        "lit_theme"             : '',
                        "lit_quote"             : '',
                        "lit_note"              : '',
                        "lit_page"              : ''
                    }
                }
            };
            resourceRequest(myData);
        }

        function editArticleNote(noteID) {
            var myData = {
                "apiRequest"  : {
                    "requestFunction" : {
                        "functionName"      : "EditArticleNote",
                        "returnType"        : "DivSection",
                        "returnDataType"    : "http",
                        "targetDivID"       : "modalDiv",
                        "postRunFunction"   : ["document.getElementById('modalDiv').style.display='block'"]
                    },
                    "requestData"      : {
                        "pkliteraturenoteid": noteID
                    }
                }
            };
            resourceRequest(myData);
        }

        function deleteArticleNote(noteID, confirmDelete = False) {
            if (confirmDelete) {
                var myData = {
                    "apiRequest"  : {
                        "requestFunction" : {
                            "functionName"      : "DeleteArticleNote",
                            "returnType"        : "Text",
                            "postRunFunction"   : ["document.getElementById('modalDiv').style.display='none'",
                                                    "getNotesTable()"]
                        },
                        "requestData"      : {
                            "pkliteraturenoteid": noteID
                        }
                    }
                };
            resourceRequest(myData);
            }
        }

        function getNotesTable() {
            var myData = {
                "apiRequest"  : {
                    "requestFunction" : {
                        "functionName"      : "GetNotesTable",
                        "returnType"        : "DivSection",
                        "returnDataType"    : "http",
                        "targetDivID"       : "noteTableDiv",
                        "postRunFunction"   : []
                    },
                    "requestData"      : {
                        "literatureid"      : {{article[0]['pkliteratureid']}}
                    }
                }
            };
            // console.log(myData);
            resourceRequest(myData);
        }

        function addCategory(catTypeID, catName) {
            //console.log(catTypeID);
            //console.log(catName);
            if (catName !== "") {
                var myData = {
                    "apiRequest"  : {
                        "requestFunction" : {
                            "functionName"      : "AddCategory",
                            "returnType"        : "Text",
                            "postRunFunction"   : ["catTypeAccordion(" + catTypeID + ")"]
                        },
                        "requestData"      : {
                            "pkcategoryid"          : 0,
                            "pkcategorytypeid"      : catTypeID,
                            "categoryname"          : catName,
                            "catcurrent"            : true
                        }
                    }
                };
                resourceRequest(myData);
            }
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
                            //console.log(jsonData.apiRequest.requestFunction.postRunFunction);
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