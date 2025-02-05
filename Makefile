CC=			gcc
CFLAGS=		-g -Wall -Wc++-compat -std=c99 -O2
CPPFLAGS=
INCLUDES=
OBJS=
PROG=		sdust sdust_mask sdust_frag sdust_low
LIBS=		-lz

ifneq ($(asan),)
	CFLAGS+=-fsanitize=address
	LIBS+=-fsanitize=address
endif

.SUFFIXES:.c .o
.PHONY:all clean depend

.c.o:
		$(CC) -c $(CFLAGS) $(CPPFLAGS) $(INCLUDES) $< -o $@

all:$(PROG)

sdust:sdust.o
		$(CC) $(CFLAGS) $^ -o $@ $(LIBS)

sdust_mask:sdust_mask.o
		$(CC) $(CFLAGS) $^ -o $@ $(LIBS)

sdust_low:sdust_low.o
		$(CC) $(CFLAGS) $^ -o $@ $(LIBS)

sdust_frag:sdust_frag.o
		$(CC) $(CFLAGS) $^ -o $@ $(LIBS)

clean:
		rm -fr gmon.out *.o a.out $(PROG) *~ *.a *.dSYM

depend:
		(LC_ALL=C; export LC_ALL; makedepend -Y -- $(CFLAGS) $(DFLAGS) -- *.c)

# DO NOT DELETE

sdust.o: kdq.h kalloc.h kvec.h sdust.h ketopt.h kseq.h
sdust_mask.o: kdq.h kalloc.h kvec.h sdust.h ketopt.h kseq.h
sdust_frag.o: kdq.h kalloc.h kvec.h sdust.h ketopt.h kseq.h
sdust_low.o: kdq.h kalloc.h kvec.h sdust.h ketopt.h kseq.h
