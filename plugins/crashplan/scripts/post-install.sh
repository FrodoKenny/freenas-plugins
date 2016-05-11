#!/bin/sh
#########################################

crashplan_pbi_path=/usr/pbi/crashplan-$(uname -m)

/bin/cp ${crashplan_pbi_path}/etc/rc.d/crashplan /usr/local/etc/rc.d/

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

#For some reason the default relative RPATH doesnt work in java bin
${crashplan_pbi_path}/bin/patchelf \
	--set-rpath ${crashplan_pbi_path}/linux-sun-jre1.7.0/lib/i386/jli \
	${crashplan_pbi_path}/linux-sun-jre1.7.0/bin/java

${crashplan_pbi_path}/bin/python2.7 ${crashplan_pbi_path}/crashplanUI/manage.py syncdb --migrate --noinput
