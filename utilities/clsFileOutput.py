
# File read / write - https://www.pythonforbeginners.com/files/reading-and-writing-files-in-python

from datetime import datetime
from utilities.clsDBConnect import DatabaseConnect as dbcon
import csv
import os

class FileOutput:

    def __init__(self, messageline, filename = 'output', premsgnewline = True, adddatetime = True):
        # print(os.getcwd())

        self.__filename = './output_files/%s' % filename + '_%s' % datetime.now().strftime("%Y-%m-%d") + '.txt'
        self.__fileInstance = open(self.__filename, 'a+')

        if premsgnewline:
            if adddatetime:
                mymsg = '\n%s: ' % datetime.now().strftime("%H-%M-%S") + messageline
            else:
                mymsg = '\n' + messageline
        else:
            mymsg = messageline

        self.__fileInstance.write(mymsg)

    def __enter__(self):
        return self

    # Automatically close file when un-instantiated
    def __exit__(self, exc_type, exc_value, traceback):
        self.__fileInstance.close()
        # print('Closing file: %s' % self.__filename)

# class CSVOutput:
    # def __init__(self, filename = 'output', bdQuery = 'SELECT * FROM literature'):
    #     # print(os.getcwd())

    #     self.__filename = './output_files/%s' % filename + '_%s' % datetime.now().strftime("%Y-%m-%d") + '.csv'
    #     with dbcon() as db:
    #         conx = db.opendb()
    #         selectQuery = (bdQuery)
    #         dcurs = conx.cursor(buffered=True)
    #         dcurs.execute(selectQuery)
    #         if dcurs.rowcount > 0:
    #             result = [{columns[index][0]: column for index, column in enumerate(value)} for value in cursor.fetchall()]
    #             # with open(self.__filename, 'w') as f:
    #             #     #  f.write(' '.join(str(row) for row in dcurs) + '\n')
    #             #     # writer = csv.writer(f)
    #             #     for row in dcurs:
    #             #         myStr = ""
    #             #         for item in row:
    #             #             st = str(item)
    #             #             myStr = myStr + ", " + st
    #             #     # print(myStr)
    #             #         f.write(myStr + '/n')
    #             #         # writer.writerow(myStr)
    #             #     #     print(row.encode("utf-8"))

    #     dcurs.close()


    #     # self.__fileInstance = open(self.__filename, 'a+')

    #     # if premsgnewline:
    #     #     if adddatetime:
    #     #         mymsg = '\n%s: ' % datetime.now().strftime("%H-%M-%S") + messageline
    #     #     else:
    #     #         mymsg = '\n' + messageline
    #     # else:
    #     #     mymsg = messageline

    #     # self.__fileInstance.write(mymsg)

    # def __enter__(self):
    #     return self

    # # Automatically close file when un-instantiated
    # def __exit__(self, exc_type, exc_value, traceback):
    #     print('Closing file: %s' % self.__filename)