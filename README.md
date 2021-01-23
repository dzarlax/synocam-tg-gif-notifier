# Synology Survivalence Station to Telegram notificator with gifs
A dockerized python script to create animated gifs from videos recorded by cameras attached to Synology Surveillance Station and send them via telegram bot API

To run you should mount :
* /config (for config file)
* /data (for database)
* /gifs (for working directory)

In environment :
* config_file (route to config file i.e. /config/config.json)

Config file:

```
{
  "data_folder": "data",
  "ffmpeg_working_folder": "gifs",
  "synology_base_api_url": "xxx",
  "synology_user": "xxx",
  "synology_password": "xxx",
  "synology_cameras": [{
    "id": 1,
    "name": "xxx",
    "skip_first_n_secs": 0,
    "max_length_secs": 10,
    "scale": 1280
  }],
  "telegram_bot_token": "xxx",
  "chat_id": "xxx",
  "message": "Motion was detected in",
  "silence": "True"
}
```

* `data_folder`: Path where to stored sqlite db for already processed events (preserve state across restarts). Leave empty if using docker image.
* `ffmpeg_working_folder`: Working folder for downloaded mp4 videos and created GIFs
* `synology_base_api_url`: Base url of Synology Surveillance Station APIs
* `synology_user`: User to access Synology Surveillance Station APIs
* `synology_password`: User's password to access Synology Surveillance Station APIs
* `synology_cameras`: Array of cameras for events polling
    * `id`: Synology Surveillance Station camera id
    * `skip_first_n_secs`: Skip seconds recorded before motion event is triggered
    * `max_length_secs`: Do not create gif for video full length but only with first n seconds
    * `scale`: Determine quality and size of the output gif
* `telegram_bot_token`: Your telegram bot token from @botfather
* `chat_id`: The id of chat where you want to post messages
* `message`: Text for telegram message
* `silence`: True or False for enabling/disabling notifications

If you don't know camera ids, leave cameras section empty and you'll get ids printed at first run
```
"synology_cameras": []
```
Example:
```
[INFO] (MainThread) Synology Info Camera Id 1 Name arzilla_veranda IP 192.168.1.87
[INFO] (MainThread) Synology Info Camera Id 2 Name arzilla_piazzale IP 192.168.1.88
[INFO] (MainThread) Synology Info Camera Id 3 Name arzilla_campo IP 192.168.1.148
[INFO] (MainThread) Synology Info Camera Id 4 Name arzilla_veranda_interno IP 192.168.1.126
```


Based on https://github.com/fabtesta/synology-surveillance-api-motion-telegram-gifs

If no events got from camera, that in reality has, camera should be configured to record motion events.