Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794044512;
	b=jW6DKZ1sNfTPVyy6B/gcVCF0Z/swraC3owtO0gy6/qLCBkKWFyCD5dmWsIRw50Mz4roW
	 3nNUGqNYl0MOss/NIIixU+eIl0JjZNCphYYeEIZuavNcNdwAwCOnVh8VIcBUO5dcAnubU
	 QJvy3HTC2jWeRUcUOu0IJvaBiRfYola19AvoKQnRC5YLPNNMCb7h8Vdo5FVXcLdNU00Pi
	 WzjhV8sgvr8Cw2w5b3Vxn4tuAcXX+0HhmK6jD7EP9AfPUjn4M/ZIKYSRIl00zQv5SmNFY
	 9Yratb92fwTZWXxLc2T29SlYeVaFoC4/klSAH+kCnyHPGRCyX4zLHtJ104dQ3Yy1NMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794044512;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HisJ2IsuSMqWMvv9c32Iop9hBTORXVtBSKNYXh4di9k=;
	b=zHFaBO+QYqblopaNklaZ0fachptJ13coWNK4/nnlBuk4jA5Lb4ukYPsMijPyjsNTna6a
	 48YcmHZqzZYBFK53gjEchnBjpjpXTftjNv9Q9RIoWSTbGiKTZra5qM9mTk+nYYWxjVSMZ
	 E9XYMOZVtS+0MKpFmnvJOgptlsIWz1xpp1vEvZjVTNCg3RzS2eCs9i6Zfi/7gNKkHt6NW
	 9WjC7vH3Pm8Cg+gtdf4EQwPgzlznzgOVIAARHdH8OKIhUCxUvwIp4UYkNKcQOdNZshfZZ
	 J3bRIKJaIZaUoewkibdMZarUPCRMGZBoQwV1FrYlr2I5yUIxpFSa1IVtahggpv13Npw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="sDYG9B/R";
	arc=none smtp.remote-ip=203.205.221.233
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C60606A334;
	Sat,  7 Nov 2026 09:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87C60606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=sDYG9B/R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794044502; bh=HisJ2IsuSMqWMvv9c32Iop9hBTORXVtBSKNYXh4di9k=;
	h=From:To:Cc:Subject:Date;
	b=sDYG9B/RWivtoxsG6CcijLnhame9DW3VjkI6m1mHdRS9JbKvGaKOSquVNmu16NV9b
	 +zQbR43QwwH6bF4v/X+yRCcQCy5WZJ08FH3K4uqS69ZXczEJqjDBZpkK4IWIj0b67b
	 rtM7kw2JtvxTJLUlAfG2Fa+zXYJI3vV895HkSgaw=
Received: from xkeyc-nixos ([219.139.218.139])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id A67ACE32; Sat, 07 Nov 2026 17:41:39 +0800
X-QQ-mid: xmsmtpt1794044499ti9w54qgg
Message-ID: <tencent_2859327A0C68D0D0429ED90F931234059808@qq.com>
X-QQ-XMAILINFO: NwIPvWX4YDagFX2Xaa82mmGgrUXvZRWCDinpxgBro8mFeAg5zV4dG3xKAvUuOf
	 3eamjuK5pu0CBtNtnrDLqhQv6e6v2EjeHgwUI8IZwkaIuNMYGa5CJUuDdF+5m4pLGtGJ4oY6XdxE
	 WmMLiROqBBG5Bpek6G0UiUZoeLasU1OBbrzxXlONeHx4fidbfN1jIW6Jg+0DF/pPnijlWN73L97W
	 FJ51Uautf8bitka9OTVxmGVttHpArj4mltI4RR8FcQcSt0hNHnld9uz5+KOUknCfL4S3g756wfK+
	 7MPQhEKs7qq8bj6xgHOQBm/173nc6q+i3tKXwXU5WF0STyix9pSpt82DpXvsFar9PYUeyt4un2wZ
	 aiTVWX2zWHyFhTwUZYVm0u2aizduCGFXz7jSv4uCXjQf6rxkDvEASO2ZtvYq9IgAk2kb7ee7C3Xr
	 qzfnFh4qP0nG1Cu2Xs766+AuQ+74tVR+zEPuMtulbY8qoSmHq0D+ar9p6zuQ9dI1lUaRsMYa/D2w
	 +5XqPis4ot72MdBMrFL7cbACVgdxY/MBKkktlk4UsNWA1aj+ldpAnQpzirKez6uvt+vt3X3jJ0y6
	 mRX+fIQpl1O9QFR5L74WEFYAsRT93L3xQcoW1WrWjDQj3XJSRrdwaE7z7l4GW8Kyv9Ew+bZDp1zT
	 lkO6LwgIxrGGStcP5z1/H7hSeIu9tcFy0iSWL3d+4ZwH4Qm/gOdiKPuY4QytHI4gLxa4zCXt4l02
	 hVFqDkjIaE/zUFUronsH7wJlswzfNadfJC23/EjwvcWTnii1b+yiN+jVzoj/iLoP6HvqfAATQCC2
	 mmF/iAEzp4z1aMa8fQXuMrT3qr7TYiv5S9fQr3qztRyXm0OTmkGCuo/02QyAwxJd5FfNYAtnsUIi
	 UhQ7uDXNYEv9jsJs7P8gTwl46uZRizpwyPQXMGF3488i+GpbfFSoNfH6c+B8/ejFQ+pIfN+aeFQH
	 F5ua29Gk888RRf0T1ttVS2o7wJYfxFcTFIcX1VxQukO3aGw/pkrZFXyvIwtYyYTc3vRfNKsGYHGo
	 5ta8s1k3/Zp+FkhlJEtrAWTwNsV7jZzjiQvhS+8AeaA+U9To9LEEQydsHjIOtmBNPBmM4e+lac+o
	 oL6qAoezL5LJtbHjCVNzbLdtT9B/hA+YHmVNau
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: xkeyC <xkeyc@qq.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xkeyC <xkeyc@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: don't let a fatal signal interrupt metadata reads
Date: Sat,  7 Nov 2026 17:41:23 +0800
X-OQ-MSGID: <20261107094123.1971125-1-xkeyc@qq.com>
X-Mailer: git-send-email 2.56.0
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

read_mapping_folio() returns -EINTR when the caller has a fatal signal
pending while it waits for the read it submitted. ntfs reads its metadata
through it and treats the failure as a volume error, so killing a task
that waits on a metadata read turns the volume read-only with
errors=remount-ro. A read that is part of an update also stops the update
half way: killing an rm can leave clusters allocated in $Bitmap, an MFT
record in use without a directory entry, or a directory index with
entries that point to freed records.

Add ntfs_read_metadata_folio(), which waits for the read uninterruptibly,
and use it for metadata reads. Mount-time checks, compressed data and
named stream contents keep using read_mapping_folio(). A killed task now
waits for its metadata read to complete, as it does on filesystems that
use the buffer cache.

Closes: https://github.com/namjaejeon/linux-ntfs/issues/98
Fixes: 11ccc9107dc4 ("ntfs: update runlist handling and cluster allocator")
Fixes: 115380f9a2f9 ("ntfs: update mft operations")
Fixes: af0db57d4293 ("ntfs: update inode operations")
Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org
Signed-off-by: xkeyC <xkeyc@qq.com>
---
Reproducers and logs: https://github.com/xkeyC/linux-ntfs/tree/eintr-repro

In QEMU (KASAN, lockdep, reads throttled), killing rm, ls -l, fallocate
or dd partway through turned the volume read-only within a few runs
without this patch, and ntfsck found damage after rm. With it, 20 runs of
each stayed read-write and clean. Index inserts were not reached.

Developed with an AI coding assistant (Claude Code), which wrote the
change and the reproducers and ran the tests.

 fs/ntfs/aops.c     | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs/attrib.c   |  2 +-
 fs/ntfs/bdev-io.c  |  2 +-
 fs/ntfs/bitmap.c   |  4 ++--
 fs/ntfs/dir.c      |  4 ++--
 fs/ntfs/inode.c    | 12 +++++++---
 fs/ntfs/lcnalloc.c |  2 +-
 fs/ntfs/mft.c      | 20 ++++++++--------
 fs/ntfs/ntfs.h     |  4 ++++
 9 files changed, 88 insertions(+), 20 deletions(-)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index ad781674f..767aecf42 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -7,6 +7,7 @@
  * Copyright (c) 2025 LG Electronics Co., Ltd.
  */
 
+#include <linux/swap.h>
 #include <linux/writeback.h>
 
 #include "attrib.h"
@@ -304,6 +305,63 @@ static int ntfs_swap_activate(struct swap_info_struct *sis,
 			&ntfs_read_iomap_ops);
 }
 
+/**
+ * ntfs_read_metadata_folio - read a metadata folio, ignoring fatal signals
+ * @mapping:	address space of the metadata inode or block device
+ * @index:	page cache index to read
+ *
+ * Like read_mapping_folio(), but the wait for the read cannot be interrupted,
+ * so a fatal signal cannot fail a metadata read in the middle of an update.
+ * The caller must not hold the lock of the folio at @index.
+ *
+ * Return: the uptodate folio with a reference held, or an ERR_PTR().
+ */
+struct folio *ntfs_read_metadata_folio(struct address_space *mapping,
+				       pgoff_t index)
+{
+	struct folio *folio;
+	bool read_failed = false;
+	int err;
+
+	folio = filemap_get_folio(mapping, index);
+	if (!IS_ERR(folio)) {
+		if (folio_test_uptodate(folio))
+			goto out;
+		folio_put(folio);
+	}
+repeat:
+	folio = __filemap_get_folio(mapping, index, FGP_LOCK | FGP_CREAT,
+				    mapping_gfp_mask(mapping));
+	if (IS_ERR(folio))
+		return folio;
+	/* $MFT updates clear uptodate under the folio lock, so check it locked. */
+	if (folio_test_uptodate(folio)) {
+		folio_unlock(folio);
+		goto out;
+	}
+	if (read_failed) {
+		folio_unlock(folio);
+		folio_put(folio);
+		return ERR_PTR(-EIO);
+	}
+
+	/* ->read_folio() unlocks the folio when the read completes. */
+	err = mapping->a_ops->read_folio(NULL, folio);
+	if (err) {
+		folio_put(folio);
+		if (err == AOP_TRUNCATED_PAGE)
+			goto repeat;
+		return ERR_PTR(err);
+	}
+	folio_wait_locked(folio);
+	read_failed = !folio_test_uptodate(folio);
+	folio_put(folio);
+	goto repeat;
+out:
+	folio_mark_accessed(folio);
+	return folio;
+}
+
 const struct address_space_operations ntfs_aops = {
 	.read_folio		= ntfs_read_folio,
 	.readahead		= ntfs_readahead,
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 800e53df5..cf73fa4c3 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -2323,7 +2323,7 @@ int ntfs_attr_set(struct ntfs_inode *ni, s64 ofs, s64 cnt, const u8 val)
 
 	index = ofs >> PAGE_SHIFT;
 	while (cnt) {
-		folio = read_mapping_folio(mapping, index, NULL);
+		folio = ntfs_read_metadata_folio(mapping, index);
 		if (IS_ERR(folio)) {
 			ret = PTR_ERR(folio);
 			ntfs_error(VFS_I(ni)->i_sb, "Failed to read a page %lu for attr %#x: %ld",
diff --git a/fs/ntfs/bdev-io.c b/fs/ntfs/bdev-io.c
index 4f27eed3b..afb1d1df3 100644
--- a/fs/ntfs/bdev-io.c
+++ b/fs/ntfs/bdev-io.c
@@ -99,7 +99,7 @@ int ntfs_bdev_write(struct super_block *sb, void *buf, loff_t start, size_t size
 	for (; idx < idx_end; idx++, from = 0) {
 		u32 len;
 
-		folio = read_mapping_folio(sb->s_bdev->bd_mapping, idx, NULL);
+		folio = ntfs_read_metadata_folio(sb->s_bdev->bd_mapping, idx);
 		if (IS_ERR(folio)) {
 			ntfs_error(sb, "Unable to read %ld page", idx);
 			return PTR_ERR(folio);
diff --git a/fs/ntfs/bitmap.c b/fs/ntfs/bitmap.c
index af86fb1c1..1002d9c98 100644
--- a/fs/ntfs/bitmap.c
+++ b/fs/ntfs/bitmap.c
@@ -203,7 +203,7 @@ int __ntfs_bitmap_set_bits_in_run(struct inode *vi, const s64 start_bit,
 
 	/* Get the page containing the first bit (@start_bit). */
 	mapping = vi->i_mapping;
-	folio = read_mapping_folio(mapping, index, NULL);
+	folio = ntfs_read_metadata_folio(mapping, index);
 	if (IS_ERR(folio)) {
 		if (!is_rollback)
 			ntfs_error(vi->i_sb,
@@ -267,7 +267,7 @@ int __ntfs_bitmap_set_bits_in_run(struct inode *vi, const s64 start_bit,
 		folio_unlock(folio);
 		kunmap_local(kaddr);
 		folio_put(folio);
-		folio = read_mapping_folio(mapping, ++index, NULL);
+		folio = ntfs_read_metadata_folio(mapping, ++index);
 		if (IS_ERR(folio)) {
 			ntfs_error(vi->i_sb,
 				   "Failed to map subsequent page (error %li), aborting.",
diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index 9fb5bb3d3..ce87799a2 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -327,8 +327,8 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *dir_ni, const __le16 *uname,
 	 * of PAGE_SIZE and map the page cache page, reading it from
 	 * disk if necessary.
 	 */
-	folio = read_mapping_folio(ia_mapping, vcn <<
-			dir_ni->itype.index.vcn_size_bits >> PAGE_SHIFT, NULL);
+	folio = ntfs_read_metadata_folio(ia_mapping, vcn <<
+			dir_ni->itype.index.vcn_size_bits >> PAGE_SHIFT);
 	if (IS_ERR(folio)) {
 		ntfs_error(sb, "Failed to map directory index page, error %ld.",
 				-PTR_ERR(folio));
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 62dd5bd5b..9bf7957af 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -3773,8 +3773,14 @@ s64 ntfs_inode_attr_pread(struct inode *vi, s64 pos, s64 count, u8 *buf)
 
 	index = pos >> PAGE_SHIFT;
 	do {
-		/* Update @index and get the next folio. */
-		folio = read_mapping_folio(mapping, index, NULL);
+		/*
+		 * Update @index and get the next folio.  The contents of a named
+		 * stream are user data, so a fatal signal may still stop that read.
+		 */
+		if (ntfs_inode_is_named_stream(ni))
+			folio = read_mapping_folio(mapping, index, NULL);
+		else
+			folio = ntfs_read_metadata_folio(mapping, index);
 		if (IS_ERR(folio)) {
 			err = PTR_ERR(folio);
 			break;
@@ -3926,7 +3932,7 @@ static s64 __ntfs_inode_non_resident_attr_pwrite(struct inode *vi,
 				break;
 			}
 		} else {
-			folio = read_mapping_folio(mapping, index, NULL);
+			folio = ntfs_read_metadata_folio(mapping, index);
 			if (IS_ERR(folio)) {
 				ret = PTR_ERR(folio);
 				ntfs_error(vi->i_sb, "Failed to read a page %lu for attr %#x: %ld",
diff --git a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
index 3ebcac4c2..7e00016f4 100644
--- a/fs/ntfs/lcnalloc.c
+++ b/fs/ntfs/lcnalloc.c
@@ -340,7 +340,7 @@ struct runlist_element *ntfs_cluster_alloc(struct ntfs_volume *vol, const s64 st
 		if (vol->lcn_empty_bits_per_page[index] == 0)
 			goto next_bmp_pos;
 
-		folio = read_mapping_folio(mapping, index, NULL);
+		folio = ntfs_read_metadata_folio(mapping, index);
 		if (IS_ERR(folio)) {
 			err = PTR_ERR(folio);
 			ntfs_error(vol->sb, "Failed to map page.");
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 89288b794..3601f77ee 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -143,7 +143,7 @@ static inline struct mft_record *map_mft_record_folio(struct ntfs_inode *ni)
 	}
 
 	/* Read, map, and pin the folio. */
-	folio = read_mapping_folio(mft_vi->i_mapping, index, NULL);
+	folio = ntfs_read_metadata_folio(mft_vi->i_mapping, index);
 	if (!IS_ERR(folio)) {
 		u8 *addr;
 
@@ -549,8 +549,8 @@ static int ntfs_sync_mft_mirror_unit(struct ntfs_volume *vol,
 	if (unit->folio_ofs + unit->len > folio_size(source))
 		return -EIO;
 
-	mirror = read_mapping_folio(vol->mftmirr_ino->i_mapping,
-				    mirror_file_ofs >> PAGE_SHIFT, NULL);
+	mirror = ntfs_read_metadata_folio(vol->mftmirr_ino->i_mapping,
+					  mirror_file_ofs >> PAGE_SHIFT);
 	if (IS_ERR(mirror))
 		return PTR_ERR(mirror);
 
@@ -1023,7 +1023,7 @@ static bool mft_reserved_is_free(struct ntfs_volume *vol,
 	if (!m)
 		return false;
 
-	folio = read_mapping_folio(vol->mft_ino->i_mapping, index, NULL);
+	folio = ntfs_read_metadata_folio(vol->mft_ino->i_mapping, index);
 	if (IS_ERR(folio))
 		goto free_m;
 
@@ -1199,8 +1199,8 @@ static s64 mft_bitmap_alloc_free_rec(struct ntfs_volume *vol,
 		 * for a zero bit.
 		 */
 		if (size) {
-			folio = read_mapping_folio(mftbmp_mapping,
-					ofs >> PAGE_SHIFT, NULL);
+			folio = ntfs_read_metadata_folio(mftbmp_mapping,
+							 ofs >> PAGE_SHIFT);
 			if (IS_ERR(folio)) {
 				ntfs_error(vol->sb, "Failed to read mft bitmap, aborting.");
 				return PTR_ERR(folio);
@@ -1392,8 +1392,8 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(struct ntfs_volume *vol)
 	 * to us.
 	 */
 	ll = lcn >> 3;
-	folio = read_mapping_folio(vol->lcnbmp_ino->i_mapping,
-			ll >> PAGE_SHIFT, NULL);
+	folio = ntfs_read_metadata_folio(vol->lcnbmp_ino->i_mapping,
+					 ll >> PAGE_SHIFT);
 	if (IS_ERR(folio)) {
 		up_write(&mftbmp_ni->runlist.lock);
 		ntfs_error(vol->sb, "Failed to read from lcn bitmap.");
@@ -2207,7 +2207,7 @@ static int ntfs_mft_record_format(const struct ntfs_volume *vol, const s64 mft_n
 	}
 
 	/* Read, map, and pin the folio containing the mft record. */
-	folio = read_mapping_folio(mft_vi->i_mapping, index, NULL);
+	folio = ntfs_read_metadata_folio(mft_vi->i_mapping, index);
 	if (IS_ERR(folio)) {
 		ntfs_error(vol->sb, "Failed to map page containing mft record to format 0x%llx.",
 				(long long)mft_no);
@@ -2725,7 +2725,7 @@ int ntfs_mft_record_alloc(struct ntfs_volume *vol, const int mode,
 	index = NTFS_MFT_NR_TO_PIDX(vol, bit);
 	ofs = NTFS_MFT_NR_TO_POFS(vol, bit);
 	/* Read, map, and pin the folio containing the mft record. */
-	folio = read_mapping_folio(vol->mft_ino->i_mapping, index, NULL);
+	folio = ntfs_read_metadata_folio(vol->mft_ino->i_mapping, index);
 	if (IS_ERR(folio)) {
 		ntfs_error(vol->sb, "Failed to map page containing allocated mft record 0x%llx.",
 				bit);
diff --git a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
index fac72d40f..f33df986f 100644
--- a/fs/ntfs/ntfs.h
+++ b/fs/ntfs/ntfs.h
@@ -294,6 +294,10 @@ static inline int ntfs_ffs(int x)
 	return r;
 }
 
+/* From fs/ntfs/aops.c */
+struct folio *ntfs_read_metadata_folio(struct address_space *mapping,
+				       pgoff_t index);
+
 /* From fs/ntfs/bdev-io.c */
 int ntfs_bdev_read(struct block_device *bdev, char *data, loff_t start, size_t size);
 int ntfs_bdev_write(struct super_block *sb, void *buf, loff_t start, size_t size);
-- 
2.56.0

