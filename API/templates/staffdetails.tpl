%rebase('base.tpl',Page_Title = 'Teaching Database')

<center>
    <div class="StaffID"><p>{{si}}</p></div>
    <div class="First_Name"><p>{{sfn}}</p></div>
    <div class="Last_Name"><p>{{sln}}</p></div>
    <div class="EmailID"><p>{{sem}}</p></div>
    <div class="Address"><p>{{sad}}</p></div>
    <div class="PhoneNo"><p>{{sph}}</p></div>
    <div class="Archive"><p>{{sar}}</p></div>



    <a onclick="goBack()"><button type="button" class="button">Back</button></a>
    <script>
        function goBack() {
            window.history.back();
        }
</script>
</center>