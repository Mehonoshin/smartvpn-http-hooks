[![Build Status](https://travis-ci.org/Mehonoshin/smartvpn-http-hooks.svg?branch=master)](https://travis-ci.org/Mehonoshin/smartvpn-http-hooks)

# smartvpn-http-hooks

<a href="https://imgbb.com/"><img src="https://image.ibb.co/gEVXM9/Screen-Shot-2018-10-14-at-18-34-17.png" alt="smartvpn-billing" border="0"></a>

This ruby gem is wrapper for OpenVPN server daemon.

The main purpose of this gem - is to interact with remote API, located at billing system.

This allows to authenticate user, track his connects/disconnects, apply hooks on connect/disconnect.

### Hooks

Built-in hooks allow to implement following features for specific user:

* Automatic routing of I2P sites through I2P router
* Automatic routing of TOR sites through TOR router
* Applying selected proxy for all HTTP traffic of specific user

### Disclaimer

This is OpenSource, Free software. You may use it anyway you want. It is provided AS IS.

Check out LICENSE file for more info.

