# Flexran controller packaged in docker image
This project is a repackaging of flexran snap into a docker image

## How to use

### Already existing image
If available, use the built image preferably. Otherwise you can build from the content of the dir as follows
The images I built and pushed to the public docker hub are: `sofianinho/flexran:debian` or `sofianinho/flexran:snap`

### Rebuild your own
You can rebuild from scratch. You only need to have a folder with the content of the flexran snap (you can find it in Ubuntu under /snap once the snap is installed).
The expected tree of the `snap-flexran` folder is:

```terminal
./snap-flexran/
├── bin
│   ├── flexran
│   ├── gdb
│   ├── gdb-add-index
│   ├── gdbserver
│   ├── gdbtui
│   ├── gdbus
│   ├── gdbus-codegen
│   ├── protoc
│   ├── protoc-c
│   └── protoc-gen-c
├── etc
│   ├── nbi_config.sh
│   ├── nbi_config.sh~
│   ├── sbi_config.sh
│   └── sbi_config.sh~
├── lib
│   ├── libpistache.a
│   └── x86_64-linux-gnu
├── log_config
│   ├── basic_log
│   └── debug_log
├── share
│   └── gdb
└── usr
    ├── lib
    └── local
```

Which means that the Dockerfile at the same level as the `snap-flexran` folder can be used like this:
```sh
docker build --build-arg http_proxy=$http_proxy --build-arg https_proxy=$https_proxy -t flexran:snap .
```

I can unfortunately not share the content of the folder since the binary is too big for a git repo (about 230 MB)

## Licensing with regards to the mosaic community
This is not an official mosaic community project. The official way of deploying flexran is the use of the official snap from the store.

This project is personnal and unofficial at the moment. The use and license of the project flexran is thus the right one for the use of this project.

## Start the container

```sh
docker run --rm -it --privileged -p 2210:2210 -p 9999:9999 flexran:snap
```

## Additional notes
- Although both udp and tcp ports are open in the container, in the proposed run command only tcp is exposed. If your flexran does not connect to the eNodeB or your northbound app, take this into consideration and try to debug by adding `-p 2210/udp:2210/udp -p 9999/udp:9999/udp`
- I chose to give the full privileges to the container. You could argue only some of the capabilities are necessary to the proper working of flexran. If you checked the right capabilities, please report I would update accordingly (thanks in advance).
- Now that it is proven to work, one could go to optimize the path structure by removing everything snap related, as only the bin directory plus the logging (and other, which ?) are used. If someone could look it up in an iterative kind of approach and cleans up the docker image, I am interested.
- This is how I would see this rebuild happening in a ci/cd fashion with no fuss (maybe if I have time :-) ):
    - Use the Ubuntu 16.04 VM as privileged user with travis-ci 
    - Write your travis-ci.yml to start the VM, download the flexran-snap in the wanted version
    - Change path to the Dockerfile, rebuild the docker image, tag accordingly to the version, and push to the hub. 

In my opinion, this is the cleanest way to automate the snap-to-docker work if you use this way. Otherwise, I suggest the transition from code to Docker given the sources. Such as illustrated in [my repo for the enodeB](https://github.com/sofianinho/docker-openairinterface-enb/blob/master/Dockerfile)
