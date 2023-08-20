
# https://bottlepy.org/docs/dev/index.html
from browser.bottle import route, run, template, HTTPResponse, TEMPLATE_PATH, response, request, post, redirect
from browser.processServer import ProcessServer
import json

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
                return template('index_page', tpltitle="Literature Database")
            
        @route('/')
        def __index():
            return template('index_page', tpltitle="Literature Database")
        
        @route('/w3stemplate')
        def __index():
            return template('w3Schools_Template')
        
        @route('/w3smodal')
        def __index():
            return template('w3Schools_modal')
        
        run(host='localhost', port=8080, debug=True)
        

    def __enter__(self):
        return self

    # Automatically close when un-instantiated
    def __exit__(self, exc_type, exc_value, traceback):
        pass
    
    