SET GLOBAL max_allowed_packet=1024*1024*1024;

set global max_execution_time=0;

load data infile 'D:/CUHK/Y3T1/ERG3010/ERG3010-Project/Data/rawdata-usbridges-csv-2016-utf8.csv'   
into table rawdata
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n';  