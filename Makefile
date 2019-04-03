SRC=$(wildcard *.cpp)
O=$(SRC:.cpp=.o)
livedir=../live555/live
ffmpegdir=/usr/local/opt/ffmpeg
CFLAGS=-I/usr/local/opt/ffmpeg/include \
	   -I$(livedir)/UsageEnvironment/include \
		-I$(livedir)/groupsock/include \
		-I$(livedir)/liveMedia/include \
	   -I$(livedir)/BasicUsageEnvironment/include
CXXFLAGS=-std=c++11 $(CFLAGS)
LIBS=-L $(livedir)/BasicUsageEnvironment -lBasicUsageEnvironment \
	 -L $(livedir)/UsageEnvironment -lUsageEnvironment \
	 -L $(livedir)/groupsock -lgroupsock \
	 -L $(livedir)/liveMedia -lliveMedia \
	 -L $(ffmpegdir)/lib -lavcodec -lavutil -lswscale -lswresample\
	 -lavformat -lavresample -lavdevice

all: ffrtspsvr

ffrtspsvr: $(O)
	$(CXX) $(LDFLAGS) -o $@ $^ $(LIBS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@ 

clean:
	rm -rf *.o
