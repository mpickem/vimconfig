#! /bin/bash
# Bash Script to update all vim plugins automatically.

cd bundle

for i in $(ls -d  */ | cut -f1 -d'/'); do
  cd $i
  echo -n "${i} - "
  git pull
  cd ..
done

echo "Done."

exit 0
