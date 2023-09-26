## Information

> Why create this, what is it for?

This is simply a fork/edit of [parkervcp](https://github.com/parkervcp)'s FiveM egg found [here](https://github.com/parkervcp/eggs/tree/master/game_eggs/gta/fivem), which I use for my FiveM servers.

> Why should I use this over other FiveM eggs?

This fork includes an easy way of updating server artifacts, automatic pulls from private git repositories on server startup into the `resources` folder, and lots of pre-defined convars that can be changed on your servers `Startup` page. I needed this for my servers and figured I'd share it.

> I have a question/could you help me set this up?

Will I help you set this up? No. However if you have any questions I'm usually available in my friends FiveM oriented [discord server](https://discord.gg/cG5uWvUcM6), and would be happy to answer any question you may have.

## Updating Server Artifact

If you want to update your servers artifact I've provided an easy way for doing so. This will completely delete the `alpine` folder and replace it with the specified or latest optional version.

1. On your servers `Startup` page, set `FiveM Version` to the version you want to update to. Optionally, leave this blank or set it to `latest` to download the latest optional build.
2. On your servers `Settings` page, click `Reinstall Server` and confirm. Then simply wait for it to download the new artifact.

## Auto Updating Server from Git

Listed below is the behavior of Git when it's enabled.

### Startup Scenarios (On server start)

* If the `resources` folder is empty. The specified repository will be cloned into `resources` on startup.
* If the `resources` folder has a git repository inside it. It will run a git pull in `resources` on startup.

### Reinstall Scenarios (If the `Reinstall Server` button is pressed)

* If the `resources` folder does not exist. The folder will be created and the specified repository will be cloned into `resources` on startup.

## txAdmin

txAdmin can be enabled by setting `TXADMIN_ENABLED` to `1`. Keep in mind you need to set `TXADMIN_PORT` as well.

### Your server will not go online until it's started from txadmin.

While txAdmin is a wonderful piece of software I don't understand the purpose of hosting a server on a panel only to use another panel for managing said server. If you want to use txAdmin I'd recommend staying on [Parkervcp](https://github.com/parkervcp)'s egg since most additional *features*  in this egg are redundant when running txAdmin.

## Notice

The `FIVEM_VERSION` variable.

* Defaults to `latest` which is the latest optional artifact.
* Can be set to a specific version Ex. `2431-350dd7bd5c0176216c38625ad5b1108ead44674d`.
* If the `Reinstall Server` button is pressed the `alpine` folder will be replaced with an updated version.

## Server Ports

Ports required to run the server in a table format. You only need the txAdmin port if you plan to enable txAdmin.

| Port | default |
| - | - |
| Game | 30120 |
| txAdmin | 40120 |

## Credits

* **[Parkervcp](https://github.com/parkervcp)** - *Original [egg](https://github.com/parkervcp/eggs/tree/master/game_eggs/gta/fivem).*
* **[Parkervcp](https://github.com/parkervcp)** - *[Git Clone & Pull Script](https://github.com/parkervcp/eggs/blob/master/scripts/git_cloner.sh).*
* **[Pterodactyl](https://pterodactyl.io/)** - *Creators and maintainers of the Pterodactyl panel.*
* **[Cfx.re](https://fivem.net/)** - *Creators and maintainers of  FiveM & more <3.*

