FROM debian:buster-slim

COPY ./snap-flexran /app

ENV SNAP=/app \
 SNAP_USER_DATA=/app\
 SNAP_USER_COMMON=/app/common

ENV PATH="$SNAP/usr/sbin:$SNAP/usr/bin:$SNAP/sbin:$SNAP/bin:$PATH"
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$SNAP/lib:$SNAP/usr/lib:$SNAP/lib/x86_64-linux-gnu:$SNAP/usr/lib/x86_64-linux-gnu"
ENV LD_LIBRARY_PATH="$SNAP/usr/lib:$SNAP/usr/lib/x86_64-linux-gnu:$SNAP/usr/local/lib:$LD_LIBRARY_PATH"
ENV SNAP_LIBRARY_PATH=/app/lib
ENV LD_LIBRARY_PATH=$SNAP_LIBRARY_PATH:$LD_LIBRARY_PATH
ENV FLEXRAN_DIR=/app\
 FLEXRAN_RTC_HOME=/app

EXPOSE 2210/tcp 2210/udp 9999/tcp 9999/udp
CMD ["flexran"]
