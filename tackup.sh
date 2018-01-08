#!/bin/bash
#
# BACKUP-SCRIPT
# by: woositng
#
# This backup script simply tars dirs as a backup.
#
# FOR MORE INFORMATION PLEASE VISIT: http://www.woosting.nl

# FUNCTION DECLARATIONS:
	function fatal_error {
		echo " "
		echo -e "\033[31mFATAL ERROR:\e[0m - $1"
		date
		echo "Exiting to bash."
		echo " "
		exit 1
	}
	function target_presence_check {
		if [ -e $TARGET ]; then
			usersourcetarget_feedback
		 else
			fatal_error "Unable to find target location (medium mounted?)!"
		fi
	}
	function usersourcetarget_feedback {
		echo " "
		echo "User is: \"$USER\""
		echo "------------------"
		echo "Source: $SOURCE"
		echo "Target: $TARGET"
		echo "------------------"
	}
	function check_root {
		if [[ $EUID -ne 0 ]]; then
			fatal_error "This script must be run as root!";
		fi
	}

	
# STATIC CONFIGURATION
	DATE_CURRENT=`date '+%F'`
	SOURCE="/etc /home/woosting"		# ABSOLUTE path to ORIGINAL directory (must exist)
	TARGET="/home/temp"			# ABSOLUTE path to DESTINATION directory (must exist)

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# 				FUNCTIONS & CONFIGURATION
# 				      PROGRAM LOGIC
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

	target_presence_check			# MEDIA PRESENCE CHECK
	check_root

# ACTUAL SYNC
# Announcing the start
	echo " "
	echo "Tackup STARTING"
	date
	echo " "

# Snapshot rolling
	# Removing last oldest backup
			
		echo "old backups are NOT being removed..."
#		echo "old backups are being removed..."
#		rm -rf $TARGET/backup.${RETENTION}

# Actual command
	echo " "
	tar -cpzvf ${TARGET}/${DATE_CURRENT}_Backup_Rpi.tar.gz ${SOURCE}

# Echoing the date for referance purposes
	date
	echo " "
