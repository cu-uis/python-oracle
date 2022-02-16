#checking mdm
import cx_Oracle

dsn_tns = cx_Oracle.makedsn('server', 'port', service_name='name') # if needed, place an 'r' before any parameter in order to address special characters such as '\'.
conn = cx_Oracle.connect(user=r'username', password='password', dsn=dsn_tns) # if needed, place an 'r' before any parameter in order to address special characters such as '\'. For example, if your user name contains '\', you'll need to place 'r' before the user name: user=r'User Name'

c = conn.cursor()
c.execute('''
SELECT * FROM OSB_CHERWELL_JSON_DATA
''') # use triple quotes if you want to spread your query across multiple lines
for row in c:
    print (row[0], '-', row[1], '-', row[2]) # this only shows the first two columns. To add an additional column you'll need to add , '-', row[2], etc.
    print("\n")

conn.close()

