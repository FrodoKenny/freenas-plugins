#!/bin/sh
#########################################

crashplan_pbi_path=/usr/pbi/crashplan-$(uname -m)

/bin/cp ${crashplan_pbi_path}/etc/rc.d/crashplan /usr/local/etc/rc.d/
ln -s ${crashplan_pbi_path}/bin/bash /bin/bash
cp /usr/local/lib/libsqlite3.so* ${crashplan_pbi_path}/lib/

ln -sf ${crashplan_pbi_path}/compat /compat
if [ -d "${crashplan_pbi_path}/share/crashplan/log" ]; then
	mv ${crashplan_pbi_path}/share/crashplan/log /var/log/crashplan
else
	mkdir /var/log/crashplan
fi
ln -sf /var/log/crashplan ${crashplan_pbi_path}/share/crashplan/log
if [ -d "${crashplan_pbi_path}/share/crashplan/cache" ]; then
	mv ${crashplan_pbi_path}/share/crashplan/cache /var/cache/crashplan
else
	mkdir /var/cache/crashplan
fi
ln -sf /var/cache/crashplan ${crashplan_pbi_path}/share/crashplan/cache

${crashplan_pbi_path}/bin/python2.7 ${crashplan_pbi_path}/crashplanUI/manage.py syncdb --migrate --noinput
