# dwm - dynamic window manager
# See LICENSE file for copyright and license details.

include config.mk

SRC = drw.c dwm.c util.c
OBJ = ${SRC:.c=.o}

SRC_BLOCKS = dwmblocks/dwmblocks.c
OBJ_BLOCKS = ${SRC_BLOCKS:.c=.o}

all: options dwm dwmblocks

options:
	@echo dwm build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk
${OBJ_BLOCKS}: blocks.h

config.h:
	cp config.def.h $@

blocks.h:
	cp dwmblocks/blocks.def.h dwmblocks/$@

dwm: ${OBJ}
	${CC} -o $@ ${OBJ} ${LDFLAGS}

dwmblocks: ${OBJ_BLOCKS}
	mv $(shell basename -- $@).o dwmblocks/$(shell basename -- $@).o
	${CC} -o dwmblocks/$@ ${OBJ_BLOCKS} ${LDFLAGS}

clean:
	rm -f dwm ${OBJ} dwm-${VERSION}.tar.gz

cleanblocks:
	rm -f dwmblocks/${OBJ_BLOCKS}

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f dwm ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/dwm
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	sed "s/VERSION/${VERSION}/g" < dwm.1 > ${DESTDIR}${MANPREFIX}/man1/dwm.1
	chmod 644 ${DESTDIR}${MANPREFIX}/man1/dwm.1
	
	cp -f dwmblocks/dwmblocks ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/dwmblocks

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dwm\
		${DESTDIR}${MANPREFIX}/man1/dwm.1

.PHONY: all options clean cleanblocks install uninstall
