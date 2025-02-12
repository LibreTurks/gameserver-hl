FROM debian:bookworm-slim

############# LOCALES & DEPENDENCIES & ENVs ##############
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --no-install-recommends \
    locales ca-certificates curl:i386 lib32gcc-s1 libstdc++6:i386 unzip xz-utils zip && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
ENV LANG=en_US.utf8
ENV LC_ALL=en_US.UTF-8
ENV CPU_MHZ=2300
ARG STEAMCMD_URL="https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz"
##########################################################



########## CREATE STEAM USER & INSTALL STEAMCMD ##########
#~ Create steam user
RUN groupadd -r steam && useradd -r -g steam -m -d /opt/steam steam

#~ Install steamcmd and svencoop
USER steam
WORKDIR /opt/steam
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
COPY ./lib/svends.install /opt/steam
RUN curl -sL "$STEAMCMD_URL" | tar xzvf - \
  && mkdir -p "$HOME/.steam" svends/svencoop/config \
  && ln -s "$PWD/linux32" "$HOME/.steam/sdk32" \
  && ./steamcmd.sh +runscript svends.install

#~ Touch files for warnings
RUN touch svends/svencoop/listip.cfg
RUN touch svends/svencoop/banned.cfg
RUN touch svends/svencoop/config/server.cfg

#~ Install opposing force
COPY ./lib/opfor.install /opt/steam
RUN ./steamcmd.sh +runscript opfor.install

#~ Install opfor support
RUN pushd svends/svencoop && bash ./Install_OpFor_Support.sh && popd

#~ Cleanup
RUN rm -rf Half-Life opfor.install svends.install
#########################################################



############# PERMISSIONS & WORKDIR & PORTS ##############
#~ Copy default folder
COPY ./svends /opt/steam/svends/svencoop/

#~ Copy wrapper script
COPY ./lib/wrapper.sh /opt/steam/svends

#~ Change workdir and permissions
WORKDIR /opt/steam/svends
USER root
RUN chown -R steam:steam /opt/steam
RUN chmod +x svends_run
USER steam
RUN echo 276060 > steam_appid.txt                # 276060: svencoop

#~ Expose ports
EXPOSE 27015 27015/udp

#~ Change default entrypoint
ENTRYPOINT ["./wrapper.sh"]
##########################################################