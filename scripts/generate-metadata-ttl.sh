#!/bin/bash

MAXNUM=99
SEQUENCE=`seq -w 0 $MAXNUM`

./generate-wkt-borders.sh > /tmp/wkts.txt

echo '@prefix void: <http://rdfs.org/ns/void#> .'
echo '@prefix svd: <http://www.w3.org/2015/03/sevod#> .'
echo '@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .'
echo '@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .'
echo '@prefix geo: <http://www.opengis.net/ont/geosparql#> .'
echo '@prefix gg: <http://geographica.di.uoa.gr/ontology/> .'
echo '@prefix dataset: <http://rdf.semagrow.org/svd/resource/> .'
echo

FEATURES=553188
TAGS=554268
TAGVALS=2

TRIPLES=3876636
PROPERTIES=6
CLASSES=4
ENTITIES=1107456
SUBJECTS=1660644
OBJECTS=1660652

BASE_URI="http://geographica.di.uoa.gr/generator"

for i in $SEQUENCE
do
  N=`expr $i + 1`
  J=`expr $i / 10`
  BOUNDINGWKT=`cat /tmp/wkts.txt | head -n $N | tail -n 1`
  
  echo
  echo 'dataset:'$i' a void:Dataset ;'
  echo '  void:propertyPartition ['
  echo '    void:property rdf:type ;'
  echo '    void:triples "'$ENTITIES'"^^xsd:int ;'
  echo '    void:distinctSubjects "'$ENTITIES'"^^xsd:int ;'
  echo '    void:distinctObjects  "'$CLASSES'"^^xsd:int ;'
  echo '    svd:subjectRegexPattern "'$BASE_URI'/'$i'/" ;'
  echo '    svd:objectRegexPattern  "'$BASE_URI'/'$i'/" ;'
  echo '  ] , ['
  echo '    void:property geo:hasGeometry ;'
  echo '    void:triples "'$FEATURES'"^^xsd:int ;'
  echo '    void:distinctSubjects "'$FEATURES'"^^xsd:int ;'
  echo '    void:distinctObjects  "'$FEATURES'"^^xsd:int ;'
  echo '    svd:subjectRegexPattern "'$BASE_URI'/'$i'/" ;'
  echo '    svd:objectRegexPattern  "'$BASE_URI'/'$i'/" ;'
  echo '  ] , ['
  echo '    void:property geo:asWKT ;'
  echo '    void:triples "'$FEATURES'"^^xsd:int ;'
  echo '    void:distinctSubjects "'$FEATURES'"^^xsd:int ;'
  echo '    void:distinctObjects  "'$FEATURES'"^^xsd:int ;'
  echo '    svd:subjectRegexPattern "'$BASE_URI'/'$i'/" ;'
  echo '  ] , ['
  echo '    void:property gg:hasTag ;'
  echo '    void:triples "'$TAGS'"^^xsd:int ;'
  echo '    void:distinctSubjects "'$FEATURES'"^^xsd:int ;'
  echo '    void:distinctObjects  "'$TAGS'"^^xsd:int ;'
  echo '    svd:subjectRegexPattern "'$BASE_URI'/'$i'/" ;'
  echo '    svd:objectRegexPattern  "'$BASE_URI'/'$i'/" ;'
  echo '  ] , ['
  echo '    void:property gg:hasKey ;'
  echo '    void:triples "'$TAGS'"^^xsd:int ;'
  echo '    void:distinctSubjects "'$TAGS'"^^xsd:int ;'
  echo '    void:distinctObjects  "'$TAGVALS'"^^xsd:int ;'
  echo '    svd:subjectRegexPattern "'$BASE_URI'/'$i'/" ;'
  echo '  ] , ['
  echo '    void:property gg:hasValue ;'
  echo '    void:triples "'$TAGS'"^^xsd:int ;'
  echo '    void:distinctSubjects "'$TAGS'"^^xsd:int ;'
  echo '    void:distinctObjects  "'$TAGVALS'"^^xsd:int ;'
  echo '    svd:subjectRegexPattern "'$BASE_URI'/'$i'/" ;'
  echo '  ] ;'
  echo '  void:sparqlEndpoint <http://pbd'$i'.pbbench'$J'.svc.cluster.local:8080/Strabon/Query> ;'
  echo '  void:triples "'$TRIPLES'"^^xsd:int ;'
  echo '  void:properties "'$PROPERTIES'"^^xsd:int ;'
  echo '  void:classes  "'$CLASSES'"^^xsd:int ;'
  echo '  void:entities "'$ENTITIES'"^^xsd:int ;'
  echo '  void:distinctSubjects "'$SUBJECTS'"^^xsd:int ;'
  echo '  void:distinctObjects  "'$OBJECTS'"^^xsd:int ;'
  echo '  svd:boundingWKT "<http://www.opengis.net/def/crs/EPSG/0/4326> '$BOUNDINGWKT'"^^geo:wktLiteral .'
  echo
done

echo
echo '[] a svd:Join ;'
echo '  svd:joins'

for i in $SEQUENCE
do
  if [ "$i" -eq "$MAXNUM" ]
  then
    echo '    dataset:'$i' ;'
  else
    echo '    dataset:'$i' ,'
  fi
done

echo '  svd:selectivity [ svd:selectivityValue "0"^^xsd:int ] .'
echo
echo

rm /tmp/wkts.txt
