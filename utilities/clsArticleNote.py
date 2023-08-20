
from utilities.clsDBConnect import DatabaseConnect as dbcon

class ArticleNote:

    def __init__(self):
        self.__lit_theme = None
        self.__lit_quote = None
        self.__lit_note = None
        self.__lit_page = None
        self.__pkliteraturenoteid = None
        self.__literatureid = None
        self.__fileout = True

    def __enter__(self):
        return self

    # Automatically close when un-instantiated
    def __exit__(self, exc_type, exc_value, traceback):
        pass
        # print('Closing ArticleNote Object')

    @property
    def pkliteraturenoteid(self):
        return self.__pkliteraturenoteid

    @pkliteraturenoteid.setter
    def pkliteraturenoteid(self, val):
        self.__pkliteraturenoteid = val
        print('Aticle Note ID: %s' % self.__pkliteraturenoteid)

    @property
    def literatureid(self):
        return self.__literatureid

    @literatureid.setter
    def literatureid(self, val):
        self.__literatureid = val
        print('Aticle ID: %s' % self.__literatureid)


    @property
    def lit_theme(self):
        return self.__lit_theme # __lit_theme is private

    @lit_theme.setter
    def lit_theme(self, val):
        self.__lit_theme = val
        try:
            print('Lit Theme: %s' % self.__lit_theme)
        except:
            print('Lit Theme: error')

    @property
    def lit_quote(self):
        return self.__lit_quote

    @lit_quote.setter
    def lit_quote(self, val):
        self.__lit_quote = val
        print('Lit Quote: %s' % self.__lit_quote)

    @property
    def lit_note(self):
        return self.__lit_note

    @lit_note.setter
    def lit_note(self, val):
        self.__lit_note = val
        print('Lit Note: %s' % self.__lit_note)

    @property
    def lit_page(self):
        return self.__lit_page

    @lit_page.setter
    def lit_page(self, val):
        self.__lit_page = val
        print('Lit Page: %s' % self.__lit_page)

    def saveArticleNote(self):
        # print('saveArticleNote:')
        with dbcon() as db:
            conx = db.opendb()
            dcurs = conx.cursor(buffered=True)
            if self.__pkliteraturenoteid > 0:
                update_var = ""
                update_data = []
                
                if self.__literatureid != None:
                    if update_var != "":
                        update_var = update_var + ", "
                    update_var = update_var + "literatureid = %s"
                    update_data.append(self.__literatureid)

                if self.__lit_theme != None:
                    if update_var != "":
                        update_var = update_var + ", "
                    update_var = update_var + "lit_theme = %s"
                    update_data.append(self.__lit_theme)
                
                if self.__lit_quote != None:
                    if update_var != "":
                        update_var = update_var + ", "
                    update_var = update_var + "lit_quote = %s"
                    update_data.append(self.__lit_quote)
                
                if self.__lit_note != None:
                    if update_var != "":
                        update_var = update_var + ", "
                    update_var = update_var + "lit_note = %s"
                    update_data.append(self.__lit_note)

                if self.__lit_page != None:
                    if update_var != "":
                        update_var = update_var + ", "
                    update_var = update_var + "lit_page = %s"
                    update_data.append(self.__lit_page)

                if self.__lit_quote != None:
                    if update_var != "":
                        update_var = update_var + ", "
                    update_var = update_var + "lit_quote = %s"
                    update_data.append(self.__lit_quote)

                update_data.append(int(self.__pkliteraturenoteid))
                # create a tuple from the list
                tup_update_data = tuple(update_data)

                update_known_pk = (
                    'UPDATE literature_note SET ' + update_var + ' '
                    'WHERE pkliteraturenoteid = %s')
                # print('update_known_pk %s' % update_known_pk)
                dcurs.execute(update_known_pk, tup_update_data)
                print('saveArticleNote: Article Note ID: %s' % self.__pkliteraturenoteid)
            else:
                insert_var = ""
                insert_val = ""
                insert_data = []

                if self.__literatureid != None:
                    if insert_var != "":
                        insert_var = insert_var + ", literatureid"
                        insert_val = insert_val + ', %s'
                    else: 
                        insert_var = "literatureid"
                        insert_val = '%s'
                    insert_data.append(self.__literatureid)

                if self.__lit_theme != None:
                    if insert_var != "":
                        insert_var = insert_var + ", lit_theme"
                        insert_val = insert_val + ', %s'
                    else:
                        insert_var = "lit_theme"
                        insert_val = '%s'
                    insert_data.append(self.__lit_theme)

                if self.__lit_quote != None:
                    if insert_var != "":
                        insert_var = insert_var + ", lit_quote"
                        insert_val = insert_val + ', %s'
                    else:
                        insert_var = "lit_quote"
                        insert_val = '%s'
                    insert_data.append(self.__lit_quote)
                
                if self.__lit_note != None:
                    if insert_var != "":
                        insert_var = insert_var + ", lit_note"
                        insert_val = insert_val + ', %s'
                    else:
                        insert_var = "lit_note"
                        insert_val = '%s'
                    insert_data.append(self.__lit_note)
   
                if self.__lit_page != None:
                    if insert_var != "":
                        insert_var = insert_var + ", lit_page"
                        insert_val = insert_val + ', %s'
                    else:
                        insert_var = "lit_page"
                        insert_val = '%s'
                    insert_data.append(self.__lit_page)

                insert_new_pk = (
                    'INSERT INTO literature_note(' + insert_var + ') '
                    'VALUES(' + insert_val + ')')
                
                tup_insert_data = tuple(insert_data)
                # print(insert_new_pk)
                # print(tup_insert_data)
                dcurs.execute(insert_new_pk, tup_insert_data)
                self.__pkliteraturenoteid = dcurs.lastrowid
                print('saveArticleNote: Article Note ID: %s' % self.__pkliteraturenoteid)
            dcurs.close()
            conx.commit()

    def getArticleNotes(self, litID):
        with dbcon() as db:
            # print(litID)
            requiredColumns = "pkliteraturenoteid, literatureid, lit_theme, lit_quote, lit_note, lit_page"
            cnx = db.opendb()
            # query = ('SELECT pkliteraturenoteid AS "Note ID", literatureid  AS "Article ID", lit_theme AS "Theme", lit_quote AS "Quote", lit_note AS "Note", lit_page AS "Page" FROM literature_note WHERE literatureid = %s')
            query = ('SELECT {} FROM literature_note WHERE literatureid = %s'.format(requiredColumns))
            query_data = (litID,)
            dcurs = cnx.cursor(buffered=True)
            # dcurs.execute(query)
            dcurs.execute(query, query_data)

            row_headers=[x[0] for x in dcurs.description] #this will extract row headers
            # print(row_headers)
            articleNotes = dcurs.fetchall()
            # print(articleNotes)
            json_data=[]
            for articleNote in articleNotes:
                json_data.append(dict(zip(row_headers, articleNote)))
            # print(json_data)
            dcurs.close
        return json_data
        # return json.dumps(json_data)

    def deleteArticleNote(self):
        # print('saveArticleNote:')
        with dbcon() as db:
            if self.__pkliteraturenoteid > 0:
                conx = db.opendb()
                dcurs = conx.cursor(buffered=True)
                delete_pk = (self.__pkliteraturenoteid,)
                delete_statement = (
                    'DELETE FROM literature_note '
                    'WHERE pkliteraturenoteid = %s')
                print('delete_statement %s' % delete_statement)
                dcurs.execute(delete_statement, delete_pk)
                print('deleteArticleNote: Article Note ID: %s' % self.__pkliteraturenoteid)
            
                dcurs.close()
                conx.commit()

    def getArticleNote(self, noteID):
        with dbcon() as db:
            cnx = db.opendb()
            query = ('SELECT pkliteraturenoteid, literatureid, lit_theme, lit_quote, lit_note, lit_page FROM literature_note WHERE pkliteraturenoteid = %s')
            query_data = ('%s' % noteID,)
            dcurs = cnx.cursor(buffered=True)
            dcurs.execute(query, query_data)
            # dcurs.execute(query, query_data)

            row_headers=[x[0] for x in dcurs.description] #this will extract row headers
            articleNote = dcurs.fetchall()
            json_data=[]
            json_data.append(dict(zip(row_headers,articleNote[0])))
            # for ArticleNote in ArticleNotes:
            #         json_data.append(dict(zip(row_headers,ArticleNote)))
            
            dcurs.close
        return json_data
    
    def displayLiteratureNotes(self, litID):
        note_table = ""
        
        allNotes = self.getArticleNotes(litID = litID)
        if len(allNotes) > 0:
                        
            note_table_head = '''
                <style>
                    #NoteTable tr:hover {background-color: #ddd;}
                </style>
                <table id="NoteTable" class="w3-table w3-striped w3-bordered">
                    <thead>
                        <tr class="w3-theme">
                '''
            th_tag = '''
                    <th>Note ID</th>
                    <th>Article ID</th>
                    <th>Theme</th>
                    <th>Quote</th>
                    <th>Note</th>
                    <th>Page</th>
                '''
            
            note_table_body_upper = '''
                    </tr>
                    </thead>
                    <tbody>
            '''

            note_table_body_middle = ""
            
            for note in allNotes:
            
                tr_tag_front = '''<tr onclick="editArticleNote({})">'''.format(note["pkliteraturenoteid"])
                # tr_tag_front = '''
                    # <tr>
                # '''
                
                tr_body = '''
                    <td>{}</td>
                    <td>{}</td>
                    <td>{}</td>
                    <td>{}</td>
                    <td>{}</td>
                    <td>{}</td>
                '''.format(note['pkliteraturenoteid'], note['literatureid'], note['lit_theme'], note['lit_quote'], note['lit_note'], note['lit_page']) 

                tr_base = '''
                    </tr>
                '''
                note_table_body_middle = note_table_body_middle + tr_tag_front + tr_body + tr_base

            note_table_body_base = '''
                
                    </tbody>
                </table>
            '''
            note_table = note_table_head + th_tag + note_table_body_upper + note_table_body_middle + note_table_body_base
            # print(note_table)
        
        return note_table

    def displayLitNoteDetailsEditable(self, noteID):
        detail_div = ""

        myNote = self.getArticleNote(noteID)
        myNote = myNote[0]
        # print(myNote)

        myNotetitle = "Note %s"  % noteID + " - Article %s" % myNote['literatureid']

        display_note_modal_header = '''
            <div class="w3-modal-content w3-card-4 w3-animate-top">
                <header class="w3-container w3-theme w3-center"> 
                    <span onclick="document.getElementById('modalDiv').style.display='none'"
                    class="w3-button w3-display-topright">x</span>
                    <h2>{}
                        <button class="w3-btn" style="font-size: medium" onclick="deleteArticleNote({}, confirm('Delete this Literature Note?'))">(Delete Note)</button>
                    </h2>
                </header>
        '''.format(myNotetitle, noteID)

        display_note_modal_body_top = '''
                <div class="w3-padding">
        '''
        detail_div_theme = '''
            <div class="w3-container">     
                <label><b>Theme</b></label>
                <input class="w3-input" onchange='saveNoteData(element=this, NoteID={})' value='{}' type="text" id="lit_theme" />
            </div>
            <br>
        '''
        detail_div_theme_complete = detail_div_theme.format(myNote['pkliteraturenoteid'],
                                                            myNote['lit_theme'] )
        
        detail_div_quote = '''
            <div class="w3-container">     
                <label><b>Quote</b></label>
                <textarea class="w3-input" onchange='saveNoteData(element=this, noteID={});' type="text" id="lit_quote" />{}</textarea>
            </div>
            <br>
        '''
        detail_div_quote_complete = detail_div_quote.format(myNote['pkliteraturenoteid'],
                                                            myNote['lit_quote'] )
        
        detail_div_note = '''
            <div class="w3-container">     
                <label><b>Note</b></label>
                <textarea class="w3-input" rows="10" onchange='saveNoteData(element=this, noteID={});' type="text" id="lit_note" />{}</textarea>
            </div>
            <br>
        '''
        detail_div_note_complete = detail_div_note.format(myNote['pkliteraturenoteid'],
                                                          myNote['lit_note'] )
        
        detail_div_page = '''
            <div class="w3-container">     
                <label><b>Page</b></label>
                <input class="w3-input" onchange='saveNoteData(element=this, noteID={})' value='{}' type="text" id="lit_page" />
            </div>
            <br>
        '''
        detail_div_page_complete = detail_div_page.format(myNote['pkliteraturenoteid'],
                                                          myNote['lit_page'] )

        detail_div = detail_div_theme_complete + detail_div_quote_complete + detail_div_note_complete + detail_div_page_complete
        
        display_note_modal_body_base = '''
                </div>
        '''
        display_note_modal_footer = '''
                <footer class="w3-container w3-theme">
                <br>
                </footer>
            </div>
        '''
        display_note_modal = display_note_modal_header + display_note_modal_body_top + detail_div + display_note_modal_body_base + display_note_modal_footer

        return display_note_modal