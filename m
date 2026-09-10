Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D29379C38;
	Thu, 10 Sep 2026 03:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010986; cv=none; b=JLjiTRRtmPgpxHLVEEJUN4E0l2pl5RlOUTh/tMLgKfKZPWhn/gjmfiqMwLjElWMYtFWTqBkVC3wSGZ/F8seR+xjleqNeVRsNGMLyrygz9RnlbuS3xpQchyUXjRx8GxQ7kNGX8E1uJjL55GLHaLGjEYi2SAL/YKMywknBhH4YKrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010986; c=relaxed/simple;
	bh=ScCEV0K79I0uYAYi/47qWLi3ty4lrYC6AjXDBN1T9+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nlk6kV4FOdwhAe7tdhLfba6yeF0nN/RLSJe4Z6lKBru6aL+gcGdA44O/rj/rkkmSxXImcMi284ISSoRzNIlbvSGYe1k+v4F5Pfd2b/AeSquF+6wlTXqCPZ3e3BIoN2MJaNkhtOb2etKi0/Zy8DQ0uGMsriRc9MPjBeQGBOD8R18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d7e4dcd6acc711f19a56ed5b684f684d-20260910
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:c41b5245-8ef6-41f3-b104-06a4c00e8874,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:85069a2351cb9665a535e8dfc75bca14,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50|99,ED
	M:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d7e4dcd6acc711f19a56ed5b684f684d-20260910
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1540472984; Thu, 10 Sep 2026 11:29:34 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	Baolin Liu <liubaolin@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v6 2/4] ntfs: set the volume dirty bit unconditionally on metadata changes
Date: Thu, 10 Sep 2026 11:29:17 +0800
Message-Id: <20260910032919.1742540-3-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260910032919.1742540-1-zenghongling@kylinos.cn>
References: <20260910032919.1742540-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The callers in file.c and namei.c skip ntfs_set_volume_flags() when
the in-memory vol_flags already show VOLUME_IS_DIRTY, but that check
runs without any lock: if it observes the bit set and ntfs_sync_fs()
clears it under the mrec_lock before the caller's metadata update
completes, the set is skipped and the volume can end up clean on disk
despite the modification, so chkdsk will not run on the next mount.

Drop the caller-side checks and call ntfs_set_volume_flags()
unconditionally: ntfs_write_volume_flags() already skips the write
under the mrec_lock when the combined value is unchanged.  That
unconditional call costs one mrec_lock acquisition per metadata
operation even in the already-dirty steady state; it cannot be
avoided, because deciding to skip the call without the lock is itself
what allows a concurrent ntfs_sync_fs() clear to lose the set.

The IOCB_NOWAIT path in ntfs_file_write_iter() must not sleep (it
takes the inode lock with inode_trylock() for exactly that reason),
so it uses ntfs_set_volume_flags_nowait(): the mrec_lock is acquired
with mutex_trylock(), the search context is allocated with GFP_ATOMIC,
and a $Volume inode carrying an attribute list, whose extent mapping
could block, is rejected; each of those failures returns -EAGAIN.
Any failure of the marking fails the NOWAIT request itself, so the
write can no longer proceed on a volume whose dirty bit could not be
set.

The nowait -EAGAIN failures are an expected "would have to sleep"
result rather than a filesystem error, so ntfs_write_volume_flags()
reports them without going through ntfs_error(): its
ntfs_handle_error() honors the errors= mount option and would
otherwise remount the volume read-only or panic the system for a
benign, retryable condition that unprivileged RWF_NOWAIT writes can
trigger at will, such as a GFP_ATOMIC allocation failure under
memory pressure.  This matches how retryable -EAGAIN is filtered
from error handling elsewhere in the driver.

The sleeping callers keep the pre-existing behavior of proceeding
when the marking fails, so the dirty bit remains best-effort there;
the NOWAIT write path is the exception in that it fails the request.

This closes the variant where the set is skipped outright.  A clear
for a concurrent, error-free sync can still land between the set and
the end of the metadata operation; that mark-at-start lifecycle is
pre-existing and is not changed by this patch.

Reported-by: Baolin Liu <liubaolin@kylinos.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/attrib.c | 30 ++++++++++++++----
 fs/ntfs/attrib.h |  2 ++
 fs/ntfs/file.c   | 29 +++++++++++++-----
 fs/ntfs/namei.c  | 24 +++++----------
 fs/ntfs/ntfs.h   |  1 +
 fs/ntfs/super.c  | 80 +++++++++++++++++++++++++++++++++++++++++++-----
 6 files changed, 128 insertions(+), 38 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index c7c09a751c6a..b51f8abeaacf 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -1678,20 +1678,24 @@ void ntfs_attr_reinit_search_ctx(struct ntfs_attr_search_ctx *ctx)
 }
 
 /*
- * ntfs_attr_get_search_ctx - allocate/initialize a new attribute search context
+ * ntfs_attr_get_search_ctx_gfp - allocate/initialize a new attribute search
+ * context using the given allocation flags
  * @ni:		ntfs inode with which to initialize the search context
  * @mrec:	mft record with which to initialize the search context
+ * @gfp:	allocation flags for the search context
  *
- * Allocate a new attribute search context, initialize it with @ni and @mrec,
- * and return it. Return NULL if allocation failed.
+ * Allocate a new attribute search context with kmem_cache_alloc(@gfp),
+ * initialize it with @ni and @mrec, and return it. Return NULL if allocation
+ * failed.  Callers that must not sleep, e.g. those servicing an IOCB_NOWAIT
+ * request, pass GFP_ATOMIC so the allocation cannot enter direct reclaim.
  */
-struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(struct ntfs_inode *ni,
-		struct mft_record *mrec)
+struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx_gfp(
+		struct ntfs_inode *ni, struct mft_record *mrec, gfp_t gfp)
 {
 	struct ntfs_attr_search_ctx *ctx;
 	bool init;
 
-	ctx = kmem_cache_alloc(ntfs_attr_ctx_cache, GFP_NOFS);
+	ctx = kmem_cache_alloc(ntfs_attr_ctx_cache, gfp);
 	if (ctx) {
 		init = ntfs_attr_init_search_ctx(ctx, ni, mrec);
 		if (init == false) {
@@ -1703,6 +1707,20 @@ struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(struct ntfs_inode *ni,
 	return ctx;
 }
 
+/*
+ * ntfs_attr_get_search_ctx - allocate/initialize a new attribute search context
+ * @ni:		ntfs inode with which to initialize the search context
+ * @mrec:	mft record with which to initialize the search context
+ *
+ * Allocate a new attribute search context, initialize it with @ni and @mrec,
+ * and return it. Return NULL if allocation failed.
+ */
+struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(
+		struct ntfs_inode *ni, struct mft_record *mrec)
+{
+	return ntfs_attr_get_search_ctx_gfp(ni, mrec, GFP_NOFS);
+}
+
 /*
  * ntfs_attr_put_search_ctx - release an attribute search context
  * @ctx:	attribute search context to free
diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
index 6b4fa9f57640..dd3c39668eff 100644
--- a/fs/ntfs/attrib.h
+++ b/fs/ntfs/attrib.h
@@ -88,6 +88,8 @@ static inline s64 ntfs_attr_size(const struct attr_record *a)
 void ntfs_attr_reinit_search_ctx(struct ntfs_attr_search_ctx *ctx);
 struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(struct ntfs_inode *ni,
 		struct mft_record *mrec);
+struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx_gfp(
+		struct ntfs_inode *ni, struct mft_record *mrec, gfp_t gfp);
 void ntfs_attr_put_search_ctx(struct ntfs_attr_search_ctx *ctx);
 int ntfs_attr_size_bounds_check(const struct ntfs_volume *vol,
 		const __le32 type, const s64 size);
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 007d1614b9ac..32a644ff21b6 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -325,8 +325,7 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		goto out;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	if (ia_valid & ATTR_SIZE) {
 		err = ntfs_setattr_size(vi, attr);
@@ -620,8 +619,24 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto out_lock;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
+	/*
+	 * The volume must be marked dirty before the modification is made,
+	 * without an unlocked check of the in-memory flag: ntfs_sync_fs()
+	 * can clear the bit concurrently and the modification would then
+	 * land on a volume that is clean on disk.  In the IOCB_NOWAIT case
+	 * the marking must not sleep, so it uses the nowait variant, and
+	 * any failure of the marking fails the request instead of letting
+	 * the write proceed on a volume that may be clean on disk.
+	 */
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		err = ntfs_set_volume_flags_nowait(vol, VOLUME_IS_DIRTY);
+		if (err) {
+			ret = err;
+			goto out_lock;
+		}
+	} else {
 		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	}
 
 	pos = iocb->ki_pos;
 	count = ret;
@@ -1153,11 +1168,9 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 			return err;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY)) {
-		err = ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
-		if (err)
-			return err;
-	}
+	err = ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	if (err)
+		return err;
 
 	old_size = i_size_read(vi);
 
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index fdf52fac4329..3e0adb9a0ea4 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -757,8 +757,7 @@ static int ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
 		return err;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	ni = __ntfs_create(idmap, dir, uname, uname_len, S_IFREG | mode, 0, NULL, 0);
 	kmem_cache_free(ntfs_name_cache, uname);
@@ -1032,8 +1031,7 @@ static int ntfs_unlink(struct inode *dir, struct dentry *dentry)
 		return err;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	err = ntfs_delete(ni, NTFS_I(dir), uname, uname_len, true);
 	if (err)
@@ -1076,8 +1074,7 @@ static struct dentry *ntfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		return ERR_PTR(err);
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	ni = __ntfs_create(idmap, dir, uname, uname_len, mode, 0, NULL, 0);
 	kmem_cache_free(ntfs_name_cache, uname);
@@ -1118,8 +1115,7 @@ static int ntfs_rmdir(struct inode *dir, struct dentry *dentry)
 		return err;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	err = ntfs_delete(ni, NTFS_I(dir), uname, uname_len, true);
 	if (err)
@@ -1305,8 +1301,7 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		new_dir_first = is_subdir(new_dentry->d_parent,
 					  old_dentry->d_parent);
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	mutex_lock_nested(&old_ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
 	if (new_ni)
@@ -1429,8 +1424,7 @@ static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		goto out;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	ni = __ntfs_create(idmap, dir, usrc, usrc_len, S_IFLNK | 0777, 0,
 			   symname, symlen);
@@ -1474,8 +1468,7 @@ static int ntfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		return err;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	switch (mode & S_IFMT) {
 	case S_IFCHR:
@@ -1521,8 +1514,7 @@ static int ntfs_link(struct dentry *old_dentry, struct inode *dir,
 		return -ENOMEM;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	ihold(vi);
 	mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
diff --git a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
index 45f77848a9cf..b76501a91143 100644
--- a/fs/ntfs/ntfs.h
+++ b/fs/ntfs/ntfs.h
@@ -219,6 +219,7 @@ struct option_t {
 };
 extern const struct option_t on_errors_arr[];
 int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags);
+int ntfs_set_volume_flags_nowait(struct ntfs_volume *vol, __le16 flags);
 int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags);
 int ntfs_write_volume_label(struct ntfs_volume *vol, char *label);
 
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 6ba19986a598..a3a3c7d1ba0c 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -357,6 +357,7 @@ void ntfs_handle_error(struct super_block *sb)
  * @vol:	ntfs volume on which to modify the flags
  * @set_bits:	bits to set in the volume information flags
  * @clear_bits:	bits to clear in the volume information flags
+ * @nowait:	do not wait for the $Volume mrec_lock
  *
  * Internal function.  You probably want to use ntfs_{set,clear}_volume_flags()
  * instead (see below).
@@ -368,19 +369,33 @@ void ntfs_handle_error(struct super_block *sb)
  * All bit manipulation is done on CPU-endian values, and the result is
  * converted back to little-endian before storing it.
  *
+ * When @nowait is set, the call must not sleep: the mrec_lock is acquired
+ * with mutex_trylock() and a contended lock fails with -EAGAIN, the search
+ * context is allocated with GFP_ATOMIC and exhausted memory fails with
+ * -EAGAIN, and a $Volume inode carrying an attribute list, whose extent
+ * mapping could block, is rejected with -EAGAIN as well.  The remaining
+ * transition work is non-blocking: the mft record of $Volume stays mapped
+ * for the lifetime of the mount, so the attribute lookup is an in-memory
+ * scan, and marking the record dirty does not submit I/O.
+ *
  * Return 0 on success and -errno on error.
  */
 static int ntfs_write_volume_flags(struct ntfs_volume *vol,
 		const __le16 set_bits, const __le16 clear_bits,
-		const bool skip_if_errors)
+		const bool skip_if_errors, const bool nowait)
 {
 	struct ntfs_inode *ni = NTFS_I(vol->vol_ino);
 	struct volume_information *vi;
-	struct ntfs_attr_search_ctx *ctx;
+	struct ntfs_attr_search_ctx *ctx = NULL;
 	u16 flags;
 	int err;
 
-	mutex_lock(&ni->mrec_lock);
+	if (nowait) {
+		if (!mutex_trylock(&ni->mrec_lock))
+			return -EAGAIN;
+	} else {
+		mutex_lock(&ni->mrec_lock);
+	}
 
 	if (skip_if_errors && NVolErrors(vol))
 		goto done;
@@ -394,9 +409,21 @@ static int ntfs_write_volume_flags(struct ntfs_volume *vol,
 	if (le16_to_cpu(vol->vol_flags) == flags)
 		goto done;
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	/*
+	 * The nowait path must not sleep past this point either.  An
+	 * attribute list on $Volume would make ntfs_attr_lookup() map
+	 * extent mft records, which can block; sane volumes never have
+	 * one, so refuse such a volume instead of risking the sleep.
+	 */
+	if (nowait && NInoAttrList(ni)) {
+		err = -EAGAIN;
+		goto put_unm_err_out;
+	}
+
+	ctx = ntfs_attr_get_search_ctx_gfp(ni, NULL,
+			nowait ? GFP_ATOMIC | __GFP_NOWARN : GFP_NOFS);
 	if (!ctx) {
-		err = -ENOMEM;
+		err = nowait ? -EAGAIN : -ENOMEM;
 		goto put_unm_err_out;
 	}
 
@@ -418,6 +445,18 @@ static int ntfs_write_volume_flags(struct ntfs_volume *vol,
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
 	mutex_unlock(&ni->mrec_lock);
+	/*
+	 * -EAGAIN from the nowait path is an expected "would have to
+	 * sleep" result, not a filesystem error.  Do not report it
+	 * through ntfs_error(), whose ntfs_handle_error() honors the
+	 * errors= mount option and would remount the volume read-only
+	 * or panic the system for a benign, retryable condition that
+	 * unprivileged RWF_NOWAIT writes can trigger at will.
+	 */
+	if (nowait && err == -EAGAIN) {
+		ntfs_debug("Failed with error code %i.", -err);
+		return err;
+	}
 	ntfs_error(vol->sb, "Failed with error code %i.", -err);
 	return err;
 }
@@ -435,7 +474,32 @@ static int ntfs_write_volume_flags(struct ntfs_volume *vol,
  */
 int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags)
 {
-	return ntfs_write_volume_flags(vol, flags, 0, false);
+	return ntfs_write_volume_flags(vol, flags, 0, false, false);
+}
+
+/*
+ * ntfs_set_volume_flags_nowait - set bits without sleeping
+ * @vol:	ntfs volume on which to modify the flags
+ * @flags:	flags to set on the volume
+ *
+ * Same as ntfs_set_volume_flags(), except that the call does not sleep.
+ * Contended mrec_lock, exhausted atomic memory and an attribute list on
+ * $Volume (whose extent mapping could block) each fail with -EAGAIN; see
+ * ntfs_write_volume_flags() for why the remaining path is non-blocking.
+ * For callers servicing an IOCB_NOWAIT request, which must fail with
+ * -EAGAIN rather than sleep.  That -EAGAIN is an expected retry signal
+ * rather than a filesystem error, so it is not reported through
+ * ntfs_error() and never triggers the errors= handling.
+ *
+ * A failure means the flags were NOT set; such callers should fail the
+ * request rather than proceed with the modification.
+ *
+ * Return 0 on success, -EAGAIN when the operation would have to sleep and
+ * -errno on other errors.
+ */
+int ntfs_set_volume_flags_nowait(struct ntfs_volume *vol, __le16 flags)
+{
+	return ntfs_write_volume_flags(vol, flags, 0, false, true);
 }
 
 /*
@@ -451,7 +515,7 @@ int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags)
  */
 int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags)
 {
-	return ntfs_write_volume_flags(vol, 0, flags, false);
+	return ntfs_write_volume_flags(vol, 0, flags, false, false);
 }
 
 /*
@@ -464,7 +528,7 @@ int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags)
  */
 static int ntfs_clear_volume_dirty_if_no_errors(struct ntfs_volume *vol)
 {
-	return ntfs_write_volume_flags(vol, 0, VOLUME_IS_DIRTY, true);
+	return ntfs_write_volume_flags(vol, 0, VOLUME_IS_DIRTY, true, false);
 }
 
 int ntfs_write_volume_label(struct ntfs_volume *vol, char *label)
-- 
2.25.1

