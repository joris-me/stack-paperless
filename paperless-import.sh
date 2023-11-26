#!/bin/bash

#############
# CONSTANTS #
#############

# Specifies where the cloud volumes are to be mounted. Freely configurable.
MOUNT_DIR=/opt/paperless/export

# Where Paperless exports to.
# This variable cannot be changed easily, as currently it's a bind mount for the Paperless container.
EXPORT_DIR=/opt/paperless/export

###########
# EXECUTE #
###########

echo "Importing"
docker exec -it paperless document_importer ../export

echo "Done"
