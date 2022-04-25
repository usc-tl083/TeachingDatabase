import mysql.connector
from mysql.connector import errorcode


class DatabaseConnect:

    def __init__(self, database='ict342_s2_21_teachingdb_team_workshop'):
        self.__databaseName = database
        self.__config = {
            'user': 'ict342-TeachingDb_Team',
            'password': 'mysql-TeachingDb_Team',
            'host': 'wsp-bict11',
            'database': self.__databaseName,
            'raise_on_warnings': True, }
        self.__cnx = ''

    def __enter__(self):
        return self

    # Automatically close database when un-instantiated
    def __exit__(self, exc_type, exc_value, traceback):
        self.__cnx.close()
        print("Closing Database.")

    def opendb(self):
        try:
            self.__cnx = mysql.connector.connect(**self.__config)
        except mysql.connector.Error as err:
            if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
                print("Something is wrong with your user name or password")
            elif err.errno == errorcode.ER_BAD_DB_ERROR:
                print("Database does not exist")
            else:
                print(err)
        finally:
            return self.__cnx
