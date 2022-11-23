include init.mk

EXEC=make_tracks
EXEDIR=../bin
LIBDIR=../lib
LIBRMN=$(RMNLIB)
OPTFLAGS=-O 2

make_tracks: make_tracks.ftn libtracks.a libtracks_tools.a tracks_cte.h
	mkdir -p $(EXEDIR)
	${LOAD_ARCHITECTURE}; \
	. ssmuse-sh -x $(SSM_COMPILER); \
	. ssmuse-sh -x $(SSM_CODE_TOOLS); \
	. ssmuse-sh -x $(SSM_RMNLIB); \
	s.compile -src make_tracks.ftn $(LIBPERF) -o $(EXEDIR)/$(EXEC) -includes . -librmn $(LIBRMN) $(OPTFLAGS) -libpath $(LIBDIR) -libappl "tracks tracks_tools"
	rm -f make_tracks.f make_tracks.o
	rm -rf .fo

libtracks.a: libtracks.ftn tracks_cte.h
	mkdir -p $(LIBDIR)
	${LOAD_ARCHITECTURE}; \
	. ssmuse-sh -x $(SSM_COMPILER); \
	. ssmuse-sh -x $(SSM_CODE_TOOLS); \
	. ssmuse-sh -x $(SSM_RMNLIB); \
	s.compile -src libtracks.ftn $(LIBPERF)  -librmn $(LIBRMN) -includes .
	rm -f libtracks.a 
	ar rv libtracks.a libtracks.o 
	ranlib libtracks.a 
	rm -f libtracks.o libtracks.f
	mv libtracks.a $(LIBDIR)

libtracks_tools.a: libtracks_tools.ftn tracks_cte.h
	mkdir -p $(LIBDIR)
	${LOAD_ARCHITECTURE}; \
	. ssmuse-sh -x $(SSM_COMPILER); \
	. ssmuse-sh -x $(SSM_CODE_TOOLS); \
	. ssmuse-sh -x $(SSM_RMNLIB); \
	s.compile $(LIBPERF)  -src libtracks_tools.ftn -librmn $(LIBRMN) -includes .
	rm -f libtracks_tools.a 
	ar rv libtracks_tools.a libtracks_tools.o 
	ranlib libtracks_tools.a 
	rm -f libtracks_tools.o libtracks_tools.f
	mv libtracks_tools.a $(LIBDIR)

mt2gmt5: mt2gmt5.ftn
	mkdir -p $(EXEDIR)
	${LOAD_ARCHITECTURE}; \
	. ssmuse-sh -x $(SSM_COMPILER); \
	. ssmuse-sh -x $(SSM_CODE_TOOLS); \
	. ssmuse-sh -x $(SSM_RMNLIB); \
	s.compile $(LIBPERF)  -src mt2gmt5.ftn -o $(EXEDIR)/mt2gmt5 -includes . -librmn $(LIBRMN) $(OPTFLAGS) -libpath . -libappl "tracks"
	rm -f mt2gmt5.f mt2gmt5.o

clean:
	rm -f *.o *.f

cleanall: clean
	rm $(EXEDIR)/$(EXEC) $(LIBDIR)/*.a
