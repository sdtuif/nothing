# add repo,dt, vt, kt etc
repo init --depth=1 --no-repo-verify -u https://github.com/qwry3657/android_manifest_nusa.git -b 10 -g default,-mips,-darwin,-notdefault
git clone https://github.com/Sa-Sajjad/manifest.git --depth 1 -b 1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

#  rom
# don't touch those command
source build/envsetup.sh
lunch nad_lavender-userdebug
export TZ=Asia/Dhaka
make api-stubs-docs || echo no problem
make system-api-stubs-docs || echo no problem
make test-api-stubs-docs || echo no problem
mka nad
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
