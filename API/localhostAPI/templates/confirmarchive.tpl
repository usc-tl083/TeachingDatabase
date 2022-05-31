<Title>Edit User:</Title>
%#


<div width="250px">
    <center>
        <form action="{{StaffID}}" method="POST">
            <body>           
                % for staffdetails in staff_list:
                <h3>Are you sure you want to archive {{staffdetails[0]}} {{staffdetails[1]}}</h3>
                % end                
            </body>
            <input type="submit" name="save" value="confirm">
            <a onclick="goBack()"><button type="button" class="button">Back</button></a>   
        </form>
    </center>
</div>

<script>
function goBack() {
    window.history.back();
}
</script>

