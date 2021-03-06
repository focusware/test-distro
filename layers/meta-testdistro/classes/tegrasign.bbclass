TEGRA_SIGNING_EXCLUDE_TOOLS_jetson-tx2-cboot = "1"
TEGRA_SIGNING_EXTRA_DEPS_jetson-tx2-cboot = "${DIGSIG_DEPS}"

inherit signing_server l4t_bsp


tegrasign_create_manifest() {
    cat >MANIFEST <<EOF
DTBFILE=${DTBFILE}
ODMDATA=${ODMDATA}
LNXFILE=${LNXFILE}
BOARDID=${TEGRA_BOARDID}
FAB=${TEGRA_FAB}
fuselevel=fuselevel_production
localbootfile=${LNXFILE}
CHIPREV=${TEGRA_CHIPREV}
BOARDSKU=${TEGRA_BOARDSKU}
BOARDREV=${TEGRA_BOARDREV}
EOF
}

tegraflash_custom_sign_pkg_jetson-tx2-cboot() {
    tegrasign_create_manifest
    tar -c -h -z -f ${WORKDIR}/tegrasign-in.tar.gz --exclude=${IMAGE_BASENAME}.img *
    digsig_post sign/tegra -F "machine=${MACHINE}" -F "soctype=${SOC_FAMILY}" -F "bspversion=${L4T_VERSION}" -F "artifact=@${WORKDIR}/tegrasign-in.tar.gz" --output ${WORKDIR}/tegrasign-out.tar.gz
    tar -x -z -f ${WORKDIR}/tegrasign-out.tar.gz
    [ "${TEGRA_SIGNING_EXCLUDE_TOOLS}" != "1" ] || cp -R ${STAGING_BINDIR_NATIVE}/${FLASHTOOLS_DIR}/* .
    rm doflash.sh
    mv flashcmd.txt doflash.sh
    chmod +x doflash.sh
}

tegraflash_custom_sign_bup_jetson-tx2-cboot() {
    tegrasign_create_manifest
    echo "BUPGENSPECS=${TEGRA_BUPGEN_SPECS}" >>MANIFEST
    tar -c -h -z -f ${WORKDIR}/tegrasign-bupgen-in.tar.gz *
    digsig_post sign/tegra -F "machine=${MACHINE}" -F "soctype=${SOC_FAMILY}" -F "bspversion=${L4T_VERSION}" -F "artifact=@${WORKDIR}/tegrasign-bupgen-in.tar.gz" --output ${WORKDIR}/tegrasign-bupgen-out.tar.gz
    tar -x -z -f ${WORKDIR}/tegrasign-bupgen-out.tar.gz
}
