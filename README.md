<center>
    <a href="https://tmodloader.net/">
        <img alt="tmodloader banner" width=100% src="https://cdn.cloudflare.steamstatic.com/steam/apps/1281930/capsule_616x353.jpg?t=1600682898"/>
    </a>
    <img alt="license badge" src="https://img.shields.io/github/license/FragSoc/tmodloader-docker?style=flat-square"/>
</center>

---

# Quickstart

Clone this repo, change into it's directory and build the docker image:

```
$ git clone https://github.com/FragSoc/tmodloader-docker
$ cd tmodloader-docker
$ docker build -t fragsoc/tmodloader .
```

Then follow the steps below to run.

## With Existing World

If you have a world you've previously generated, you can use it as a drop-in with this server.

1. Copy your existing world files (`.wld` and `.twld`) to a folder you can view
2. Rename them to `dockerWorld.wld` and `dockerWorld.twld`
3. Run the server:

```
docker run -v <absolute-path-to-folder-with-worlds>:/worlds fragsoc/tmodloader
```

## Without World

**TODO**: add me!

# Usage

- The container exposes port `7777` on TCP, ensure to forward it
- The container will put logfiles in `/logs`; note that this is not a volume
- A custom config file can be mounted into the container, then used by overriding the command with `-config <path-to-file-in-container>`

## Volumes

Location | Purpose
---|---
`/worlds` | Worlds, corresponds to `~/.local/share/Terraria/ModLoader/Worlds`
`/mods` | Mods, corresponds to `~/.local/share/Terraria/ModLoader/Mods`

## Build Args

Arg Name | Default | Purpose
---|---|---
`UID` | `999` | Unix UID to use when running the server
`SERVER_VER` | `1412` | Terraria version integer (numeric chars only)
`SERVER_VER_INC` | `042` | Terraria version increment, used for server downloads
`TMODLOADER_VERSION` | `v0.11.8.1` | tModLoader version string

# Licensing

The contents of this repo are licensed under the [GNU AGPL]().
However, the software contained in the final image contains from both [ReLogic](https://re-logic.com/) and [tModLoader](https://tmodloader.net/).
No credit is taken for this software.
