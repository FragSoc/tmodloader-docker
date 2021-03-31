<center>
    <a href="https://tmodloader.net/">
        <img alt="tmodloader banner" width=100% src="https://cdn.cloudflare.steamstatic.com/steam/apps/1281930/capsule_616x353.jpg?t=1600682898"/>
    </a>
    <img alt="license badge" src="https://img.shields.io/github/license/FragSoc/tmodloader-docker?style=flat-square"/>
</center>

---

# Quickstart

Build this repo's image:

```bash
docker build -t tmodloader https://github.com/FragSoc/tmodloader-docker.git
```

Then follow the steps below to run.

## With Existing World

If you have a world you've previously generated, you can use it as a drop-in with this server.

1. Copy your existing world files (`.wld` and `.twld`) to a folder you can view
1. Rename them to `dockerWorld.wld` and `dockerWorld.twld`
1. Run the server:

```bash
docker run -v <absolute-path-to-folder-with-worlds>:/worlds -p 7777:7777 fragsoc/tmodloader
```

## Without World

If you want to use the server to generate a world, you need to use the interactive mode.

1. Run the server to generate the world (don't forget those speech marks):

```bash
docker run -it --rm -v <absolute-path-to-folder-to-put-worlds-in>:/worlds fragsoc/tmodloader ""
```

2. Follow the onscreen prompts to generate your world - **name it `dockerWorld`**
3. Follow the "With Existing World" instructions with your new world files

# Usage

- The container exposes port `7777` on TCP, ensure to forward it
- The container will put logfiles in `/logs`; note that this is not a volume
- To install mods, insert them into the `/mods` volume as if it were the `Mods` folder, then follow normal configuration steps
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

The contents of this repo are licensed under the [GNU AGPL](https://www.gnu.org/licenses/agpl-3.0.en.html).
However, the software contained in the final image contains from both [ReLogic](https://re-logic.com/) and [tModLoader](https://tmodloader.net/).
No credit is taken for this software, and this image is __not__ uploaded to docker hub or any other registry.
