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
# TARGETS #
###########

# Declare an array called "targets", each containing an rclone target.
RCLONE_TARGETS=("hetzner_paperless_crypt" "backblaze_paperless_crypt")
RCLONE_CONFIG=/home/joris/.config/rclone/rclone.conf

###########
# EXECUTE #
###########

echo "Exporting"
docker exec -it paperless document_exporter -c ../export

# Loop over our targets.
for RCLONE_TARGET in ${RCLONE_TARGETS[@]}; do
  echo "Syncing to: $RCLONE_TARGET"
  rclone sync \
        --config $RCLONE_CONFIG \
        $EXPORT_DIR $RCLONE_TARGET:/
done

echo "Done"
