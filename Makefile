.PHONY:	clean debug run

CC		= gcc
CFLAGS	= -Wall -c -g -m64 -O0
LDFLAGS	= -Wall
LDLIBS	= -lm
PROG	= main
OBJS	= main.o gnuplot_i.o my_std.o equalizer.o complex.o string.o wave.o
DEPS	= $(OBJS:.o=.h)
GARBAGE = *.png *.mat gnuplot_tmpdatafile_* output.wav
RM		= rm -f


all:	$(PROG)

$(PROG):	$(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

%.o:	%.c $(DEPS)
	$(CC) $(CFLAGS) -o $@ $<

main.o:	gnuplot_i.o equalizer.o complex.o string.o	#? $(OBJS)


debug:	clean $(PROG)
#	valgrind 2>valgrind.log --track-origins=yes --leak-check=full --show-leak-kinds=all ./main -d 90 -f sample.in >main.log
	valgrind 2>valgrind.log --track-origins=yes --leak-check=full --show-leak-kinds=all ./main -f "dve-32.wav" -w -o "output.wav" -k 5f-24 >$(PROG).log

INFILE = "flute-A4.wav"
#INFILE = "dve-32.wav"
#INFILE = "singing-female.wav"
run:	clean $(PROG)
#	./main -d 80 -f sample.in >main.log
	./main -f $(INFILE) -w -o "output.wav" -k 5p+1,9p-2 >$(PROG).log
	mplayer $(INFILE) 1>/dev/null
	mplayer "output.wav" 1>/dev/null

clean:
	$(RM) $(GARBAGE) $(PROG) $(OBJS)
