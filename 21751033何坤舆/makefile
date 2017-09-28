DIR_SRC = ./
SRC = $(wildcard ${DIR_SRC}/*.m)

TARGET = cal

CC = clang
CFLAGS = -fno-objc-arc -framework foundation

install: ${SRC}
	${CC} ${CFLAGS} ${SRC} -o ${TARGET}

run:
	./${TARGET}

test:
	./${TARGET} && ./${TARGET} 2017 && ./${TARGET} 9 2017

clean:
	rm ${TARGET}
