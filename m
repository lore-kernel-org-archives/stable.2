Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795864553;
	b=omz3mzklDAdigc4lDxKaQpzMqgQpkJFg9mFUU6v0lnLQP6zTpRrOjggV9Nvhh/rNExcW
	 C9PnbghYBnEOZyfO54OQiRfDMfwKTmDYZc096Y5+qFa52AjOIfRjsJ3TKgBNXBmnWwj/M
	 WAH0MFYyVQpS5+7AtpIN9YDVNScRYSdnJ7XcUbL7GAJB0uliSP256JZqKHIT8C6B9EvEm
	 vzIP/FQZyIgcBCKZyTqomlzcfP7ZN4l8iwz8po+36w5W4LtfSiRwYzFnqJAelGjqdYngJ
	 Lb250pHL3KFbyUuLah6LaZtSTL7n1XdMU6ku4TSMmKhuy7kArXZ9dR/a6usvFy73W2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795864553;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=CZXKyPNZLofeHAUKVGkTZOCtIjmrif9AACWfR2u5LZ0=;
	b=kExSoB6+FI1tPMbI8tiiyEwkI75hMkgNLyl8ZS47sRbqAP5LlsAGgBSf1Ow4iSEdESij
	 RQz77/CooQfoRHTe2frmuXjQcdFQ6mBZzQphYK1M76BztaN5wmG9YGPqUCLnY+eW7ouBm
	 L3VXfNzgRr7lF2sLL/2UhqRoZmIbEVpJXu0KGt12hKNbbKhblOGllvGb5zksL9EIO5dvR
	 Ov1Fd/qZqdN+PyvdDC5VD3+EmNQhBJVuYhSXn6MV7E/PfUj/bFswOuk/slCpI8oZC5VA8
	 urAvZ1R1jBcd71HteQKQpXOYl8TfYLdeRVaxqEpBwgeGfl6b231BTPkDSu73yUT9tZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=LNWMFDI4;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4B0606A31C;
	Sat, 28 Nov 2026 11:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B4B0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=LNWMFDI4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=CZ
	XKyPNZLofeHAUKVGkTZOCtIjmrif9AACWfR2u5LZ0=; b=LNWMFDI4rBRR6rUJ+v
	oH/ggRET7xcz+6pAYyV4LOWPU7T7QS7SskWRHmfY0wCNHRZhusaiRrnU+NaLXbId
	aTJIeBVkHZukuogzB370XNupu5cDKIMMUh4FlPNYdlWceZcfjZz8uL+EtAuhzqed
	drzBCKhHHnbd8WqaI+UToVUZE=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDnxCHUtwpr6DKkKw--.43952S2;
	Sat, 28 Nov 2026 19:15:32 +0800 (CST)
From: shaos <shawnq1@163.com>
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fuse: clear the old EOF tail on getattr size growth
Date: Sat, 28 Nov 2026 11:15:32 +0000
Message-Id: <20261128111532.3209985-1-shawnq1@163.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnxCHUtwpr6DKkKw--.43952S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Cw4ftw4xKw4xtFyDXrW7XFb_yoWDKr17pF
	W5Kay5tw1IqayxWrn2kF4UZw1ag3Z7Jw4UWryFqa1xuF1UJw1IyFyrCrWjkF15Xr4kGa9I
	qr4Dtw43Wr4DZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMc_fUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8hWAjmsKt9WavgAA3O

Hello,

When a FUSE_GETATTR reply grows a cached regular file, the attribute
update writes the larger i_size and then calls truncate_pagecache() at
the new size.  That does not clear bytes dirtied beyond the old EOF in
the partial page.  With FUSE_EXPLICIT_INVAL_DATA, the subsequent whole-
mapping invalidation is skipped, so those stale bytes become visible
through reads after the size change.

The attached PoC dirties 512 bytes beyond a 100-byte EOF in a
MAP_SHARED mapping.  A FUSE server then reports a size of 8192 in a
GETATTR reply.  Two fresh runs return 512 stale 'A' bytes from the
page cache; writeback also carries those bytes to the server.  The
patched control returns zeroes and writes back no stale 'A' bytes.

Related fixes already in this tree clear the old EOF tail for buffered
writes, setattr/truncate, and fallocate (34b5c4a6e4fb), writeback-cache
writes (d9013d15b937), and copy_file_range() (9b82a8aed794).  This report
covers the separate attribute-refresh path: a larger size returned by
FUSE_GETATTR is applied in fuse_change_attributes_i(), which still leaves
the old EOF tail in the page cache when explicit data invalidation is
enabled.

The trigger requires a cached, non-writeback FUSE file with
FUSE_EXPLICIT_INVAL_DATA and FOPEN_KEEP_CACHE.  It demonstrates stale
file contents and writeback within that FUSE filesystem.  No
cross-user data disclosure or privilege escalation is demonstrated.

HEAD commit:    8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
git tree:       fe970b05333fb8e41da21e9e289f652abcc7cba7
source version: v7.3-23088-g8d7fe9885c62f (Linux 7.4.0-rc4)
compiler:       gcc 11.4.0, GNU ld 2.38

The new range is cleared before i_size is published, following the
same rule used by the other FUSE size-extension paths.  The helper
takes the inode lock for an extension and rechecks the attribute
version and current size after acquiring it.

Console output:
https://gist.githubusercontent.com/shaos26/8adaad63a51780dac454db282187a389/raw/c0ad0595ad57975a6fe2b87e684e6b982037e584/console-output.txt
Kernel config:
https://gist.githubusercontent.com/shaos26/8adaad63a51780dac454db282187a389/raw/c0ad0595ad57975a6fe2b87e684e6b982037e584/kernel-config.txt
PoC:
https://gist.githubusercontent.com/shaos26/8adaad63a51780dac454db282187a389/raw/c0ad0595ad57975a6fe2b87e684e6b982037e584/poc.c
Init script:
https://gist.githubusercontent.com/shaos26/8adaad63a51780dac454db282187a389/raw/c0ad0595ad57975a6fe2b87e684e6b982037e584/init
Fixed-kernel init script:
https://gist.githubusercontent.com/shaos26/8adaad63a51780dac454db282187a389/raw/c0ad0595ad57975a6fe2b87e684e6b982037e584/init-fixed

Build the kernel from the revision above using kernel-config.txt:

    work=$(mktemp -d /tmp/fuse-getattr.XXXXXX)
    cd "$work"
    gist_id=8adaad63a51780dac454db282187a389
    gist_revision=c0ad0595ad57975a6fe2b87e684e6b982037e584
    gist_base=https://gist.githubusercontent.com/shaos26
    gist=$gist_base/$gist_id/raw/$gist_revision
    for file in console-output.txt kernel-config.txt poc.c init \
        init-fixed; do
        curl -fL "$gist/$file" -o "$file"
    done
    git clone \
        https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
    cd linux
    git checkout 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
    mkdir build
    cp ../kernel-config.txt build/.config
    make O=build olddefconfig
    make O=build -j"$(nproc)" bzImage
    cd ..

Build the PoC and initramfs:

    gcc -static -O2 -Wall -Wextra -o poc poc.c
    mkdir -p root/bin root/dev root/proc root/sys root/mnt
    cp /usr/bin/busybox root/bin/busybox
    cp poc root/poc
    cp init root/init
    (cd root && find . -print0 | cpio --null -o -H newc) | \
        gzip -9 > initramfs.cpio.gz

Run the unpatched kernel and then repeat with the proposed patch and
init-fixed:

    timeout 60 qemu-system-x86_64 -m 2048 -smp 2 -machine q35 \
        -no-acpi -kernel linux/build/arch/x86/boot/bzImage \
        -initrd initramfs.cpio.gz \
        -append 'console=ttyS0 rdinit=/init panic=-1 acpi=off pci=noacpi' \
        -nographic -no-reboot -monitor none

The init script runs the positive case, a no-growth control, and a
control without FUSE_EXPLICIT_INVAL_DATA.  On the patched kernel, use
init-fixed; rebuild the initramfs after replacing root/init:

    cp init-fixed root/init
    (cd root && find . -print0 | cpio --null -o -H newc) | \
        gzip -9 > initramfs-fixed.cpio.gz

Boot that archive with the same QEMU command, replacing
initramfs.cpio.gz with initramfs-fixed.cpio.gz.  The full console
output records both unpatched runs and the patched control.

Fixes: ad2ba64dd489 ("fuse: allow filesystems to have precise control over data cache")
Cc: stable@vger.kernel.org
Signed-off-by: shaos <shawnq1@163.com>

Thanks,

shaos

---
 fs/fuse/dir.c    | 21 +++++++++++++-------
 fs/fuse/fuse_i.h |  3 +++
 fs/fuse/inode.c  | 45 ++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index a04d93d5fc447..0ec3a600de107 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1496,7 +1496,8 @@ static int fuse_do_statx(const struct mnt_idmap *idmap, struct inode *inode,
 }
 
 static int fuse_do_getattr(const struct mnt_idmap *idmap, struct inode *inode,
-			   struct kstat *stat, struct file *file)
+			   struct kstat *stat, struct file *file,
+			   bool inode_locked)
 {
 	int err;
 	struct fuse_getattr_in inarg;
@@ -1531,9 +1532,15 @@ static int fuse_do_getattr(const struct mnt_idmap *idmap, struct inode *inode,
 			fuse_make_bad(inode);
 			err = -EIO;
 		} else {
-			fuse_change_attributes(inode, &outarg.attr, NULL,
-					       ATTR_TIMEOUT(&outarg),
-					       attr_version);
+			if (inode_locked)
+				fuse_change_attributes_locked(inode,
+							      &outarg.attr, NULL,
+							      ATTR_TIMEOUT(&outarg),
+							      attr_version);
+			else
+				fuse_change_attributes(inode, &outarg.attr, NULL,
+						       ATTR_TIMEOUT(&outarg),
+						       attr_version);
 			if (stat)
 				fuse_fillattr(idmap, inode, &outarg.attr, stat);
 		}
@@ -1581,7 +1588,7 @@ static int fuse_update_get_attr(const struct mnt_idmap *idmap, struct inode *ino
 				goto retry;
 			}
 		} else {
-			err = fuse_do_getattr(idmap, inode, stat, file);
+			err = fuse_do_getattr(idmap, inode, stat, file, false);
 		}
 	} else if (stat) {
 		generic_fillattr(idmap, request_mask, inode, stat);
@@ -1751,7 +1758,7 @@ static int fuse_perm_getattr(struct inode *inode, int mask)
 		return -ECHILD;
 
 	forget_all_cached_acls(inode);
-	return fuse_do_getattr(&nop_mnt_idmap, inode, NULL, NULL);
+	return fuse_do_getattr(&nop_mnt_idmap, inode, NULL, NULL, false);
 }
 
 /*
@@ -2360,7 +2367,7 @@ static int fuse_setattr(const struct mnt_idmap *idmap, struct dentry *entry,
 			 * ia_mode calculation may have used stale i_mode.
 			 * Refresh and recalculate.
 			 */
-			ret = fuse_do_getattr(idmap, inode, NULL, file);
+			ret = fuse_do_getattr(idmap, inode, NULL, file, true);
 			if (ret)
 				return ret;
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e0992fcbcc554..38a8fadfa3644 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1049,6 +1049,9 @@ void fuse_init_symlink(struct inode *inode);
 void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 			    struct fuse_statx *sx,
 			    u64 attr_valid, u64 attr_version);
+void fuse_change_attributes_locked(struct inode *inode, struct fuse_attr *attr,
+				   struct fuse_statx *sx,
+				   u64 attr_valid, u64 attr_version);
 
 void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 				   struct fuse_statx *sx,
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index af6d9e0af190b..302d74c199dcd 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -313,14 +313,17 @@ u32 fuse_get_cache_mask(struct inode *inode)
 
 static void fuse_change_attributes_i(struct inode *inode, struct fuse_attr *attr,
 				     struct fuse_statx *sx, u64 attr_valid,
-				     u64 attr_version, u64 evict_ctr)
+				     u64 attr_version, u64 evict_ctr,
+				     bool inode_locked)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	u32 cache_mask;
 	loff_t oldsize;
 	struct timespec64 old_mtime;
+	bool inode_lock_acquired = false;
 
+retry:
 	spin_lock(&fi->lock);
 	/*
 	 * In case of writeback_cache enabled, writes update mtime, ctime and
@@ -343,14 +346,34 @@ static void fuse_change_attributes_i(struct inode *inode, struct fuse_attr *attr
 	if ((attr_version != 0 && fi->attr_version > attr_version) ||
 	    test_bit(FUSE_I_SIZE_UNSTABLE, &fi->state)) {
 		spin_unlock(&fi->lock);
-		return;
+		goto out;
+	}
+
+	oldsize = inode->i_size;
+	if (!cache_mask && S_ISREG(inode->i_mode) && attr->size > oldsize) {
+		if (!inode_locked) {
+			spin_unlock(&fi->lock);
+			inode_lock(inode);
+			inode_locked = true;
+			inode_lock_acquired = true;
+			goto retry;
+		}
+
+		spin_unlock(&fi->lock);
+		truncate_pagecache_range(inode, oldsize, attr->size - 1);
+		spin_lock(&fi->lock);
+		if ((attr_version != 0 && fi->attr_version > attr_version) ||
+		    test_bit(FUSE_I_SIZE_UNSTABLE, &fi->state) ||
+		    inode->i_size != oldsize) {
+			spin_unlock(&fi->lock);
+			goto out;
+		}
 	}
 
 	old_mtime = inode_get_mtime(inode);
 	fuse_change_attributes_common(inode, attr, sx, attr_valid, cache_mask,
 				      evict_ctr);
 
-	oldsize = inode->i_size;
 	/*
 	 * In case of writeback_cache enabled, the cached writes beyond EOF
 	 * extend local i_size without keeping userspace server in sync. So,
@@ -387,13 +410,25 @@ static void fuse_change_attributes_i(struct inode *inode, struct fuse_attr *attr
 
 	if (fuse_conn_vdax(fc))
 		fuse_vdax_dontcache(inode, attr->flags);
+out:
+	if (inode_lock_acquired)
+		inode_unlock(inode);
 }
 
 void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 			    struct fuse_statx *sx, u64 attr_valid,
 			    u64 attr_version)
 {
-	fuse_change_attributes_i(inode, attr, sx, attr_valid, attr_version, 0);
+	fuse_change_attributes_i(inode, attr, sx, attr_valid, attr_version, 0,
+				 false);
+}
+
+void fuse_change_attributes_locked(struct inode *inode, struct fuse_attr *attr,
+				   struct fuse_statx *sx, u64 attr_valid,
+				   u64 attr_version)
+{
+	fuse_change_attributes_i(inode, attr, sx, attr_valid, attr_version, 0,
+				 true);
 }
 
 static void fuse_init_submount_lookup(struct fuse_submount_lookup *sl,
@@ -535,7 +570,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	spin_unlock(&fi->lock);
 done:
 	fuse_change_attributes_i(inode, attr, NULL, attr_valid, attr_version,
-				 evict_ctr);
+				 evict_ctr, is_new_inode);
 	if (is_new_inode)
 		unlock_new_inode(inode);
 	return inode;
-- 
2.34.1

