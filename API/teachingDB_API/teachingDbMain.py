from re import TEMPLATE
from bottle import html_escape, route, run, request, get, post, response, template, HTTPResponse
# from xml.dom import minidom, Node
from classDb import DatabaseConnect as dbcon


@route('/', method="get")
def login():
 return template('./templates/Login')

def check_login(username, password):
 pass
#does not work, someone else take a look at it got bored so i made incorrect user/pass work


@route('/login', method="post")
def do_login():
    Username = request.forms.get('username')
    Password = request.forms.get('password')
    if check_login(Username, Password):
        return "<p>Your login information was correct.</p>"
    else:
        return template('./templates/Admin_Page')

@route('/admin_page/aqfrecords')
def do_aqfrecords():
     with dbcon() as db:
        conx = db.opendb()
        selectQuery = (
            'SELECT AQFLevel_ID, Qualified_Degree, AQFLevel, Qualification_Level_Required_To_Teach FROM AQFLevels')
            #'SELECT aqflevels.AQFLevel, COUNT(qualification.AQFLevel_ID) AS total_staff FROM aqflevels INNER JOIN qualification ON aqflevels.AQFLevel_ID = qualification.AQFLevel_IDGROUP BY AQFLevel')
        dcurs = conx.cursor(buffered=True)
        dcurs.execute(selectQuery)
        if dcurs.rowcount > 0:
            aqf_data = dcurs.fetchall()
        dcurs.close()
     return template('./templates/aqfrecords', aqf_list=aqf_data)

def new_func():
    return total


@route('/staff')
def get_first_page():
    with dbcon() as db:
        # create a handle to the database connection that you open
        conx = db.opendb()
        # Create the database query
        selectQuery = (
            # 'SELECT First_Name, Last_Name FROM staff WHERE aipubmedid = %s'
            'SELECT StaffID, First_Name, Last_Name FROM staff')
        # data_query is the variable that will take the place of %s above
        # data_query = (some_variabl_id,)
        # create a cursor or variable which will recieve the data returned from the database - Microsoft call this a recordset
        dcurs = conx.cursor(buffered=True)
        # execute the query and query variable from within the cursor object
        # dcurs.execute(selectQuery, data_query)
        dcurs.execute(selectQuery)
        # check to see if there is any returned data
        if dcurs.rowcount > 0:
            staff_data = dcurs.fetchall()
            # incriment through each row and get the returned data
            #for s in dcurs:
            #    fName = (First_Name)
            #    print(s)
        # else:
            # if there is no data returned from the database then do something else
            
        # close the cursor to finalise the query - this does not close the connection to the database
        dcurs.close()
    return template('./templates/staff.tpl', staff_list=staff_data)


@route('/staff/getstaff')
def get_staff():
    staffID = request.query.staffid
    print(staffID)
    
    with dbcon() as db:
        # create a handle to the database connection that you open
        conx = db.opendb()
        # Create the database query
        selectQuery = (
            # 'SELECT First_Name, Last_Name FROM staff WHERE aipubmedid = %s'
            'SELECT StaffID, First_Name, Last_Name FROM WHERE StaffID = %s')
        # data_query is the variable that will take the place of %s above
        data_query = (staffID,)
        # create a cursor or variable which will recieve the data returned from the database - Microsoft call this a recordset
        dcurs = conx.cursor(buffered=True)
        # execute the query and query variable from within the cursor object
        dcurs.execute(selectQuery, data_query)
        # check to see if there is any returned data
        if dcurs.rowcount > 0:
            staff_member = dcurs.fetchone()
            print (staff_member)
            # incriment through each row and get the returned data
            #for s in dcurs:
            #    fName = (First_Name)
            #    print(s)
        # else:
            # if there is no data returned from the database then do something else
            
        # close the cursor to finalise the query - this does not close the connection to the database
        dcurs.close()
        response.headers['Access-Control-Allow-Origin'] = '*'
        response.headers['Content-type'] = 'application/text'
        
    return staff_member

# This saves the xml file without modification
# @route('/saveStaff')
# def save_staff():


@route('/create_staff', method='GET')
def create_staff():

    with dbcon() as db:
        conx = db.opendb()
       
        if request.GET.save:

            var_title = request.query.Title
            var_first_name = request.query.First_Name
            var_last_name = request.query.Last_Name
            var_email = request.query.EmailID
            var_address = request.query.Address
            var_phoneno = request.query.PhoneNo

            var_NameOfQualification = request.query.NameOfQualification
            var_AQFLevel_ID = request.query.AQFLevel_ID
            var_Subject_Area = request.query.Subject_Area
            var_Institution_Name = request.query.Institution_Name
            var_Institution_Country = request.query.Institution_Country
            var_Full_Name_Of_Award = request.query.Full_Name_Of_Award
            var_Awarded_Year = request.query.Awarded_Year

            
            StaffInsert = (
                "INSERT INTO staff(Title, First_Name, Last_Name, EmailID, Address, PhoneNo) VALUES (%s, %s, %s, %s, %s, %s)" 
            )
            QualInsert = (
                "INSERT INTO Qualification(NameOfQualification, AQFLevel_ID, Subject_Area, Institution_Name, Institution_Country, Full_Name_Of_Award, Awarded_Year) VALUES (%s, %s, %s, %s, %s, %s, %s) "
                         )
         
            

            dcurs = conx.cursor(buffered=True)

            staff_query = (var_title, var_first_name, var_last_name, var_email, var_address, var_phoneno)
            qual_query = (var_NameOfQualification, var_AQFLevel_ID, var_Subject_Area, var_Institution_Name, var_Institution_Country, var_Full_Name_Of_Award, var_Awarded_Year)
            


            dcurs = conx.cursor(buffered=True)

            dcurs.execute(StaffInsert, staff_query)
            dcurs.execute(QualInsert, qual_query)
            StaffID = dcurs.lastrowid
            conx.commit()
            dcurs.close()
            
        return template('./templates/create_staff.tpl')

@route('/staff/<StaffID>', method='get')
def edit_staff(StaffID):
    with dbcon() as db:
        
        
        conx = db.opendb()
        

        selectQuery = (
            "SELECT StaffID, First_Name, Last_Name FROM staff")

        if StaffID in selectQuery:
            print(selectQuery[StaffID])

            
            
        dcurs = conx.cursor(buffered=True)

        dcurs.execute(selectQuery)

        if dcurs.rowcount > 0:
            staffdetails = dcurs.fetchall()


            
        dcurs.close()
  
        return template('./templates/viewstaff.tpl', staff_list=staffdetails)
        

   
run(host='localhost', port=8080, debug=True)