df -h
mkdir -p ~/bin
mkdir -p ~/android/lineage
curl -s https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
PATH="$HOME/bin:$PATH"
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
cd ~/android/lineage
repo init -u https://github.com/LineageOS/android.git -b lineage-18.1
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune 
df -h
source build/envsetup.sh; breakfast whyred
