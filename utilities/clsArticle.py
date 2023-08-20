
from utilities.clsDBConnect import DatabaseConnect as dbcon

class Article:
    __pkliteratureid = 0
    __title = None
    __journal = None
    __abstract = None
    __authors = None
    __publishdate = None
    __pubmedid = None
    __DOI = None
    __searchterms = None
    __comments = None
    __relevance = -1 # Relevance can be on a scale of 0 to 5. 0 is not relevant and 5 very relevant
    __processed = None

    def __init__(self):
        pass

    def __enter__(self):
        return self

    # Automatically close when un-instantiated
    def __exit__(self, exc_type, exc_value, traceback):
        pass
        # print('Closing Article Object')

    @property
    def pkliteratureid(self):
        return self.__pkliteratureid

    @pkliteratureid.setter
    def pkliteratureid(self, val):
        self.__pkliteratureid = val
        print('Aticle ID: %s' % self.__pkliteratureid)

    @property
    def title(self):
        return self.__title # __title is private

    @title.setter
    def title(self, val):
        self.__title = val
        try:
            print('Title: %s' % self.__title)
        except:
            print('Title: error')

    @property
    def journal(self):
        return self.__journal

    @journal.setter
    def journal(self, val):
        self.__journal = val
        print('Journal: %s' % self.__journal)

    @property
    def abstract(self):
        return self.__abstract

    @abstract.setter
    def abstract(self, val):
        self.__abstract = val
        print('abstract: %s' % self.__abstract)

    @property
    def authors(self):
        return self.__authors

    @authors.setter
    def authors(self, val):
        self.__authors = val
        print('Authors: %s' % self.__authors)

    @property
    def publishdate(self):
        return self.__publishdate

    @publishdate.setter
    def publishdate(self, val):
        self.__publishdate = val
        print('Publication date: %s' % self.__publishdate)

    @property
    def pubmedid(self):
        return self.__pubmedid

    @pubmedid.setter
    def pubmedid(self, val):
        self.__pubmedid = val
        print('PubMed ID: %s' % self.__pubmedid)

    @property
    def DOI(self):
        return self.__DOI

    @DOI.setter
    def DOI(self, val):
        self.__DOI = val
        print('DOI: %s' % self.__DOI)

    @property
    def searchterms(self):
        return self.__searchterms

    @searchterms.setter
    def searchterms(self, val):
        self.__searchterms = val
        print('Search Terms: %s' % self.__searchterms)

    @property
    def comments(self):
        return self.__comments

    @comments.setter
    def comments(self, val):
        self.__comments = val
        print('Comments: %s' % self.__comments)

    @property
    def relevance(self):
        return self.__relevance

    @relevance.setter
    def relevance(self, val):
        self.__relevance = val
        print('relevance: %s' % self.__relevance)

    @property
    def processed(self):
        return self.__processed

    @processed.setter
    def processed(self, val):
        self.__processed = val
        # self.__processed.lower() in ['true', '1', 't', 'y', 'yes']
        if bool(self.__processed):
            self.__processed = 1
        else:
            self.__processed = 0
        try:
            print('Article has been processed: %s' % self.__processed)
        except:
            print('Article has been processed: error')
    
    def saveArticle(self):
        # print('saveArticle:')
        with dbcon() as db:
            conx = db.opendb()
            dcurs = conx.cursor(buffered=True)
            if self.__pkliteratureid > 0:
                update_var = ""
                update_data = []
                
                if self.__title != None:
                    if update_var != "":
                        update_var = update_var + ", "
                    update_var = update_var + "title = %s"
                    update_data.append(self.__title)

                if self.__journal != None:
                    if update_var != "":
                        update_var = update_var + ", "
                    update_var = update_var + "journal = %s"
                    update_data.append(self.__journal)

                if self.__abstract != None:
                    if update_var != "":
                        update_var = update_var + ", "
                    update_var = update_var + "abstract = %s"
                    update_data.append(self.__abstract)

                if self.__authors != None:
                    if update_var != "":
                        update_var = update_var + ", "
                    update_var = update_var + "authors = %s"
                    update_data.append(self.__authors)
                
                if self.__publishdate != None:
                    if update_var != "":
                        update_var = update_var + ", "
                    update_var = update_var + "publishdate = %s"
                    update_data.append(self.__publishdate)
                
                if self.__pubmedid != None:
                    if update_var != "":
                        update_var = update_var + ", "
                    update_var = update_var + "pubmedid = %s"
                    update_data.append(self.__pubmedid)

                if self.__DOI != None:
                    if update_var != "":
                        update_var = update_var + ", "
                    update_var = update_var + "DOI = %s"
                    update_data.append(self.__DOI)
                
                if self.__searchterms != None:
                    if update_var != "":
                        update_var = update_var + ", "
                    update_var = update_var + "searchterms = %s"
                    update_data.append(self.__searchterms)

                if self.__comments != None:
                    if update_var != "":
                        update_var = update_var + ", "
                    update_var = update_var + "comments = %s"
                    update_data.append(self.__comments)

                if self.__relevance != -1:
                    if update_var != "":
                        update_var = update_var + ", "
                    update_var = update_var + "relevance = %s"
                    update_data.append(int(self.__relevance))
                
                if self.__processed != None:
                    if update_var != "":
                        update_var = update_var + ", "
                    update_var = update_var + "processed = %s"
                    update_data.append(self.__processed)

                update_data.append(int(self.__pkliteratureid))
                # create a tuple from the list
                tup_update_data = tuple(update_data)

                update_known_pk = (
                    'UPDATE literature SET ' + update_var + ' '
                    'WHERE pkliteratureid = %s')
                # print('update_known_pk %s' % update_known_pk)
                dcurs.execute(update_known_pk, tup_update_data)
                print('saveArticle: Article ID: %s' % self.__pkliteratureid)
            else:
                insert_var = ""
                insert_val = ""
                insert_data = []

                if self.__title != None:
                    if insert_var != "":
                        insert_var = insert_var + ", title"
                        insert_val = insert_val + ', %s'
                    else:
                        insert_var = "title"
                        insert_val = '%s'
                    insert_data.append(self.__title)

                if self.__journal != None:
                    if insert_var != "":
                        insert_var = insert_var + ", journal"
                        insert_val = insert_val + ', %s'
                    else:
                        insert_var = "journal"
                        insert_val = '%s'
                    insert_data.append(self.__journal)

                if self.__abstract != None:
                    if insert_var != "":
                        insert_var = insert_var + ", abstract"
                        insert_val = insert_val + ', %s'
                    else:
                        insert_var = "abstract"
                        insert_val = '%s'
                    insert_data.append(self.__abstract)

                if self.__authors != None:
                    if insert_var != "":
                        insert_var = insert_var + ", authors"
                        insert_val = insert_val + ', %s'
                    else:
                        insert_var = "authors"
                        insert_val = '%s'
                    insert_data.append(self.__authors)
                
                if self.__publishdate != None:
                    if insert_var != "":
                        insert_var = insert_var + ", publishdate"
                        insert_val = insert_val + ', %s'
                    else:
                        insert_var = "publishdate"
                        insert_val = '%s'
                    insert_data.append(self.__publishdate)
                
                if self.__pubmedid != None:
                    if insert_var != "":
                        insert_var = insert_var + ", pubmedid"
                        insert_val = insert_val + ', %s'
                    else:
                        insert_var = "pubmedid"
                        insert_val = '%s'
                    insert_data.append(self.__pubmedid)

                if self.__DOI != None:
                    if insert_var != "":
                        insert_var = insert_var + ", DOI"
                        insert_val = insert_val + ', %s'
                    else:
                        insert_var = "DOI"
                        insert_val = '%s'
                    insert_data.append(self.__DOI)
                    
                if self.__searchterms != None:
                    if insert_var != "":
                        insert_var = insert_var + ", searchterms"
                        insert_val = insert_val + ', %s'
                    else:
                        insert_var = "searchterms"
                        insert_val = '%s'
                    insert_data.append(self.__searchterms)

                if self.__comments != None:
                    if insert_var != "":
                        insert_var = insert_var + ", comments"
                        insert_val = insert_val + ', %s'
                    else:
                        insert_var = "comments"
                        insert_val = '%s'
                    insert_data.append(self.__comments)

                if self.__relevance != -1:
                    if insert_var != "":
                        insert_var = insert_var + ", relevance"
                        insert_val = insert_val + ', %s'
                    else:
                        insert_var = "relevance"
                        insert_val = '%s'
                    insert_data.append(self.__relevance)

                if self.__processed != None:
                    if insert_var != "":
                        insert_var = insert_var + ", processed"
                        insert_val = insert_val + ', %s'
                    else:
                        insert_var = "processed"
                        insert_val = '%s'
                    insert_data.append(self.__processed)

                insert_new_pk = (
                    'INSERT INTO literature(' + insert_var + ') '
                    'VALUES(' + insert_val + ')')
                print(insert_new_pk)
                tup_insert_data = tuple(insert_data)
                print(tup_insert_data)
                dcurs.execute(insert_new_pk, tup_insert_data)
                self.__pkliteratureid = dcurs.lastrowid
                print('saveArticle: Article ID: %s' % self.__pkliteratureid)
            dcurs.close()
            conx.commit()

    def getArticles(self, requiredColumns = None):
        json_data=[]
        with dbcon() as db:
            
            if requiredColumns == None:
                requiredColumns = "pkliteratureid, title, abstract, DOI, searchterms, relevance, processed"
            query = ('SELECT {} FROM literature'.format(requiredColumns))

            print(query)
            cnx = db.opendb()

            dcurs = cnx.cursor(buffered=True)
            dcurs.execute(query)

            row_headers=[x[0] for x in dcurs.description] #this will extract row headers
            auth = dcurs.fetchall()
            
            for auths in auth:
                json_data.append(dict(zip(row_headers,auths)))
            # print(len(json_data))
            dcurs.close
        return json_data

    def getArticle(self, litID):
        if litID == 0:
            self.__pkliteratureid = 0
            self.saveArticle()
            litID = self.__pkliteratureid
            
        with dbcon() as db:
            cnx = db.opendb()
            requiredCols = "pkliteratureid, title, abstract, authors, publishdate, DOI, searchterms, relevance, comments, processed"
            query = ('SELECT {} FROM literature WHERE pkliteratureid = %s'.format(requiredCols))
            query_data = ('%s' % litID,)
            dcurs = cnx.cursor(buffered=True)
            dcurs.execute(query, query_data)
            # dcurs.execute(query, query_data)

            row_headers=[x[0] for x in dcurs.description] #this will extract row headers
            article = dcurs.fetchall()
            json_data=[]
            json_data.append(dict(zip(row_headers,article[0])))
            # for article in articles:
            #         json_data.append(dict(zip(row_headers,article)))
            
            dcurs.close
        return json_data
    
    def displayAllArticles(self):
        article_table = ""
        requiredColumns = "pkliteratureid, title, abstract, DOI, searchterms, relevance, processed"
        allArticles = self.getArticles(requiredColumns = requiredColumns)
        if len(allArticles) > 0:
                        
            article_table_head = '''
                <style>
                    #ArticleTable tr:hover {background-color: #ddd;}
                </style>
                <table id="ArticleTable" class="w3-table w3-striped w3-bordered">
                    <thead>
                        <tr class="w3-theme">
                '''
            th_tag = '''
                    <th>Lit ID</th>
                    <th>Title</th>
                    <th>Abstract</th>
                    <th>Search Terms</th>
                    <th>Relevance</th>
                    <th>Processed</th>
                '''
            
            article_table_body_upper = '''
                    </tr>
                    </thead>
                    <tbody>
            '''

            article_table_body_middle = ""
            
            for article in allArticles:
            
                # tr_tag_front = '''<tr onclick="editLiteraturearticle({},{})">'''.format(projectID, article["pklitprojectarticleid"])
                tr_tag_front = '''
                    <tr>
                '''
                
                tr_body = '''
                    <td><a href="javascript:;" onclick="getArticlePage({})">{}</a> </td>
                    <td><a href="javascript:;" onclick="getArticlePage({})">{}</a> </td>
                    <td>{}</td>
                    <td>{}</td>
                    <td>{}</td>
                    <td>{}</td>
                '''.format(article['pkliteratureid'], article['pkliteratureid'], article['pkliteratureid'], article['title'], article['abstract'], article['searchterms'], article['relevance'], article['processed']) 
                # tr_body = '''
                #     <td><a href="javascript:;" onclick="getArticlePage({})">{}</a> </td>
                #     <td><a href="https://doi.org/{}" target="_blank">{}</a> </td>
                #     <td>{}</td>
                #     <td>{}</td>
                #     <td>{}</td>
                #     <td>{}</td>
                # '''.format(article['pkliteratureid'], article['pkliteratureid'], article['DOI'], article['title'], article['abstract'], article['searchterms'], article['relevance'], article['processed']) 


                tr_base = '''
                    </tr>
                '''
                article_table_body_middle = article_table_body_middle + tr_tag_front + tr_body + tr_base

            article_table_body_base = '''
                
                    </tbody>
                </table>
                <br>
            '''
            article_table = article_table_head + th_tag + article_table_body_upper + article_table_body_middle + article_table_body_base
            # print(article_table)
        
        return article_table


