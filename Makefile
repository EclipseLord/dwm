# dwm - dynamic window manager hah
# See LICENSE file for copyright and license details.

include config.mk

SRC = drw.c dwm.c util.c
OBJ = ${SRC:.c=.o}

all: options dwm st slstatus

options:
	@echo dwm build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk

config.h:
	cp config.def.h $@

dwm: ${OBJ}
	${CC} -o $@ ${OBJ} ${LDFLAGS}

st:
	$(MAKE) -C st

slstatus:
	$(MAKE) -C slstatus

install_st:
	$(MAKE) -C st install

install_slstatus:
	$(MAKE) -C slstatus install

clean_st:
	$(MAKE) -C st clean

clean_slstatus:
	$(MAKE) -C slstatus clean

clean_dwm:
	rm -f dwm ${OBJ} dwm-${VERSION}.tar.gz	

clean_configs:
	rm -f config.h
	rm -f st/config.h
	rm -f slstatus/config.h

clean: clean_dwm clean_st clean_slstatus clean_configs

install: all st install_st slstatus install_slstatus
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f dwm ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/dwm
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	sed "s/VERSION/${VERSION}/g" < dwm.1 > ${DESTDIR}${MANPREFIX}/man1/dwm.1
	chmod 644 ${DESTDIR}${MANPREFIX}/man1/dwm.1
	
uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dwm\
		${DESTDIR}${MANPREFIX}/man1/dwm.1

.PHONY: all options st slstatus install uninstall
