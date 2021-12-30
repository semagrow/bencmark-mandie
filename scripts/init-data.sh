#!/bin/bash

GENERATOR_NT=$1

head -n 104  $GENERATOR_NT > ontology.nt
tail -n +104 $GENERATOR_NT > rest.nt
grep state rest.nt > state.nt
grep landOwnership rest.nt > landOwnership.nt
grep pointOfInterest rest.nt > pointOfInterest.nt
grep road rest.nt > road.nt

sed -i 's|<http://geographica.di.uoa.gr/generator/state/hasGeometry>|<http://www.opengis.net/ont/geosparql#hasGeometry>|g' state.nt
sed -i 's|<http://geographica.di.uoa.gr/generator/state/asWKT>|<http://www.opengis.net/ont/geosparql#asWKT>|g' state.nt
sed -i 's|<http://geographica.di.uoa.gr/generator/state/hasTag>|<http://geographica.di.uoa.gr/ontology/hasTag>|g' state.nt
sed -i 's|<http://geographica.di.uoa.gr/generator/state/hasKey>|<http://geographica.di.uoa.gr/ontology/hasKey>|g' state.nt
sed -i 's|<http://geographica.di.uoa.gr/generator/state/hasValue>|<http://geographica.di.uoa.gr/ontology/hasValue>|g' state.nt
sed -i 's|<http://geographica.di.uoa.gr/generator/state/State>|<http://geographica.di.uoa.gr/ontology/State>|g' state.nt
sed -i 's|<http://geographica.di.uoa.gr/generator/state/Tag>|<http://geographica.di.uoa.gr/ontology/Tag>|g' state.nt

sed -i 's|<http://geographica.di.uoa.gr/generator/landOwnership/hasGeometry>|<http://www.opengis.net/ont/geosparql#hasGeometry>|g' landOwnership.nt
sed -i 's|<http://geographica.di.uoa.gr/generator/landOwnership/asWKT>|<http://www.opengis.net/ont/geosparql#asWKT>|g' landOwnership.nt
sed -i 's|<http://geographica.di.uoa.gr/generator/landOwnership/hasTag>|<http://geographica.di.uoa.gr/ontology/hasTag>|g' landOwnership.nt
sed -i 's|<http://geographica.di.uoa.gr/generator/landOwnership/hasKey>|<http://geographica.di.uoa.gr/ontology/hasKey>|g' landOwnership.nt
sed -i 's|<http://geographica.di.uoa.gr/generator/landOwnership/hasValue>|<http://geographica.di.uoa.gr/ontology/hasValue>|g' landOwnership.nt
sed -i 's|<http://geographica.di.uoa.gr/generator/landOwnership/LandOwnership>|<http://geographica.di.uoa.gr/ontology/LandOwnership>|g' landOwnership.nt
sed -i 's|<http://geographica.di.uoa.gr/generator/landOwnership/Tag>|<http://geographica.di.uoa.gr/ontology/Tag>|g' landOwnership.nt

sed -i 's|<http://geographica.di.uoa.gr/generator/pointOfInterest/hasGeometry>|<http://www.opengis.net/ont/geosparql#hasGeometry>|g' pointOfInterest.nt
sed -i 's|<http://geographica.di.uoa.gr/generator/pointOfInterest/asWKT>|<http://www.opengis.net/ont/geosparql#asWKT>|g' pointOfInterest.nt
sed -i 's|<http://geographica.di.uoa.gr/generator/pointOfInterest/hasTag>|<http://geographica.di.uoa.gr/ontology/hasTag>|g' pointOfInterest.nt
sed -i 's|<http://geographica.di.uoa.gr/generator/pointOfInterest/hasKey>|<http://geographica.di.uoa.gr/ontology/hasKey>|g' pointOfInterest.nt
sed -i 's|<http://geographica.di.uoa.gr/generator/pointOfInterest/hasValue>|<http://geographica.di.uoa.gr/ontology/hasValue>|g' pointOfInterest.nt
sed -i 's|<http://geographica.di.uoa.gr/generator/pointOfInterest/PointOfInterest>|<http://geographica.di.uoa.gr/ontology/PointOfInterest>|g' pointOfInterest.nt
sed -i 's|<http://geographica.di.uoa.gr/generator/pointOfInterest/Tag>|<http://geographica.di.uoa.gr/ontology/Tag>|g' pointOfInterest.nt 
