obj = cudatrace.o
bin = cudatrace
src = cudatrace.cu

CC = nvcc
CFLAGS = -g -G -O0 -arch sm_20 -lm -lpthread -m64

$(bin): $(src)
	$(CC) -o $@ $(src) $(CFLAGS)

.PHONY: test
test:
	./$(bin) -i c-ray-1.1/scene -o scene.ppm

.PHONY: testo
testo:
	./$(bin) -i c-ray-1.1/scene -o scene.ppm; open scene.ppm

.PHONY: memcheck
memcheck:
	cuda-memcheck ./$(bin) -i c-ray-1.1/scene -o scene.ppm

.PHONY: cuda-gdb
cuda-gdb:
	cuda-gdb ./$(bin) -i c-ray-1.1/scene -o scene.ppm

.PHONY: clean
clean:
	rm -f $(obj) $(bin)

.PHONY: install
install:
	cp $(bin) /usr/local/bin/$(bin)

.PHONY: uninstall
uninstall:
	rm -f /usr/local/bin/$(bin)
