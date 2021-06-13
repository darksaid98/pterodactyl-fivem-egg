## Information

> Why create this, what is it for?

This is simply a fork/edit of [parkervcp](https://github.com/parkervcp)'s FiveM egg found [here](https://github.com/parkervcp/eggs/tree/master/gta/fivem), which I use for my FiveM servers.

> Why should I use this over other FiveM eggs?

This fork includes an easy way of updating server artifacts, automatic pulls from private git repositories on server startup into the `resources` folder, and lots of pre-defined convars that can be changed on your servers `Startup` page.

> I have a question/could you help me set this up?

Will I help you set this up? No. However if you have any questions I'm usually available on discord `darksaid98#6092` and would be happy to answer any question you may have.

## Updating Server Artifact

If you want to update your servers artifact I've provided an easy way for doing so. This will completely delete the `alpine` folder and replace it with the specified or latest version.

1. On your servers `Startup` page, set `FiveM Version` to the version you want to update to. Optionally, leave this blank or set it to `latest` to download the latest optional build.
2. On your servers `Settings` page, click `Reinstall Server` and confirm. Then simply wait for it to download the new artifact.

## Updating resources from Git

This will simply run a git pull inside the `resources` folder on server startup. Basically this allows my servers to update on server restarts, providing a robust automatic patching system.

This needs to be done on initial installation of the server, since it will do a git clone instead of cloning the default FiveM `resources`. After that, every time your server is started it will pull the latest updates from your git repo.

## txAdmin

txAdmin is now supported and disabled by default. You set `TXADMIN_ENABLED` to `1` to enable it.

The last update to the egg changes the server to use txadmin to run. On first startup it will print a key to use to sign into the txadmin panel.

### Your server will not go online until it's started from txadmin.

## Notice

The `FIVEM_VERSION` variable.

* Defaults to `latest` which is the latest optional artifact.
* Can be set to a specific version Ex. `2431-350dd7bd5c0176216c38625ad5b1108ead44674d`.
* If the `Reinstall Server` button is pressed the `alpine` folder will be replaced with an updated version.

The `GIT_ENABLED` variable.

* If `Automatic Update` is enabled and all other git variables are set, this will make the server pull the specified repo in the `resources` folder.
* If all git settings are set and `Automatic Update` is enabled, the git repo will be cloned into the `resources` folder on the first server install.

## Server Ports

Ports required to run the server in a table format. You only need the txAdmin port if you plan to enable txAdmin.


| Port    | default |
| --------- | --------- |
| Game    | 30110   |
| Game+1  | 30120   |
| txAdmin | 40120   |

## Credits

* **[Parkervcp](https://github.com/parkervcp)** - *Original [egg](https://github.com/parkervcp/eggs/tree/master/gta/fivem).*
* **[Pterodactyl](https://pterodactyl.io/)** - *Creators and maintainers of the Pterodactyl panel.*
* **[Cfx.re](https://fivem.net/)** - *Creators and maintainers of  FiveM & more <3.*
