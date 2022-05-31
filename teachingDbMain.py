from re import TEMPLATE

from mysql.connector.constants import DEFAULT_CONFIGURATION
from bottle import html_escape, redirect, route, run, request, get, post, response, template, HTTPResponse
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

@route('/Admin_Page')
def home():
    return template ('./templates/Admin_Page')

@route('/aqfrecords')
def do_aqfrecords():
     with dbcon() as db:
         # create a handle to the database connection that you open
        conx = db.opendb()
        # Create the database query
        selectQuery = (
            'SELECT AQFLevel_ID, Qualified_Degree, AQFLevel, Qualification_Level_Required_To_Teach FROM AQFLevels')
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
           #SQL query
            'SELECT StaffID, First_Name, Last_Name FROM staff WHERE Archive = FALSE')
        # create a cursor or variable which will recieve the data returned from the database - Microsoft call this a recordset
        dcurs = conx.cursor(buffered=True)
        # execute the query and query variable from within the cursor object
        # dcurs.execute(selectQuery)
        dcurs.execute(selectQuery)
        # check to see if there is any returned data
        if dcurs.rowcount > 0:
            staff_data = dcurs.fetchall()          
        # close the cursor to finalise the query - this does not close the connection to the database
        dcurs.close()
    return template('./templates/staff.tpl', staff_list=staff_data)

@route('/create_staff', method='GET')
def create_staff():
    with dbcon() as db:
        conx = db.opendb()
       
        if request.GET.save:
            #querdata from the database and save it as a variable
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



            #SQL Query, primary key autoincements are excluded
            StaffInsert = (
                "INSERT INTO staff(Title, First_Name, Last_Name, EmailID, Address, PhoneNo, Archive) VALUES (%s, %s, %s, %s, %s, %s, FALSE)" 
            )
             #SQL Query, foreign key autoincements are excluded
            QualInsert = (
                "INSERT INTO Qualification(StaffID, NameOfQualification, AQFLevel_ID, Subject_Area, Institution_Name, Institution_Country, Full_Name_Of_Award, Awarded_Year) VALUES (%(StaffID)s, %(NameOfQualification)s, %(AQFLevel_ID)s, %(Subject_Area)s, %(Institution_Names), %(Institution_Country)s, %(Full_Name_Of_Award)s, %(Awarded_Year)s) "
                         )
         
            # =s% e.g var_First_name = First_name in StaffInsert query, these are also the input tables in create_staff.tpl
            staff_query = (var_title, var_first_name, var_last_name, var_email, var_address, var_phoneno)
           
            # create a cursor or variable which will recieve the data returned from the database
            dcurs = conx.cursor(buffered=True)
            #insert into staff values from staff_query
            dcurs.execute(StaffInsert, staff_query)
            #stores last auto increment
            last_ID = dcurs.lastrowid
            qual_query = (var_NameOfQualification, var_AQFLevel_ID, var_Subject_Area, var_Institution_Name, var_Institution_Country, var_Full_Name_Of_Award, var_Awarded_Year)
            
            dcurs.execute(QualInsert, (last_ID,) + qual_query)
            conx.commit()
            dcurs.close()
            
        return template('./templates/create_staff.tpl')




#Make it so its selecting from multiple tables
@route('/staff/<StaffID:int>')
def show_staff(StaffID):
     with dbcon() as db:
        
    
        conx = db.opendb()     
        
        # Variable for selecting the Staff member
        StaffNumber = (StaffID,)

        # Grabbing Staff Table
        staffQuery = ("Select StaffID, First_name, Last_name, Address, Phoneno FROM Staff WHERE staff.StaffID=%s")
        
        dcurs = conx.cursor(buffered=True)

        # Query for  staff tables
        dcurs.execute(staffQuery, StaffNumber)
        
        #Bringing the Fetched Results into a variable and printing it
        staff = dcurs.fetchall()                  
        
        conx.commit()
        dcurs.close()
        
     return template('./templates/viewstaff.tpl', staff_results=staff)

@route('/staff/edit/<StaffID:int>', method=['GET', 'POST'])
def edit_staff(StaffID):
    with dbcon() as db:
        conx = db.opendb()
        if request.POST.get('save','').strip():
            SFN = request.POST.get('First_Name')
            SLN = request.POST.get('Last_Name')
            SA = request.POST.get('Address')
            SPN = request.POST.get('PhoneNo')
            SID = request.POST.get('StaffID')
            
            StaffNumber = (StaffID,)
            
            Update = ("UPDATE Staff SET First_Name = %s, Last_Name = %s, Address = %s, PhoneNo = %s WHERE StaffID = %s")
            Staff_Fields = (SFN, SLN, SA, SPN, StaffID)
            
            selectQuery = ("Select StaffID, First_Name, Last_Name, Address, PhoneNo FROM Staff")
            
            dcurs = conx.cursor(buffered=True)

            dcurs.execute(Update, Staff_Fields)
            conx.commit()
              
            dcurs.close()
            redirect('/staff')
                    
        else:

            selectQuery = ("Select First_name, Last_name, Address, Phoneno FROM Staff WHERE StaffID=%s")

            StaffNumber = (StaffID,)

            dcurs = conx.cursor(buffered=True)
            dcurs.execute(selectQuery, StaffNumber)
            rec = dcurs.fetchall()
            conx.commit()
            dcurs.close()
            return template('./templates/edit.tpl', StaffID=StaffID, staff_list=rec)

@route('/staff/archive/<StaffID:int>', method=['GET', 'POST'])
def edit_staff(StaffID):
    with dbcon() as db:
        conx = db.opendb()
        if request.POST.get('save','').strip():
            SAR = request.POST.get('Archive')
            SID = request.POST.get('StaffID')
            
            
            Update = ("UPDATE Staff SET Archive = TRUE WHERE StaffID = %s")
            Staff_Fields = (StaffID,)
                       
            dcurs = conx.cursor(buffered=True)

            dcurs.execute(Update, Staff_Fields)
            conx.commit()
              
            dcurs.close()
            redirect('/staff')
        else:
            selectQuery = ("Select First_name, Last_name FROM Staff WHERE StaffID=%s")
            StaffNumber = (StaffID,)
            dcurs = conx.cursor(buffered=True)
            dcurs.execute(selectQuery, StaffNumber)
        
            if dcurs.rowcount > 0:
                staff_data = dcurs.fetchall()          
            dcurs.close()
            return template('./templates/confirmarchive.tpl', StaffID=StaffID, staff_list=staff_data)

@route('/archive')
def get_Archive():
    return template ('./templates/archive.tpl')

@route('/archive/staff')
def get_Archivestaff():
    with dbcon() as db:
        # create a handle to the database connection that you open
        conx = db.opendb()
        # Create the database query
        selectQuery = (
           #SQL query
            'SELECT StaffID, First_Name, Last_Name FROM staff WHERE Archive = TRUE')
        # create a cursor or variable which will recieve the data returned from the database - Microsoft call this a recordset
        dcurs = conx.cursor(buffered=True)
        # execute the query and query variable from within the cursor object
        # dcurs.execute(selectQuery)
        dcurs.execute(selectQuery)
        # check to see if there is any returned data
        staff_data = dcurs.fetchall()          
        # close the cursor to finalise the query - this does not close the connection to the database
        dcurs.close()
    return template('./templates/archivestaff.tpl', staff_list=staff_data)



@route('/archive/staff/<StaffID:int>', method=['GET', 'POST'])
def show_staff(StaffID):
     with dbcon() as db:
        conx = db.opendb()
        if request.POST.get('save','').strip():
            SAR = request.POST.get('Archive')
            SID = request.POST.get('StaffID')
            
            
            Update = ("UPDATE Staff SET Archive = FALSE WHERE StaffID = %s")
            Staff_Fields = (StaffID,)
                       
            dcurs = conx.cursor(buffered=True)

            dcurs.execute(Update, Staff_Fields)
            conx.commit()
              
            dcurs.close()

            redirect('/archive/staff')
        else:
            selectQuery = ("Select StaffID, First_name, Last_name, Address, Phoneno FROM Staff WHERE StaffID=%s")
            StaffNumber = (StaffID,)
            dcurs = conx.cursor(buffered=True)
            dcurs.execute(selectQuery, StaffNumber)
        
            if dcurs.rowcount > 0:
                staff_data = dcurs.fetchall()          
            dcurs.close()
            return template('./templates/viewarchivestaff.tpl', StaffID=StaffID, staff_list=staff_data)
         

        



   
run(host='localhost', port=8080, debug=True)