# https://bottlepy.org/docs/dev/index.html
from browser.bottle import template, HTTPResponse
from utilities.clsArticle import Article
from utilities.clsArticleNote import ArticleNote

class ProcessServer:

    def __init__(self):
        pass
            
    def __enter__(self):
        return self
    
    def generate_table(record, data):
        headers = []
        if record == 'qualification':
            headers = ["ID", "Qualification Name", "Subject Area", "Institution Name", "Year Issued", "Action"]
        elif record == 'experience':
            headers = ["ID", "Teaching Period", "Course Title", "Organisation Name", "Role", "Action"]
        elif record == 'publication':
            headers = ["ID", "Author Name", "Publication Title", "Publication Year", "Publication Type", "Peer Reviewed", "Classification", "Action"]
        else:
            headers = ["ID", "Gender", "First Name", "Middle Name", "Last Name", "Date of Birth", "Address", "Email", "Phone", "Action"]
        
        # Generate table headers
        table_header = '<tr>' + ''.join(f'<th>{header}</th>' for header in headers) + '</tr>'
        
        # Generate table rows
        table_rows = ''
        for item in data:
            if record == 'qualification':
                row_data = [item[1], item[2], item[3], item[4], item[5]]
            elif record == 'experience':
                row_data = [item[0], item[1], item[3], item[4], item[5]]
            elif record == 'publication':
                row_data = [item[0], item[2], item[3], item[4], item[5], item[6], item[7]]
            else:
                row_data = [item[0], item[1].upper(), item[2], item[3], item[4], item[5], item[6], item[7], item[8]]

            table_rows += '<tr>' + ''.join(f'<td>{data}</td>' for data in row_data)
            table_rows += f'<td><a href="/display_data/{item[0]}" class="btn btn-sm btn-outline-primary">View</a></td></tr>'
        
        # Generate the complete HTML table
        html_table = f'''
            <table id="datatablesSimple">
                <thead>{table_header}</thead>
                <tfoot>{table_header}</tfoot>
                <tbody>{table_rows}</tbody>
            </table>
        '''
        return html_table

    # Automatically close when un-instantiated
    def __exit__(self, exc_type, exc_value, traceback):
        pass
    
    