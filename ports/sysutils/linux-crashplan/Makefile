# $FreeBSD$

PORTNAME=	linux-crashplan
DISTVERSION=	4.7.0
CATEGORIES=	sysutils linux
MASTER_SITES=	https://download.code42.com/installs/linux/install/CrashPlan/ \
		https://download.code42.com/installs/proserver/jre/
DISTFILES=	CrashPlan_${DISTVERSION}_Linux${EXTRACT_SUFX} jre-7-linux-i586${EXTRACT_SUFX}

MAINTAINER=	subtil@gmail.com
COMMENT=	Backs up data to remote servers or hard drives

RUN_DEPENDS=	bash>=0:shells/bash \
		patchelf>=0:sysutils/patchelf

WRKSRC=		${WRKDIR}/crashplan-install

USE_LINUX=	yes
USE_LINUX_APPS=	expat fontconfig xorglibs
USE_RC_SUBR=	crashplan
USES=		shebangfix tar:tgz

BIN_DIRS=       bin
LIB_DIRS=       ${BIN_DIRS:S|bin$|lib|}

SHEBANG_FILES=	scripts/CrashPlanEngine scripts/CrashPlanDesktop

ONLY_FOR_ARCHS=	i386 amd64

NO_BUILD=	yes

CRASHDIR=	${PREFIX}/share/crashplan

do-install:
	@${MKDIR} ${STAGEDIR}${CRASHDIR}
	cd ${STAGEDIR}${CRASHDIR} && ${CAT} ${WRKSRC}/CrashPlan_${DISTVERSION}.cpi | ${GZIP_CMD} -d -c - | ${CPIO} -i --no-preserve-owner
	${INSTALL_SCRIPT} ${WRKSRC}/scripts/CrashPlanDesktop ${STAGEDIR}${PREFIX}/bin/
	${INSTALL_SCRIPT} ${WRKSRC}/scripts/CrashPlanEngine ${STAGEDIR}${CRASHDIR}/bin/
	${CP} ${WRKSRC}/scripts/run.conf ${STAGEDIR}${CRASHDIR}/bin/
	@cd ${WRKDIR}/jre && ${COPYTREE_SHARE} . ${STAGEDIR}${CRASHDIR}/jre
	@cd ${STAGEDIR}${CRASHDIR}/jre && \
            ${CHMOD} ${BINMODE} ${BIN_DIRS:S|$|/*|} ${LIB_DIRS:S|$|/jexec|}
	${ECHO_CMD} > ${STAGEDIR}${CRASHDIR}/install.vars
	${ECHO_CMD} "TARGETDIR=${CRASHDIR}" >> ${STAGEDIR}${CRASHDIR}/install.vars
	${ECHO_CMD} "BINSDIR=${CRASHDIR}/bin" >> ${STAGEDIR}${CRASHDIR}/install.vars
	${ECHO_CMD} "JAVACOMMON=${CRASHDIR}/jre/bin/java" >> ${STAGEDIR}${CRASHDIR}/install.vars
	${CAT} ${WRKSRC}/install.defaults >> ${STAGEDIR}${CRASHDIR}/install.vars

.include <bsd.port.mk>
