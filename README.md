# paperless
A [paperless-ngx](https://github.com/paperless-ngx/paperless-ngx) stack. This document only pertains to what is contained in this repository.

Full deployment information is available for authorized users [on the wiki](https://wiki.joris.me/books/paperless).

## Architecture

This stack is consisting of the following components:
- A database, currently sqlite;
- A redis instance;
- A Paperless instance.

## Storage
Fundamental to Paperless is the storage of PDF files and associated data such as thumbnail images. It also provides functionality for consuming new files automatically and importing/exporting backups.

The [docker-compose.yml](docker-compose.yml) is configured to access the following **bind mounts** (local directories on the node):
- `/opt/paperless/export` for importing/exporting (for the sake of backup up);
- `/opt/paperless/consume` for consuming new files (e.g. from a scanner).

Make sure these above folders exist (with permissions `uid:guid` of `1000:1000`) before attempting to deploy.

Then, the following volume mounts are used to store data at runtime:
- `data`
- `media`

Assuming regular backups, there is no need to have backups for these.

## Networking

The only exposed port is `tcp/8010`, bound to `127.0.0.1`, meaning it can **only be accessed from local connections.** This is done on purpose as a safety measure.

The use of a reverse proxy is thus necessary in this configuration.

## Environment variables

The required environment variables for this deployment, with descriptions from the [paperless-ngx docs](https://docs.paperless-ngx.com/configuration/):
- `PAPERLESS_URL`: The routable URL for the app, e.g. `https://paperless.example.com`.
- `PAPERLESS_OCR_LANGUAGE`: The default language to use for OCR. Set this to the language most of your documents are written in.
- `PAPERLESS_TIME_ZONE`: Your time zone, e.g. `Europe/Amsterdam`. See the [List of timezones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).
- `PAPERLESS_SECRET_KEY`: Paperless uses this to make session tokens. If you expose paperless on the internet, you need to change this, since the default secret is well known. It should be a very long sequence of random characters. You don't need to remember it.
