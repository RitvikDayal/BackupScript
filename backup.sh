# Change the following variables to match your system

# ask user for username
read -p "Enter your username: " username
USERNAME=$username
# as user for absolute path for backup folder
read -p "Enter absolute path for backup folder: " backup_folder
BACKUP_LOCATION=$backup_folder

HOMEDIR=/home/$USERNAME
DESKTOPDIR=$HOMEDIR/Desktop
PROJECTDIR=$HOMEDIR/Projects


# create zip file for desktop directory with date excluding any sub-directory named as venv, git, __pycache__, node_modules
zip -r $BACKUP_LOCATION/Desktop_$(date +%Y-%m-%d).zip $DESKTOPDIR -x \*.pyc \*.git\* \*venv\* \*node_modules\* \*cache\* \*.DS_Store
# create zip file for projects directory with date
zip -r $BACKUP_LOCATION/Projects_$(date +%d-%m-%Y).zip $PROJECTDIR -x \*.pyc \*.git\* \*venv\* \*node_modules\* \*cache\* \*.DS_Store\* \*pyvenv\* \*pypyenv\* \*ipynb_checkpoints\*

# delete zip files older than 7 days
find $BACKUP_LOCATION -name "*.zip" -mtime +7 -delete

# delete any zip at Desktop and Projects directory older than 7 days
find $DESKTOPDIR -name "*.zip" -mtime +7 -delete
find $PROJECTDIR -name "*.zip" -mtime +7 -delete

# check if any error occured during zip creation
if [ $? -eq 0 ]; then
    notify-send "Backup Complete - $(date +%d-%m-%Y) for Desktop and Projects"
else
    notify-send "Backup Failed - $(date +%d-%m-%Y) for Desktop and Projects"
fi
