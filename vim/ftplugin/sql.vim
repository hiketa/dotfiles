" ----------------------------------------------------------
"  quickrun
" ----------------------------------------------------------

let g:quickrun_config.sql = {
\  'command': 'psql',
\  'args': "--dbname='%{g:hiket_pgsql_dbname}'",
\  'exec': "%c %a -f '%s'",
\}
