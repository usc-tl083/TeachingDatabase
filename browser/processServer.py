# https://bottlepy.org/docs/dev/index.html
from browser.bottle import template, HTTPResponse
from utilities.clsArticle import Article
from utilities.clsArticleNote import ArticleNote

class ProcessServer:

    def __init__(self):
        pass
            
    def __enter__(self):
        return self

    # Automatically close when un-instantiated
    def __exit__(self, exc_type, exc_value, traceback):
        pass
    
    