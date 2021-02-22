FROM debian:stretch-slim AS downloader

ARG SERVER_VER="1412"
ARG SERVER_VER_INC="042"
ARG TMODLOADER_VERSION="v0.11.8.1"

RUN apt-get update && \
    apt-get install -y unzip curl

RUN curl -L \
        -o /tmp/terrariaServer.zip \
        https://terraria.org/system/dedicated_servers/archives/000/000/${SERVER_VER_INC}/original/terraria-server-${SERVER_VER}.zip && \
    curl -L \
        -o /tmp/tModLoader.zip \
        https://github.com/tModLoader/tModLoader/releases/download/${TMODLOADER_VERSION}/tModLoader.Linux.${TMODLOADER_VERSION}.zip && \
    unzip -d /tmp /tmp/terrariaServer.zip && \
    unzip -d /tmp/tModLoader /tmp/tModLoader.zip

FROM debian:stretch-slim AS runner

ARG SERVER_VER="1412"
ARG UID="999"

ENV INSTALL_LOC="/terraria"
ENV WORLDS_LOC="/worlds"
ENV MODS_LOC="/mods"
ENV LOGS_LOC="/logs"

ENV TERRARIA_DATA="/root/.local/share/Terraria/ModLoader"

# TODO: fix; readd chowns to COPYs, adjust TERRARIA_DATA etc
# RUN useradd -m -u ${UID} -s /bin/false terraria

COPY --from=downloader /tmp/${SERVER_VER}/Linux ${INSTALL_LOC}
COPY --from=downloader /tmp/tModLoader/* ${INSTALL_LOC}/
COPY ./default-config.txt /default-config.txt

RUN chmod +x ${INSTALL_LOC}/tModLoaderServer* && \
    mkdir -p ${TERRARIA_DATA} ${LOGS_LOC} && \
    ln -s ${WORLDS_LOC} ${TERRARIA_DATA}/Worlds && \
    ln -s ${MODS_LOC} ${TERRARIA_DATA}/Mods && \
    ln -s ${LOGS_LOC} ${TERRARIA_DATA}/Logs
    # chown -R terraria:terraria ${TERRARIA_DATA}

VOLUME ${WORLDS_LOC} ${MODS_LOC}
WORKDIR ${INSTALL_LOC}
EXPOSE 7777
# USER terraria
ENTRYPOINT ["./tModLoaderServer.bin.x86_64"]
CMD ["-config", "/default-config.txt"]
