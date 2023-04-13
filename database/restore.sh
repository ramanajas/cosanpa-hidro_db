#!/bin/bash

set -e

export LOG=/backup/logs/hidro_db.log
export DATABASE=hidro_db_dev
export DUMP=/backup/00-pg_dump_google_db_all_plain-202304.sql
export USER=gis

echo "Inicio: " `date +%c`> $LOG && \
echo " " >> $LOG && \
  psql -U $USER -d $DATABASE < $DUMP >> $LOG && \
echo " " >> $LOG && \
  psql -U $USER -d $DATABASE -c 'analyze verbose;' >> $LOG && \
echo " " >> $LOG && \
echo "Fim: " `date +%c`>> $LOG &
