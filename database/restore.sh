 echo "Inicio: " `date +%c`> /backup/logs/hidro_db.log && \
 echo " " >> /backup/logs/hidro_db.log && \
 psql -U gis -d hidro_db_dev < /backup/pg_dump_google_db_all_plain.sql 2>> /backup/logs/hidro_db.log && \
 echo " " >> /backup/logs/hidro_db.log && \
 psql -U gis -d hidro_db_dev -c 'analyze verbose;' 2>> /backup/logs/hidro_db.log && \
 echo " " >> /backup/logs/hidro_db.log && \
 echo "Fim: " `date +%c`>> /backup/logs/hidro_db.log &
