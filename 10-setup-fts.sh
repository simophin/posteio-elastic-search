#!/usr/bin/with-contenv bash

cat > /etc/dovecot/conf.d/11-fts.conf << EOF
mail_plugins = \$mail_plugins fts fts_elastic

plugin {
  fts = elastic
  fts_elastic = debug url=${ELASTICSEARCH_URL}/m/ bulk_size=5000000 refresh=fts rawlog_dir=/var/log/fts-elastic/

# no indexes new emails when user make search
# yes indexes every email when delivered
  fts_autoindex = yes
  fts_autoindex_exclude = \\Junk
  fts_autoindex_exclude2 = \\Trash
}
EOF

cat /etc/dovecot/conf.d/11-fts.conf