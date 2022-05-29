from re import TEMPLATE

from mysql.connector.constants import DEFAULT_CONFIGURATION
from bottle import html_escape, route, run, request, get, post, response, template, HTTPResponse
# from xml.dom import minidom, Node
from classDb import DatabaseConnect as dbcon


@route('/', method="get")
def login():
 return template('./templates/Admin_Login')

def check_login(username, password):
 pass
#does not work, someone else take a look at it got bored so i made incorrect user/pass work


@route('/', method="post")
def do_login():
    Username = request.forms.get('username')
    Password = request.forms.get('password')
    if check_login(Username, Password):
        return "<p>Your login information was correct.</p>"
    else:
        return template('./templates/Admin_Page')



@route('/home')
def home():
    return template ('./templates/Admin_Page')

@route('/admin_portal/aqfrecords')
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




@route('/staff')
def get_first_page():
    with dbcon() as db:
        # create a handle to the database connection that you open
        conx = db.opendb()
        # Create the database query
        selectQuery = (
            # 'SELECT First_Name, Last_Name FROM staff WHERE aipubmedid = %s'
            'SELECT StaffID, First_Name, Last_Name FROM staff WHERE Archive = FALSE')
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
                "INSERT INTO staff(Title, First_Name, Last_Name, EmailID, Address, PhoneNo, Archive) VALUES (%s, %s, %s, %s, %s, %s, FALSE)" 
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


@route('/Archive')
def get_Archive():
     with dbcon() as db:
    
        conx = db.opendb()
        
        selectQuery = ('SELECT StaffID, First_Name, Last_Name FROM staff WHERE Archive = TRUE')

    

        dcurs = conx.cursor(buffered=True)

        dcurs.execute(selectQuery)
      
        if dcurs.rowcount > 0:
            staff_data = dcurs.fetchall()
             
           
        dcurs.close()
     return template('./templates/staff.tpl', staff_list=staff_data)

#i just can't get it to work need help
@route('/staff/<StaffID:int>')
def show_staff(StaffID):
     with dbcon() as db:
        
    
        conx = db.opendb()       

        # Grabbing the specific User Query
        selectQuery = ("Select StaffID, First_name, Last_name, Address, Phoneno FROM Staff WHERE staff.StaffID=%s")
        

        # Bringing StaffID into a string to bring into our Query
        StaffNumber = (StaffID,)

        dcurs = conx.cursor(buffered=True)

        #Query being called and selecting StaffID into the Query (Running it once to open that staff only)
        dcurs.execute(selectQuery, StaffNumber)

        #Bringing the Fetched Results into a variable and printing it
        result = dcurs.fetchall()
        
        
        conx.commit()
        dcurs.close()
        
     return template('./templates/viewstaff.tpl', staff_list=result)

@route('/staff/edit<StaffID:int>', method=['GET', 'POST'])
def edit_staff(StaffID):
    with dbcon() as db:
        conx = db.opendb()
        
        if request.POST.get('save','').strip():
            SFN = request.POST.get('First_Name')
            SLN = request.POST.get('Last_Name')
            SA = request.POST.get('Address')
            SPN = request.POST.get('Phoneno')
            
            Update = ('Update staff set First_Name=%s,Last_Name=%s, Address=%s, Phoneno=%s WHERE staff.StaffID=%s')
            
            selectQuery = ("Select StaffID, First_name, Last_name, Address, Phoneno FROM Staff WHERE staff.StaffID=%s")

            StaffNumber = (StaffID,)

            Staff_Fields = (SFN,SLN,SA,SPN,StaffNumber)
            
            dcurs = conx.cursor(buffered=True)

            dcurs.execute(Update, Staff_Fields)

            conx.commit()
            
            rec =  dcurs.execute(selectQuery, StaffNumber)
            dcurs.close()

            return template('./templates/viewstaff.tpl', staff_list=rec)
        else:
            selectQuery = ("Select StaffID, First_name, Last_name, Address, Phoneno FROM Staff WHERE staff.StaffID=%s")

            StaffNumber = (StaffID,)

            dcurs = conx.cursor(buffered=True)
            dcurs.execute(selectQuery, StaffNumber)
            rec = dcurs.fetchall()
            dcurs.close()
            return template('./templates/edit.tpl', StaffNumber=StaffNumber, staff_list=rec)



   
run(host='localhost', port=8080, debug=True)