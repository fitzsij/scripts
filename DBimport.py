import MySQLdb, csv, sys
conn = MySQLdb.connect (host = "localhost",user = "root", passwd = "toor",db = "databasename")
c = conn.cursor()
csv_data=csv.reader(file("Rstates.csv"))
for row in csv_data:
	print row
	c.execute("INSERT INTO a (first, last) VALUES (%s, %s)" % row)
c.commit()
c.close()


mysql> load data local infile "C:\\Users\\ejulfit\\Desktop\\Rstates.csv" into table CommonAndEventsRState fields terminated by ';' 
enclosed by '"' lines terminated by '\r\n'
 (idCommonAndEventsRState, ProductNumber, ProductName, PackageName, EE_327_Reserved, EE_327_Delivered, 
EE_403_Reserved, EE_403_Delivered, EE_404_Reserved, EE_404_Delivered, ES_1406_Reserved, ES_1406_Delivered, ES_1407_Reserved, ES_1407_Delivered, ES_1408_Reserved, ES_1408_Delivered, 
ES_1409_Reserved, OpenedRegularly, NotOpenedRegularly, CommonIntegra
tion, EventsOnly, CommonTechpacks, StatsOnly, SonOnly);
Query OK, 71 rows affected, 1704 warnings (0.01 sec)
Records: 71  Deleted: 0  Skipped: 0  Warnings: 1704