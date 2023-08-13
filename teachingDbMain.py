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
            #query data from the database and save it as a variable
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



            #SQL Query, all primary key that are autoincements are excluded, (StaffID)
            StaffInsert = (
                "INSERT INTO staff(Title, First_Name, Last_Name, EmailID, Address, PhoneNo, Archive) VALUES (%s, %s, %s, %s, %s, %s, FALSE)" 
            )
             #SQL Query StaffID auto increment foriegn key need to query it to link the tables
            QualInsert = (
                "INSERT INTO Qualification(StaffID, NameOfQualification, AQFLevel_ID, Subject_Area, Institution_Name, Institution_Country, Full_Name_Of_Award, Awarded_Year) \
                 VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
            )
         
            # =s% e.g var_First_name = First_name in StaffInsert query, (creates tupel)
            staff_query = (var_title, var_first_name, var_last_name, var_email, var_address, var_phoneno)
           
            # create a cursor or variable which will recieve the data returned from the database
            dcurs = conx.cursor(buffered=True)
            #insert into staffinsert values from staffInsert 
            dcurs.execute(StaffInsert, staff_query)
            #stores last auto increment = StaffID
            StaffID = dcurs.lastrowid
            #creates creates tuple
            qual_query = (StaffID, var_NameOfQualification, var_AQFLevel_ID, var_Subject_Area, var_Institution_Name, var_Institution_Country, var_Full_Name_Of_Award, var_Awarded_Year)          
            dcurs.execute(QualInsert, qual_query)
            #commits changes
            conx.commit()
            dcurs.close()
            
        return template('./templates/create_staff.tpl')




#Make it so its selecting from multiple tables
@route('/staff/<StaffID:int>')
def show_staff(StaffID):
     with dbcon() as db:   
        conx = db.opendb()     
        
        

        # Variable for selecting the Staff member, value for show_staff(StaffID)
        StaffNumber = (StaffID,)

        #Selects staff where StaffID=%s, %s= StaffNumber 
        staffQuery = ("Select StaffID, First_name, Last_name, EmailID, Address, Phoneno FROM Staff WHERE staff.StaffID=%s")
        #join AQFLevels on to Qualifications where AQFLevel_ID = AQFLevel_ID in qualifications, select rows where StaffID=%s
        QualQuery = ("Select AQFLevels.AQFLevel, NameOfQualification, Subject_Area, Institution_Name, Institution_Country, Full_Name_Of_Award, Awarded_Year FROM AQFLevels join Qualification on AQFLevels.AQFLevel_ID = Qualification.AQFLevel_ID \
        WHERE Qualification.StaffID=%s")
        #join Organisation name on to Relevant_Teaching_Experience where Organisation_ID = Organisation_ID in qualifications, select rows where StaffID=%s
        TeachExQuery = ("Select Organisation.Name, Joining_Date, Finish_Date FROM Organisation join Relevant_Teaching_Experience on Organisation.Organisation_ID = Relevant_Teaching_Experience.Organisation_ID \
        WHERE Relevant_Teaching_Experience.StaffID=%s")
        #join Role_Name on to Relevant_Teaching_Experience where Role_Name = Role_Name in Relevant_Teaching_Experience, select rows where StaffID=%s
        PrevroleQuery = ("Select Roles.Role_Name FROM Roles join Relevant_Teaching_Experience on Roles.Role_ID = Relevant_Teaching_Experience.Role_ID \
        WHERE Relevant_Teaching_Experience.StaffID=%s")
        #join Course_Name on to Relevant_Teaching_Experience where Course_Name = Course_Name in Relevant_Teaching_Experience, select rows where StaffID=%s
        CourseQuery = ("Select Courses.Course_Name FROM Courses join Relevant_Teaching_Experience on Courses.Course_ID = Relevant_Teaching_Experience.Course_ID \
        WHERE Relevant_Teaching_Experience.StaffID=%s")

        dcurs = conx.cursor(buffered=True)

        # Query for  staff tables
        dcurs.execute(staffQuery, StaffNumber)
        
        #Bringing the Fetched Results into a variable and printing it
        staff = dcurs.fetchall()  

        dcurs.execute(QualQuery, StaffNumber)       
        qual = dcurs.fetchall()

        dcurs.execute(TeachExQuery, StaffNumber)
        teachex = dcurs.fetchall()

        dcurs.execute(PrevroleQuery, StaffNumber)
        prevrole = dcurs.fetchall()

        dcurs.execute(CourseQuery, StaffNumber)
        prevcourse= dcurs.fetchall()

        conx.commit()
        dcurs.close()
     #return tpl file where variable in tpl =  variable   
     return template('./templates/viewstaff.tpl', staff_results=staff, qual_results=qual, teachex_results=teachex, role_results=prevrole, course_results=prevcourse)

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

            # = edit_staff(StaffID)
            #(StaffID,) must conatin ,
            StaffNumber = (StaffID,)
            #update these variables where =$s
            Update = ("UPDATE Staff SET First_Name = %s, Last_Name = %s, Address = %s, PhoneNo = %s WHERE StaffID = %s")
            #creates tuple from varibales.
            Staff_Fields = (SFN, SLN, SA, SPN, StaffID)

            #select from row
            selectQuery = ("Select StaffID, First_Name, Last_Name, Address, PhoneNo FROM Staff")
            
            dcurs = conx.cursor(buffered=True)

            dcurs.execute(Update, Staff_Fields)

            conx.commit()
              
            dcurs.close()
            redirect('/staff')
                    
        else:
            #this is the webpage the will be displayed
            ##select from row where 
            selectQuery = ("Select First_name, Last_name, Address, Phoneno FROM Staff WHERE StaffID=%s")

            # = edit_staff(StaffID)
            StaffNumber = (StaffID,)

            dcurs = conx.cursor(buffered=True)
            dcurs.execute(selectQuery, StaffNumber)
            rec = dcurs.fetchall()
            #commits changes
            conx.commit()
            dcurs.close()
            return template('./templates/edit.tpl', StaffID=StaffID, staff_list=rec)

@route('/staff/archive/<StaffID:int>', method=['GET', 'POST'])
def edit_staff(StaffID):
    with dbcon() as db:
        conx = db.opendb()
        if request.POST.get('save','').strip():
            
            #update staff member archive status to true where id =
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

            
            #update staff member archive status to false where id =
            Update = ("UPDATE Staff SET Archive = FALSE WHERE StaffID = %s")
            Staff_Fields = (StaffID,)
            # create a cursor or variable which will recieve the data returned from the database           
            dcurs = conx.cursor(buffered=True)
            # execute the query and query variable from within the cursor object
            dcurs.execute(Update, Staff_Fields)
            #commits changes to the databse
            conx.commit()
            # close the cursor to finalise the query - this does not close the connection to the database  
            dcurs.close()

            redirect('/archive/staff')
        else:
            #Select data from table where StaffID =
            selectQuery = ("Select StaffID, First_name, Last_name, Address, Phoneno FROM Staff WHERE StaffID=%s")
            StaffNumber = (StaffID,)
            # create a cursor or variable which will recieve the data returned from the database
            dcurs = conx.cursor(buffered=True)
            # execute the query and query variable from within the cursor object
            dcurs.execute(selectQuery, StaffNumber)        
            staff_data = dcurs.fetchall()
            # close the cursor to finalise the query - this does not close the connection to the database
            dcurs.close()
            return template('./templates/viewarchivestaff.tpl', StaffID=StaffID, staff_list=staff_data)
         

        



   
run(host='localhost', port=8080, debug=True)