git clone https://github.com/commoncrawl/ia-web-commons 
cd ia-web-commons 
mvn -f pom-cdh5.xml install 
# could also use pom.xml 
cd - 

git clone https://github.com/commoncrawl/ia-hadoop-tools 
cd ia-hadoop-tools 
mvn package