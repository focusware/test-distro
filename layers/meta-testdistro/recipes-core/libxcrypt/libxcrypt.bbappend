python () {
    gccver = d.getVar('GCCVERSION')
    if gccver and len(gccver) > 0 and int(gccver[0]) < 8:
        cppflags = d.getVar('TARGET_CPPFLAGS', False).split()
        d.setVar('TARGET_CPPFLAGS', ' '.join([f for f in cppflags if 'missing-attributes' not in f]))
}