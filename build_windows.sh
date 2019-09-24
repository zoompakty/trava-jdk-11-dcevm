export PATH=/cygdrive/c/tools/cygwin/bin:$PATH

wget -q -O OpenJDK10_x64_Windows.zip "https://api.adoptopenjdk.net/v2/binary/releases/openjdk10?os=windows&release=jdk-10.0.2%2B13.1&arch=x64"
JDK_BOOT_DIR=$PWD/$(unzip -Z1 OpenJDK10U-jdk_x64_windows_hotspot_10.0.2_13.zip | grep 'bin/javac'  | tr '/' '\n' | tail -3 | head -1)
unzip -q OpenJDK10U-jdk_x64_windows_hotspot_10.0.2_13.zip

# unset cygwin's gcc preconfigured
unset -v CC
unset -v CXX

cd ./openjdk-build
export LOG=info
./makejdk-any-platform.sh --tag "${SOURCE_JDK_TAG}" --build-variant dcevm  --branch dcevm11 --jdk-boot-dir ${JDK_BOOT_DIR} --hswap-agent-download-url ${HSWAP_AGENT_DOWNLOAD_URL} --disable-test-image --configure-args '-disable-warnings-as-errors --disable-hotspot-gtest' --target-file-name java11-openjdk-dcevm-${TRAVIS_OS_NAME}.zip jdk11u
