#!/bin/bash

/usr/bin/sqlite3 development.sqlite3 <<!
.headers on
.mode csv
.output clinicas.csv
select * from places;
!