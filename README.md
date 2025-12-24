# Counter-Strike 1.6 ReHLDS Server

A containerized CS 1.6 server built on the ReHLDS stack. This fork focuses on improved Docker deployment, stateless images, and simplified runtime customization.

## Quick Start

The fastest way to get a server running is with Docker Compose:

```bash
docker-compose up -d
```

Or using the Docker CLI:

```bash
docker run -d \
  -p 27015:27015/udp \
  -p 27015:27015 \
  ghcr.io/libreturks/gameserver-hl:cstrike \
  -game cstrike +map de_dust2 +maxplayers 16 +rcon_password "yourpassword"
```

## Runtime Customization

This image uses a sync-on-boot wrapper. Instead of rebuilding the image to add content, you can mount a volume to `/opt/steam/new-cstrike`. Files in this directory are merged into the live `cstrike` folder on startup.

### Example Volume Mounting

In your `docker-compose.yml`:

```yaml
volumes:
  - ./my-custom-content:/opt/steam/new-cstrike
```

**Structure of `./my-custom-content`:**
- `config/server.cfg` — Overrides the default server configuration.
- `maps/` — Add `.bsp` and `.res` files here.
- `addons/amxmodx/plugins/` — Add custom `.amxx` plugins.
- `addons/amxmodx/configs/plugins.ini` — Enable your custom plugins.

## Included Stack

- **Engine**: ReHLDS `3.13.0.788` (Optimized HLDS replacement)
- **Logic**: ReGameDLL `5.26.0.668`
- **API**: ReAPI `5.24.0.300`
- **Metamod**: Metamod-R `1.3.0.149`
- **AMX Mod X**: `1.10`
- **Protocol**: ReUnion `0.2.0.13` (Steam/Non-Steam support)
- **Mod**: ReDeathmatch `1.0.0-b11` (Pre-configured Deathmatch)

## Bundled Maps
Includes a selection of small-scale and classic maps:
`awp_india`, `fy_snow`, `de_dust2x2`, `fy_snow3`, `surf_nice_fly_3`, `awp_katkat`.
