dwm:
	$(MAKE) -f dwm.mk

dwm_install:
	$(MAKE) -f dwm.mk install

dwm_uninstall:
	$(MAKE) -f dwm.mk uninstall

dwm_clean:
	$(MAKE) -f dwm.mk clean

st:
	$(MAKE) -C st

st_install:
	$(MAKE) -C st install

st_uninstall:
	$(MAKE) -C st uninstall

st_clean:
	$(MAKE) -C st clean

slstatus:
	$(MAKE) -C slstatus

slstatus_install:
	$(MAKE) -C slstatus install

slstatus_uninstall:
	$(MAKE) -C slstatus uninstall

slstatus_clean:
	$(MAKE) -C slstatus clean

all: dwm st slstatus
install: all dwm_install st_install slstatus_install
uninstall: dwm_uninstall st_uninstall slstatus_uninstall
clean: dwm_clean slstatus_clean slstatus_clean

clean_configs:
	rm -f config.h
	rm -f st/config.h
	rm -f slstatus/config.h

.PHONY: all dwm st slstatus clean install uninstall
