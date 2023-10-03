
# https://bottlepy.org/docs/dev/index.html
from browser.bottle import route, run, template, HTTPResponse, TEMPLATE_PATH, response, request, post, redirect, static_file, Bottle
from browser.processServer import ProcessServer
import json
import browser.bottle as bottle
from utilities.clsDBConnect import DatabaseConnect as dbcon
from datetime import datetime

message=""

class BrowserServer:

    def __init__(self):
        # print(TEMPLATE_PATH)

        @post('/')
        def __postindex():
            dataJson = request.body.read()
            # print(len(dataJson))
            myReturnDataType = ""
            if len(dataJson) > 0:
                xData = json.loads(dataJson)
                # print(xData)
                aData = xData["apiRequest"]
                # print(aData)
                for myA in aData:
                    # print(myA)
                    if myA == "requestFunction":
                        # Get the return data type
                        for myDT in aData[myA]:
                            # print(myDT)
                            # print(aData[myA][myDT])
                            if myDT == "returnDataType":
                                myReturnDataType = aData[myA][myDT]
                                # print(myReturnDataType)
                        # print(aData[myA])
                        p = ProcessServer()
                        response.headers['Access-Control-Allow-Origin'] = '*'
                        if myReturnDataType == "http":
                            response.headers['Content-type'] = 'application/http'
                        elif myReturnDataType == "json":
                            response.headers['Content-type'] = 'application/json'
                        else:
                            response.headers['Content-type'] = 'application/text'
                        
                        return p.processRequestFunction(aData)
            else:
                return template('login21', tpltitle="Teaching Database", message=message)
            
        @route('/')
        def __index():
            return template('login21', tpltitle="Teaching Database", message=message)
        
        @route('/staff_reg')
        def __index():
            return template('staff_reg', tpltitle="New Staff Registration")
        
        @route('/w3stemplate')
        def __index():
            return template('w3Schools_Template')
        
        @route('/w3smodal')
        def __index():
            return template('w3Schools_modal')
        
        @route('/static/<filepath:path>')
        def serve_static(filepath):
            return static_file(filepath, root='static')
        
        #This is where all the data from the staff table is viewed
        @route('/display_data')
        def display_data():
            with dbcon() as db:
                conx = db.opendb()
                dcurs = conx.cursor(buffered=True)
                query = "SELECT * FROM staff"
                dcurs.execute(query)
                datas = dcurs.fetchall()

                dcurs.close()
                conx.close()

            return template('all_staffs_page.html', data=datas, tpltitle="Staff Information")
        
        # This is where the submitted form data is processed to add the data to the database
        # Database is connected here within this route/function and added to the respective tables
        @route('/submit_data', method='POST')
        def submit():
            fname = request.forms.get('fname')
            mname = request.forms.get('mname')
            lname = request.forms.get('lname')
            gender = request.forms.get('gender')
            dob = request.forms.get('dob')
            address = request.forms.get('address')
            email = request.forms.get('email')
            phone = request.forms.get('phone')

            qualification_name = request.forms.get('qualification_name')
            subject_area = request.forms.get('subject_area')
            institution_name = request.forms.get('institution_name')
            year_issued = request.forms.get('year_issued')

            teaching_period = request.forms.get('teaching_period')
            field = request.forms.get('field')
            teaching_institution = request.forms.get('teaching-institution')
            role = request.forms.get('role')

            employment_period = request.forms.get('employment-period')
            relevant_duties = request.forms.get('relevant-duties')
            employer = request.forms.get('employer')
            position_title = request.forms.get('position-title')
            work_status = request.forms.get('work_status')

            other_info = request.forms.get('other-info')

            author = request.forms.get('author')
            publication_year = request.forms.get('publication-year')
            publication_title = request.forms.get('publication-title')
            publication_type = request.forms.get('publication-type')
            peer_rev = request.forms.get('peer-rev')
            classification = request.forms.get('classification')

            # Validate and convert the date format
            try:
                dob = datetime.strptime(dob, '%Y-%m-%d').date()
            except ValueError:
                return "Invalid date format. Please use YYYY-MM-DD."

            with dbcon() as db:
                conx = db.opendb()
                dcurs = conx.cursor(buffered=True)

                #Inserting data to staff table
                query = "INSERT INTO staff (gender, first_name, middle_name, last_name, dob, address, email, phone) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
                dcurs.execute(query, (gender, fname, mname, lname, dob, address, email, phone))
                conx.commit()

                #Inserting data to qualifications table
                query = "INSERT INTO qualifications (qualification_name, subject_area, institution_name, year_issued) VALUES (%s, %s, %s, %s)"
                dcurs.execute(query, (qualification_name, subject_area, institution_name, year_issued))
                conx.commit()

                #Inserting data to teaching_experience table
                query = "INSERT INTO teaching_experience (teaching_period, course_title, organisation_name, role) VALUES (%s, %s, %s, %s)"
                dcurs.execute(query, (teaching_period, field, teaching_institution, role))
                conx.commit()

                #Inserting data to other_experience table
                query = "INSERT INTO other_experience (emp_name, position, work_status, employment_period, duties) VALUES (%s, %s, %s, %s, %s)"
                dcurs.execute(query, (employer, position_title, work_status, employment_period, relevant_duties))
                conx.commit()

                #Inserting data to additional_notes table
                query = "INSERT INTO additional_notes (notes, recorded_by) VALUES (%s, %s)"
                dcurs.execute(query, (other_info, fname + lname))
                conx.commit()

                #Inserting data to publications table
                query = "INSERT INTO publications (author_name, publication_title, publication_year, publication_type, peer_reviewed, classification) VALUES (%s, %s, %s, %s, %s, %s)"
                dcurs.execute(query, (author, publication_title, publication_year, publication_type, peer_rev, classification))
                conx.commit()

                dcurs.close()
                conx.close()

            return template('login21', tpltitle="Teaching Database", message="success-form")
        
        # @route('/static/js/<filename:path>')
        # def serve_js(filename):
        #     return static_file(filename, root='/static/js')
        
        run(host='localhost', port=8080, debug=True)
        

    def __enter__(self):
        return self

    # Automatically close when un-instantiated
    def __exit__(self, exc_type, exc_value, traceback):
        pass

    
    
    