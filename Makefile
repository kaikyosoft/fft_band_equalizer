.PHONY: clear

CC			= gcc
CFLAGS	= -Wall -c -g -m64 -O0#-O3 -I./src
LDFLAGS	= -Wall
LDLIBS	= -lm
PROG		= main
OBJS		= main.o gnuplot_i.o fft.o complex.o string.o
DEPS		= $(OBJS:.o=.h)
RM			= rm -f *.png *.mat gnuplot_tmpdatafile_*


all:	$(PROG)

$(PROG):	$(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

%.o:	%.c $(DEPS)
	$(CC) $(CFLAGS) -o $@ $<

#gnuplot_i.o:	gnuplot_i.c gnuplot_i.h
#	${CC} ${CFLAGS} -o gnuplot_i.o gnuplot_i.c
#
#fft.o: fft.c fft.h
#	${CC} ${CFLAGS} -o fft.o fft.c
#
#main.o: main.c
#	${CC} ${CFLAGS} -o main.
#
#main:	gnuplot_i.o fft.o main.c
#	${CC} ${LDLAGS} -o main main.c gnuplot_i.o fft.o -lm

main.o:	gnuplot_i.o fft.o complex.o string.o	#? $(OBJS)


debug:	clean $(PROG)
	valgrind 2>valgrind.log --track-origins=yes --leak-check=full --show-leak-kinds=all ./main -d 90 -f sample.in >main.log

run:	clean $(PROG)
	./main -d 80 -f sample.in >main.log

clean:
	$(RM) $(PROG) $(OBJS)