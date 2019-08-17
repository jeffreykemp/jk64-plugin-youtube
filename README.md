# Youtube Embed ![APEX Plugin](https://cdn.rawgit.com/Dani3lSun/apex-github-badges/b7e95341/badges/apex-plugin-badge.svg) ![APEX 18.2](https://cdn.rawgit.com/Dani3lSun/apex-github-badges/2fee47b7/badges/apex-18_2-badge.svg)

**An Item plugin for Oracle Application Express**

This allows you to turn any item into a Youtube player. The item value simply needs to be set to the Youtube Video ID.

![preview.png](https://github.com/jeffreykemp/jk64-plugin-youtube/raw/master/src/preview.png)

## DEMO ##

https://apex.oracle.com/pls/apex/f?p=YOUTUBE_DEMO&c=JK64

## PRE-REQUISITES ##

* [Oracle Application Express 18.2](https://apex.oracle.com)

## INSTALLATION INSTRUCTIONS ##

1. Download the [latest release](https://github.com/jeffreykemp/jk64-plugin-youtube/releases/latest)
2. Install the plugin to your application - **region_type_plugin_com_jk64_simple_google_map**
3. Add an item to the page, select type **Youtube Player [Plug-In]**
4. Set the **Item Source** to the Youtube Video ID, e.g. `fwkJtgVswgM` - e.g. this could be a static value or a database column
5. Set the item **Width** and **Height** (in pixels) for the video player; for best results use a 4:3 or 16:9 ratio. Note: values less than 200 will be ignored.

For more info, refer to the [WIKI](https://github.com/jeffreykemp/jk64-plugin-youtube/wiki).
