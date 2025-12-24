# Half-Life Unified Game Server

A production-ready, containerized game server solution supporting **Counter-Strike 1.6**, **Half-Life**, and **Sven Co-op**.

This project provides pre-built, optimized images powered by the **ReHLDS** stack (for CS/HL) and official **SvenDS**.

## 🚀 Quick Start (For Users)

You do not need to build anything. The easiest way to run a server is using the provided Compose files, which pull the latest stable images from the GitHub Container Registry.

### 1. Counter-Strike 1.6
```bash
docker compose -f docker-compose.cstrike.yml up -d
```

### 2. Half-Life
```bash
docker compose -f docker-compose.halflife.yml up -d
```

### 3. Sven Co-op
```bash
docker compose -f docker-compose.svencoop.yml up -d
```

The server will start and listen on port **27015** (UDP/TCP).

---

## ⚙️ Configuration

### Customizing Server Files
You don't need to rebuild the image to add maps, plugins, or change configurations. Simply place your files in the local directory mapped to the container.

Each Compose file maps a local folder to `/opt/steam/custom` inside the container. On startup, these files are copied over the default game files.

| Game | Local Folder | Target in Container |
|------|--------------|---------------------|
| **CS 1.6** | `./cstrike/` | `cstrike/` |
| **Half-Life** | `./valve/` | `valve/` |
| **Sven Co-op** | `./svencoop/` | `svencoop/` |

**Example:** To add a new map to CS 1.6, put the `.bsp` file in `cstrike/maps/` on your host machine and restart the container.

### Server Configs
- **server.cfg**: Edit the `server.cfg` in your local game folder (e.g., `cstrike/server.cfg`).
- **Mapcycle**: Edit `mapcycle.txt` in your local game folder.

---

## 🛠️ Development (Building from Source)

If you are a developer and want to modify the server binaries, install scripts, or Dockerfile logic, you can build the images locally.

```bash
# Build and run CS 1.6
docker compose -f docker-compose.cstrike.yml up -d --build

# Build and run Half-Life
docker compose -f docker-compose.halflife.yml up -d --build

# Build and run Sven Co-op
docker compose -f docker-compose.svencoop.yml up -d --build
```

## Stack Details

### CS 1.6 & Half-Life
- **Engine**: ReHLDS (Reverse-engineered HLDS)
- **Metamod**: Metamod-R
- **AMX Mod X**: 1.10
- **Modules**: ReGameDLL, ReAPI, ReUnion, ReDeathmatch (CS only)

### Sven Co-op
- **Engine**: SvenDS (Official)
- **Content**: Includes Opposing Force support
