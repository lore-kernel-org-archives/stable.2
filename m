Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794454177;
	b=dX0D1M4OOMGUJ6XLtg6t6oieSrfEEpQ+nzRy6rS3/bisLEeg+ll1rH0TNU8yZOfQJ69E
	 YwqiAa/Wt/N5SXGQJnV3NNMn58hy8AiGrugP6V7O1uOxJX3PFGJEopDB9EOILAWlj/5cd
	 6aRD97LXZvU+UrcgvQScB4knVqH384jGlzTRPrCL2uAKeK6xIutle/tiDmIp1VyGN9NvH
	 j7y2vOs0VwN54/JIeFaimvULjEaeR7JyvrL7ZW+BpDIYha/4a4K3PKzUukwMU9f2Cadh9
	 W0CDbVWp++hNn38CDJ6zgI8ZkFAxkVKD3v3LDxYzeD7rnffek55pGqYxqxYbIWCmTAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794454177;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=en7Tbht2dmop2bF3nUwlEjx2VKq37OQWrIhBa9ge3PA=;
	b=e/1oEPbiToxVRqBTgu2GIDjMdqmZgr0NNBwtNMRfrk1RGHN34SoG6+2Tk+4saezr96qz
	 SUkvp01Y0fD3yFi8YnRlhN/XmeiKuD94nyDPlb+t6DxYn8v255nuncYcegH0ZCCCFW1RW
	 gwkow8IBM4hV1SVnGGwiS+mew0uSjXotSlOa8s8tIV+rPUvyNv6IETvnSh1TBoFXUEjWj
	 O71reIVoO0NI+ntPYuapA+ecMp44ahRnluFbKegnjmJd9M5nk8AOnQZVN9lq6Z3FCSYS6
	 uKgz2wc0uDQPCQY3vC5T9GoRe7vc8rU7ajgfqPa2PW58XcVq6tAai9SB2CoJtwivvMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=SwxsxlD6;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A9606A321;
	Thu, 12 Nov 2026 03:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 086A9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=SwxsxlD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794454172; bh=en7Tbht2dmop2bF3nUwlEjx2VKq37OQWrIhBa9ge3PA=;
	h=From:To:Cc:Subject:Date;
	b=SwxsxlD6QQ5C6FbxiY4oWWhIxoqjZ2dlr2Pa00fxaPUfm8AQw+MCGVjR/TURNnv56
	 tPg8NWwyswkLEWO7HN5JqQAgxqQKriDY5wvCGOSvOXKmZdque5BFm3J+jBVDLYK7RE
	 SbxRS4vpWVU4TYWl5Y8rEI8EOdSRvlTAeWuMDJ0s=
Received: from xkeyc-nixos ([119.97.45.41])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 75E02033; Thu, 12 Nov 2026 11:29:30 +0800
X-QQ-mid: xmsmtpt1794454170txip94pe1
Message-ID: <tencent_AF42E4D94D935F34EB985032150C6AD0DF08@qq.com>
X-QQ-XMAILINFO: M2SvzgchpLqfFMgBlCtNkzBOKuSq4KAmK0cUIbN/kzoT9TpnMSWzIIQPTkq1Ls
	 ZVXO/7L5VkHEkCTn9FrYckzZ9qW1X9n9cMCqUNJG2v36uvHEXCobeb7tLqPjyeLb/vJe61aZ8ECV
	 niBAJE5wlgpKPhNoCf9HmSbF7MQ5xjRiIvVyEvbFTG5hFxRfX2mCkToXNv12zk5ftLIMP3Eul7I3
	 vn1CIgQNFbqsTANiDt/ZxWfPeFH5foidcFabSBTJafNMJ4rAR2PsuMMCMt0EZ2irgc/QSJmJ0L+W
	 HjQ1b/PAJ1Z83uSgxRXSP6JxRGVMKILw935CMzV+7S0J6vtnZKSMv7GIew2sfFZHzjlv10ZAoCza
	 BFq2y/0B/fjkNK9442uykMhh7XIsfhjVdgGy4DyijaEW/Jo14kO0TsIXQlygR89+hcYCwoundg8R
	 hae2Ic11JQoopWyIl6hy9zopomUBlnhmXuZlFFJ6PLPVs6+kK04ryksLl+K4sEJOzLxafNUjdkjw
	 8xTlc8+cYrOkKJTOQJjFzPE4IhUqlgg1HKz+vDkpIna8wl2Jzy5VvMDUjBtak15itm/Y+pzkR+sq
	 Jbk7hKlxd8oMJhltvCl71TioQ8emGFAwW5u/HMTNj1iGOihexUe2/QBagRY6CB0PaeEKapQ21AVm
	 REWT+HWHsmTX+TNX7XGPrUBpQnxznNZPjfJgQBLU3pfuIzn3qBMh+9K/eiWffGXrWrU8CfWE8qRs
	 2lxmHKcXQ6Bky6uObqbtOhCSL09302a2wcoCYSB3PO1X47Ons15tBUgYA7JHEEApv2r5jSykfeEl
	 70QZzCh9hQAoxGoXSeWtt141ALHQkyybNH4/4NLuGKXDSJ5f70tHZHOgT73TiavMGdVnGyNltf1z
	 gi480jO57VBlEhAeS4/WbFDNod6R2H48eD7HLO8JKsjADLk2UpKVipSVSQXiJC8PThMiQLAADR5F
	 O9HKDc0cBm2N1+N2VOOnh8uUt2O5Pa6CNKZiIB62Dlm+NqzmLyIvpLxgHOyfGeovh4ZXp52M7fDX
	 MmNUU+xVlBU5hBsB1XRE5Dp6oQITu49rxtp7ZmJjoD/1ct/MNarguX5P92kSqXx3YW/iWxSA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: xkeyC <xkeyc@qq.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xkeyC <xkeyc@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ntfs: don't let a fatal signal interrupt metadata reads
Date: Thu, 12 Nov 2026 11:29:26 +0800
X-OQ-MSGID: <20261112032926.35057-1-xkeyc@qq.com>
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
entries that point to freed records. Killing a mount makes it fail with
bogus $AttrDef and $UpCase errors, or leaves the volume mounted read-only
with a bogus $MFTMirr or $BadClus error.

Add ntfs_read_metadata_folio(), which waits for the read uninterruptibly,
and use it for metadata reads. Named stream contents, compressed data and
the read-only bitmap scans through ntfs_get_locked_folio(), whose callers
do not report a volume error, keep using read_mapping_folio(). A named
stream write that is interrupted that way no longer reports a volume
error either. A killed task now waits for its metadata read to complete,
as it does on filesystems that use the buffer cache.

Closes: https://github.com/namjaejeon/linux-ntfs/issues/98
Fixes: 11ccc9107dc4 ("ntfs: update runlist handling and cluster allocator")
Fixes: 115380f9a2f9 ("ntfs: update mft operations")
Fixes: af0db57d4293 ("ntfs: update inode operations")
Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
Fixes: 5218cd102aec ("ntfs: update misc operations")
Fixes: 6251f0b0de7d ("ntfs: update super block operations")
Fixes: 8506a8031ebf ("ntfs: validate and reserve bad clusters at mount")
Cc: stable@vger.kernel.org
Signed-off-by: xkeyC <xkeyc@qq.com>
---
v2:
- Keep reads of named stream contents killable in writes too, and don't
  report -EINTR from them as a volume error (Hyunchul)
- Also convert the mount-time reads of $LogFile, $MFTMirr, hiberfil.sys,
  $AttrDef, $UpCase and $BadClus (Hyunchul)
- Add the missing Fixes tags (Hyunchul)

v1: https://lore.kernel.org/ntfs/tencent_2859327A0C68D0D0429ED90F931234059808@qq.com/

Reproducers and logs: https://github.com/xkeyC/linux-ntfs/tree/eintr-repro

In QEMU (KASAN, lockdep, reads throttled), killing rm, ls -l, fallocate,
dd, a named stream write or mount partway through turned the volume
read-only or failed the mount within a few runs without this patch, and
ntfsck found damage after rm. With it, 20 runs of each kept the volume
read-write and ntfsck clean. The reporter of the GitHub issue confirmed
that v1 fixes the cases there.

Developed with an AI coding assistant (Claude Code), which wrote the
change and the reproducers and ran the tests.

 fs/ntfs/aops.c     | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs/attrib.c   |  2 +-
 fs/ntfs/bdev-io.c  |  2 +-
 fs/ntfs/bitmap.c   |  7 +++---
 fs/ntfs/dir.c      |  4 ++--
 fs/ntfs/inode.c    | 21 ++++++++++++++---
 fs/ntfs/lcnalloc.c |  2 +-
 fs/ntfs/logfile.c  |  4 ++--
 fs/ntfs/mft.c      | 20 ++++++++--------
 fs/ntfs/ntfs.h     |  4 ++++
 fs/ntfs/super.c    | 14 +++++------
 11 files changed, 107 insertions(+), 31 deletions(-)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index ad781674fe..767aecf423 100644
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
index 800e53df57..cf73fa4c33 100644
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
index 4f27eed3b0..afb1d1df37 100644
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
index af86fb1c19..0ad80255d6 100644
--- a/fs/ntfs/bitmap.c
+++ b/fs/ntfs/bitmap.c
@@ -36,8 +36,7 @@ int ntfs_bitmap_check_used(struct ntfs_volume *vol, s64 start, s64 count,
 		return -EROFS;
 
 	while (count) {
-		folio = read_mapping_folio(mapping,
-					   start >> (PAGE_SHIFT + 3), NULL);
+		folio = ntfs_read_metadata_folio(mapping, start >> (PAGE_SHIFT + 3));
 		if (IS_ERR(folio))
 			return PTR_ERR(folio);
 
@@ -203,7 +202,7 @@ int __ntfs_bitmap_set_bits_in_run(struct inode *vi, const s64 start_bit,
 
 	/* Get the page containing the first bit (@start_bit). */
 	mapping = vi->i_mapping;
-	folio = read_mapping_folio(mapping, index, NULL);
+	folio = ntfs_read_metadata_folio(mapping, index);
 	if (IS_ERR(folio)) {
 		if (!is_rollback)
 			ntfs_error(vi->i_sb,
@@ -267,7 +266,7 @@ int __ntfs_bitmap_set_bits_in_run(struct inode *vi, const s64 start_bit,
 		folio_unlock(folio);
 		kunmap_local(kaddr);
 		folio_put(folio);
-		folio = read_mapping_folio(mapping, ++index, NULL);
+		folio = ntfs_read_metadata_folio(mapping, ++index);
 		if (IS_ERR(folio)) {
 			ntfs_error(vi->i_sb,
 				   "Failed to map subsequent page (error %li), aborting.",
diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index 9fb5bb3d35..ce87799a28 100644
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
index 62dd5bd5bb..b7fb57d084 100644
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
@@ -3926,9 +3932,18 @@ static s64 __ntfs_inode_non_resident_attr_pwrite(struct inode *vi,
 				break;
 			}
 		} else {
-			folio = read_mapping_folio(mapping, index, NULL);
+			/*
+			 * Named stream contents are user data; keep that read
+			 * killable, as in ntfs_inode_attr_pread().
+			 */
+			if (ntfs_inode_is_named_stream(ni))
+				folio = read_mapping_folio(mapping, index, NULL);
+			else
+				folio = ntfs_read_metadata_folio(mapping, index);
 			if (IS_ERR(folio)) {
 				ret = PTR_ERR(folio);
+				if (ret == -EINTR)
+					break;
 				ntfs_error(vi->i_sb, "Failed to read a page %lu for attr %#x: %ld",
 						index, ni->type, PTR_ERR(folio));
 				break;
diff --git a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
index 3ebcac4c28..7e00016f42 100644
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
diff --git a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
index 2f27ae7a39..cdc951309d 100644
--- a/fs/ntfs/logfile.c
+++ b/fs/ntfs/logfile.c
@@ -367,7 +367,7 @@ static int ntfs_check_and_load_restart_page(struct inode *vi,
 		to_read = le32_to_cpu(rp->system_page_size) - size;
 		idx = (pos + size) >> PAGE_SHIFT;
 		do {
-			folio = read_mapping_folio(vi->i_mapping, idx, NULL);
+			folio = ntfs_read_metadata_folio(vi->i_mapping, idx);
 			if (IS_ERR(folio)) {
 				ntfs_error(vi->i_sb, "Error mapping LogFile page (index %lu).",
 						idx);
@@ -514,7 +514,7 @@ bool ntfs_check_logfile(struct inode *log_vi, struct restart_page_header **rp)
 				kunmap_local(kbase);
 				folio_put(folio);
 			}
-			folio = read_mapping_folio(mapping, idx, NULL);
+			folio = ntfs_read_metadata_folio(mapping, idx);
 			if (IS_ERR(folio)) {
 				ntfs_error(vol->sb, "Error mapping LogFile page (index %lu).",
 						idx);
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 89288b7943..3601f77eee 100644
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
index fac72d40f5..f33df986f5 100644
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
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 71f0aea46b..af97afe6a7 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1187,8 +1187,8 @@ static bool check_mft_mirror(struct ntfs_volume *vol)
 				folio_put(mft_folio);
 			}
 			/* Get the $MFT page. */
-			mft_folio = read_mapping_folio(vol->mft_ino->i_mapping,
-					index, NULL);
+			mft_folio = ntfs_read_metadata_folio(vol->mft_ino->i_mapping,
+							     index);
 			if (IS_ERR(mft_folio)) {
 				ntfs_error(sb, "Failed to read $MFT.");
 				return false;
@@ -1196,8 +1196,8 @@ static bool check_mft_mirror(struct ntfs_volume *vol)
 			kmft_base = kmap_local_folio(mft_folio, 0);
 			kmft = kmft_base;
 			/* Get the $MFTMirr page. */
-			mirr_folio = read_mapping_folio(vol->mftmirr_ino->i_mapping,
-					index, NULL);
+			mirr_folio = ntfs_read_metadata_folio(vol->mftmirr_ino->i_mapping,
+							      index);
 			if (IS_ERR(mirr_folio)) {
 				ntfs_error(sb, "Failed to read $MFTMirr.");
 				goto mft_unmap_out;
@@ -1395,7 +1395,7 @@ static int check_windows_hibernation_status(struct ntfs_volume *vol)
 		goto iput_out;
 	}
 
-	folio = read_mapping_folio(vi->i_mapping, 0, NULL);
+	folio = ntfs_read_metadata_folio(vi->i_mapping, 0);
 	if (IS_ERR(folio)) {
 		ntfs_error(vol->sb, "Failed to read from hiberfil.sys.");
 		ret = PTR_ERR(folio);
@@ -1460,7 +1460,7 @@ static bool load_and_init_attrdef(struct ntfs_volume *vol)
 	while (index < max_index) {
 		/* Read the attrdef table and copy it into the linear buffer. */
 read_partial_attrdef_page:
-		folio = read_mapping_folio(ino->i_mapping, index, NULL);
+		folio = ntfs_read_metadata_folio(ino->i_mapping, index);
 		if (IS_ERR(folio))
 			goto free_iput_failed;
 		addr = kmap_local_folio(folio, 0);
@@ -1526,7 +1526,7 @@ static bool load_and_init_upcase(struct ntfs_volume *vol)
 	while (index < max_index) {
 		/* Read the upcase table and copy it into the linear buffer. */
 read_partial_upcase_page:
-		folio = read_mapping_folio(ino->i_mapping, index, NULL);
+		folio = ntfs_read_metadata_folio(ino->i_mapping, index);
 		if (IS_ERR(folio))
 			goto iput_upcase_failed;
 		addr = kmap_local_folio(folio, 0);

base-commit: 2b4bb6d6d8fe8315a655cb63f186013bfb45dd21
-- 
2.56.0

