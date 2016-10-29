

f := cross-binutils
$f_up := binutils

$f_CONFIGURE := $T/ports/$($f_up)/configure --prefix=$B/prefixes/$f
$f_CONFIGURE += --target=x86_64-managarm --with-sysroot=$B/system-root

$f_MAKE_ALL := make all-binutils all-gas all-ld
$f_MAKE_INSTALL := make install-binutils install-gas install-ld

$(call milestone_action,configure-$f install-$f)

configure-$f: $(call upstream_tag,regenerate-$($f_up))
	rm -rf $B/host/$f && mkdir -p $B/host/$f
	cd $B/host/$f && $($f_CONFIGURE)
	touch $(call milestone_tag,configure-$f)

install-$f: $(call milestone_tag,configure-$f)
	cd $B/host/$f && $($f_MAKE_ALL) && $($f_MAKE_INSTALL)
	touch $(call milestone_tag,install-$f)

