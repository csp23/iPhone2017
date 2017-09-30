myCal: myCal.m main.m
	clang -fno-objc-arc -framework foundation myCal.m main.m -o myCal

test:
	./myCal && ./myCal 9 2017 && ./myCal 2017

run:
	./myCal

clean:
	rm myCal
