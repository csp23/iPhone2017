DIR_SRC = .
SRC = $(wildcard ${DIR_SRC}/*.m)

TARGET = cal

cc = clang

CFLAGS = -fno-objc-arc -framework foundation

install:${SRC}
	${cc} ${CFLAGS} ${SRC} -o ${TARGET}

test:
	./${TARGET} && ./${TARGET} 2017 && ./${TARGET} 10 2017

clean:
	rm ${TARGET}
