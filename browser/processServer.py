# https://bottlepy.org/docs/dev/index.html
from browser.bottle import template, HTTPResponse
from utilities.clsArticle import Article
from utilities.clsArticleNote import ArticleNote

class ProcessServer:

    def __init__(self):
        pass
        
    def processRequestFunction(self, reqJson):
        print("processRequestFunction")
        print(reqJson)
        myA = reqJson["requestFunction"]
        for myB in myA:
            # print(myB)
            if myB == "functionName":
                reqFunction = myA[myB]
                # print(reqFunction)

        if reqFunction == "GetAllArticles":
            return self.__getAllArticles(reqJson)
        elif reqFunction == "DisplayAllArticles":
            return self.__displayAllArticles(reqJson)
        elif reqFunction == "GetArticle":
            return self.__getArticle(reqJson)
        elif reqFunction == "SaveArticle":
            return self.__saveArticle(reqJson)
        elif reqFunction == "GetNotesTable":
            return self.__getNotesTable(reqJson)
        elif reqFunction == "AddNote":
            return self.__addNote(reqJson)
        elif reqFunction == "EditArticleNote":
            return self.__editArticleNote(reqJson)
        elif reqFunction == "SaveNote":
            return self.__saveNote(reqJson)
        elif reqFunction == "DeleteArticleNote":
            return self.__deleteArticleNote(reqJson) 
        else:
            return HTTPResponse(status=204)


    def __getAllArticles(self, noteJson):
            return template('all_articles_page', tpltitle="All Articles")

          
    def __displayAllArticles(self, noteJson):

        ar = Article()
        articleTable = ar.displayAllArticles()
        
        if articleTable:
            return articleTable
        else: 
            return HTTPResponse(status=204)
        
    
    def __getArticle(self, noteJson):
        myD = noteJson["requestData"]
        # print(myD)
        keyID=-1
        for myB in myD:
            # print(myB)
            # print(noteJson[myB])
            if myB == "pkliteratureid":
                keyID = myD[myB]

        ar = Article()
        articledb = ar.getArticle(litID=keyID)
        # notedb = ArticleNote.getArticleNotes(self, litID=litID)
        # data = db.cars.find({}, {'_id': 0})
        # print(articledb)
        if articledb:
            # result = json.dumps(articledb)
            # print(articledb[0]['title'])
            mytitle = "Article %s"  % articledb[0]['pkliteratureid'] + " - %s" % articledb[0]['title']
            
            if articledb[0]['processed'] == 1:
                articledb[0]['processed'] = "checked"
            else:
                articledb[0]['processed'] = ""
            # print(mytitle)
            return template('article_page', article=articledb, tpltitle=mytitle)
            # return template('article_page', article=articledb, notes=notedb, tpltitle=mytitle)
        else: 
            return HTTPResponse(status=204)
        
    def __getNotesTable(self, noteJson):
        myD = noteJson["requestData"]
        keyID=-1
        for myB in myD:
            # print(myB)
            # print(noteJson[myB])
            if myB == "literatureid":
                keyID = myD[myB]
                # print(keyID)
        an = ArticleNote()
        notetable = an.displayLiteratureNotes(litID=keyID)
        # print(notekeys)
        if notetable:
            return notetable
        else: 
            return HTTPResponse(status=204)
        
    def __addNote(self, noteJson):
        myD = noteJson["requestData"]
        an = ArticleNote()
        for myA in myD:
            # print(myA)
            setattr(an, myA, myD[myA])
            # print(myD[myA])
        an.saveArticleNote()
        notetable = an.displayLitNoteDetailsEditable(noteID=an.pkliteraturenoteid)
        # print(notekeys)
        if notetable:
            return notetable
        else: 
            return HTTPResponse(status=204)
    
    def __editArticleNote(self, noteJson):
        myD = noteJson["requestData"]
        keyID=-1
        for myB in myD:
            # print(myB)
            # print(noteJson[myB])
            if myB == "pkliteraturenoteid":
                keyID = myD[myB]
            # print(keyID)
           
        an = ArticleNote()
        notemodal = an.displayLitNoteDetailsEditable (noteID = keyID)
        
        if notemodal:
            return notemodal
        else: 
            return HTTPResponse(status=204)   
    
    def __saveArticle(self, noteJson):
        myD = noteJson["requestData"]
        a = Article()
        # myReturn = a.updateArticle(articleJson)
        myReturn = 'Update Successful'

        # print(myD)
        for myA in myD:
            # print(myA)
            setattr(a, myA, myD[myA])
            # print(myD[myA])
        a.saveArticle()
        
        return myReturn
    
    def __saveNote(self, noteJson):
        myD = noteJson["requestData"]
        an = ArticleNote()
        myReturn = 'Update Successful'

        for myA in myD:
            # print(myA)
            setattr(an, myA, myD[myA])
            # print(myD[myA])
        an.saveArticleNote()
        return myReturn
    
    def __deleteArticleNote(self, noteJson):
        myD = noteJson["requestData"]
        an = ArticleNote()
        myReturn = 'Update Successful'

        for myA in myD:
            # print(myA)
            setattr(an, myA, myD[myA])
            # print(myD[myA])
        an.deleteArticleNote()
        return myReturn
        
    def __enter__(self):
        return self

    # Automatically close when un-instantiated
    def __exit__(self, exc_type, exc_value, traceback):
        pass
    
    