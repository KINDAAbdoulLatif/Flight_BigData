#les donnees se trouvent a l'adresse https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/HG7NV7 
#elles sont ensuite copiees dans cloudera apres avoir crees les dossiers pour les contenir
hdfs dfs -mkdir -p /user/cloudera/rawdata/airline/flight
hdfs dfs -mkdir -p /user/cloudera/rawdata/airline/airport
hdfs dfs -mkdir -p /user/cloudera/rawdata/airline/carrier
hdfs dfs -mkdir -p /user/cloudera/rawdata/airline/planeInfo

#exporter les donnees
hdfs dfs -moveFromLocal 2003.csv /user/cloudera/rawdata/airline/flight
hdfs dfs -moveFromLocal 2004.csv /user/cloudera/rawdata/airline/flight
hdfs dfs -moveFromLocal 2005.csv /user/cloudera/rawdata/airline/flight
hdfs dfs -moveFromLocal 2006.csv /user/cloudera/rawdata/airline/flight
hdfs dfs -moveFromLocal 2007.csv /user/cloudera/rawdata/airline/flight
hdfs dfs -moveFromLocal 2008.csv /user/cloudera/rawdata/airline/flight

hdfs dfs -moveFromLocal plane-data.csv /user/cloudera/rawdata/airline/planeInfo
hdfs dfs -moveFromLocal airports.csv /user/cloudera/rawdata/airline/airport
hdfs dfs -moveFromLocal carriers.csv /user/cloudera/rawdata/airline/carrier

