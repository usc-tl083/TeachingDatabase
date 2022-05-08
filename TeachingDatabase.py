from bottle import route, run, request, response, template, HTTPResponse
# from xml.dom import minidom, Node
from DatabaseDriverClass import DatabaseConnect as dbcon


def connect_database():
    """
    Currently, Databse connection is being made in every new function in this class.
    We have to connect to database once not everytime. I am looking how we can achieve this.
    I will implement this function, so that we can reuse same database object in every new function.
    
    """
    pass


@route('/')
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

@route('/getStaff')
def get_staff():
    staffID = request.query.staffid
    print(staffID)
    
    with dbcon() as db:
        # create a handle to the database connection that you open
        conx = db.opendb()
        # Create the database query
        selectQuery = (
            # 'SELECT First_Name, Last_Name FROM staff WHERE aipubmedid = %s'
            'SELECT StaffID, First_Name, Last_Name FROM staff WHERE StaffID = %s')
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
    

run(host='172.23.20.82', port=80, debug=True)
