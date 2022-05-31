

<div width="250px">
    <form action="<StaffID:int>" method="GET">
        <body>
            <centre>
                <table>

                    <tr>
                        <th>ID</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                    </tr>
                    % for staff in staff_list:
                    <tr>
                        <td><a href="/archive/staff/{{staff[0]}}"><button type="button" class="button">{{staff[0]}}</button></a></td>
                        <td>{{staff[1]}}</td>
                        <td>{{staff[2]}}</td>
                    </tr>
                    % end
                 </table>	
            </centre>
        </body>

        <a onclick="goBack()"><button type="button" class="button">Back</button></a>
        <script>
            function goBack() {
                window.history.back();
            }
        </script>
    </form>
</div>