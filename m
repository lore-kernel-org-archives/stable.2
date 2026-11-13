Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540408;
	b=IHOEpfHxSyr/mqIX9A5ygLcUTmrQYsO9MHcQ8IWZBdB08n9TMIWA4ddsFhAmfQJkzR6x
	 dmv5i3y5jtu9sk/ZLeWSUz0ZBKJCNtBSSS0iSCgV4W6xlcT9G8rOpAxNVzwITMy+C8gJ5
	 7EvTpdo+EOGr5o5JmW2jigy2T89KubSM98WCZeu3DZypf7ShBPuVVILfwTgW11CmmVCIJ
	 TFVGmP66ppdC67aGTmnJRuxeqTJLQJ7Kn4hBB78A6Wn5VoGJCyaTkZC4ojNdLl9gfW2Dx
	 1yD7+PDqKG214RzX3ZuL+rR530SQBc3LFDijKvXH5Bh2bnmoDnqJbCzUpvKcfCr/pPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540408;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NLQjYNisWrp3hkk4/Qmxm41E0GcI0y+NCPfD9yQ5Nug=;
	b=E3jPKk7Kb+ohNxIUxTcch3YIPWB9N4IczZOku3sQ9Ig0k/cOupIRprT86uO38LSKko26
	 Am3shrWrqIHdXD24lxDJlBn8R5pvlJ8dUfefgOj8qMnZVMnkfuND0GGqZAGBMThRnHOnu
	 wfjwrkD0ZNVmTxvph12LA06bc4t1KSf75On/ImYtFNmK7I1TpxWNzYUinGQPudSsGFglS
	 yhK38eYZ/qcUA4rsiCqZs2Od57cFkV3ZEbIjgMeG5zT/xsnxsHTGbx2CyBY0Pc6Zv0o5T
	 /AxeT17456akT/FAo/iJN8nSxF5/gxXC62ejNUxdRXODvRx5S56ZeHTxM+gP7+T82sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Bf6uM2kQ;
	arc=none smtp.remote-ip=203.205.221.173
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB803606A32E;
	Fri, 13 Nov 2026 03:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB803606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Bf6uM2kQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794540403; bh=NLQjYNisWrp3hkk4/Qmxm41E0GcI0y+NCPfD9yQ5Nug=;
	h=From:To:Cc:Subject:Date;
	b=Bf6uM2kQXsKCw6t+4dBT6BF30n+3iBHt6spGV6dGwc36Tm7dpZhbzyXZ1uuteePpb
	 H543mAPk2eXtPNeakeoHrHroxGfxx1dQr/5H16lpZfrwmeyQcxlkjdKMDEWSQXOd26
	 0jRDPSfz3ZqfLswYNYUSAw0mf+FiFD1+YHG84jlM=
Received: from xkeyc-nixos ([119.97.45.41])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 6940D264; Fri, 13 Nov 2026 11:26:20 +0800
X-QQ-mid: xmsmtpt1794540380tf6kgw9u2
Message-ID: <tencent_BED06C76C024128D13E6854C2FC31BF48A06@qq.com>
X-QQ-XMAILINFO: OGDllvpfz+egz9GdGVm/me/e/6ipOhzEo2qGevipHJhCvO1qywonK7kvUMtb+F
	 1d2VsFgs5dPwds05ZY5OMTE+3L3xd9WrC7vOJSjbFB1o14yQZBe9DjkNeh2lHoLLTeF7PWVHDVup
	 YsRUQ2ZELu2Qv5EkZg7fShzp68Ka9+VswcQ/XwQMniv7EQ2sNTgo1w3MVR0EJgdGVOtFZ/qZBbbH
	 vsiZCLqQdNwUTmtlXzHYCtRsdasoLhKKKD2LiSmgkTd911vB7AuXbNxMnxWatfk/nRyb0n/UBgkl
	 CYiKMCGJXDALS6G5I3Q+MesyaRuRzNIIkP5tuphizF/Km/m27NmesvDXhtIbuBS7DVcJbLXa2MIl
	 CiQLi96ZDvt9SVmIRkrcKAay4z5xR2hy5QQ1MbYgMweu1fs4fw7Yk/VOo8UVuac/B1E+tTExWGPI
	 +uTI9LSYpgYjN30cDrPye7r6Q4bCLD4SN9260d1XDf8o5RF4pyIs+VmhKWSLzAFg4bCdKJd8LgaJ
	 ZK3kAr9DC4XomTdyhDPh3mzCmtEURx8+i/K/ijw4p2IgM7L1jby2l7xOWThg6wjyk2BBRt5tmmzW
	 +OTRuip2pKc4CfpQbn2U3wkTJkgzDrogAnvx1QRe+nxzcTiFR5CnM8lgRK8WknE64V0DgbUBQfbp
	 G5yadBWK9NEEBzeqG1JVTYvSWsJBbEK1tuPtTHl9zkU9rsoWgKLJimM4X/f1CDdbQbaCkiO/bLNX
	 FeECp37jYDcbOq6tuFD1kIRUbc2cp7fTr3CosCt3SN+vBBpJ0RAi3jhgChXaiI+vxETUR6QiiysH
	 XlJxaAxw0sjd7KeiM+fhAUswgb/0W+S8t7HzIBbLRMHOw33nE/yAxFY0HU8K9x9qj66rstVFrD+j
	 F7cvquzATuEmbFNMO7EXiAnVDpy3K3xll3FvJ6wE2QYWXpESA/Efkn98dmTb7N73a8F4kPVYglqx
	 MTjLid2HtKR18zmuKOf3G/S+5t3eHzt735wZyWrh3FWWBOjjbvtSFtRIqaJEMKcQbhf77mRrJgTa
	 PAYOksV2sfAYoGRt96xa/Sjon+hr30xL2fonGnMPPacEvG8225R/EYda4hzO0ToPCx7sGJNQ==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: xkeyC <xkeyc@qq.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: Baolin Liu <liubaolin12138@163.com>,
	ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xkeyC <xkeyc@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] ntfs: don't let a fatal signal interrupt metadata reads
Date: Fri, 13 Nov 2026 11:26:15 +0800
X-OQ-MSGID: <20261113032615.21445-1-xkeyc@qq.com>
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
v3:
- Keep the folio reference after the read and recheck uptodate under
  the folio lock, instead of dropping it and looking the folio up again
  (Baolin)

v2:
- Keep reads of named stream contents killable in writes too, and don't
  report -EINTR from them as a volume error (Hyunchul)
- Also convert the mount-time reads of $LogFile, $MFTMirr, hiberfil.sys,
  $AttrDef, $UpCase and $BadClus (Hyunchul)
- Add the missing Fixes tags (Hyunchul)

v2: https://lore.kernel.org/ntfs/tencent_AF42E4D94D935F34EB985032150C6AD0DF08@qq.com/
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

 fs/ntfs/aops.c     | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs/attrib.c   |  2 +-
 fs/ntfs/bdev-io.c  |  2 +-
 fs/ntfs/bitmap.c   |  7 +++---
 fs/ntfs/dir.c      |  4 ++--
 fs/ntfs/inode.c    | 21 +++++++++++++---
 fs/ntfs/lcnalloc.c |  2 +-
 fs/ntfs/logfile.c  |  4 ++--
 fs/ntfs/mft.c      | 20 ++++++++--------
 fs/ntfs/ntfs.h     |  4 ++++
 fs/ntfs/super.c    | 14 +++++------
 11 files changed, 109 insertions(+), 31 deletions(-)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index ad781674fe..f7b5c9c457 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -7,6 +7,7 @@
  * Copyright (c) 2025 LG Electronics Co., Ltd.
  */
 
+#include <linux/swap.h>
 #include <linux/writeback.h>
 
 #include "attrib.h"
@@ -304,6 +305,65 @@ static int ntfs_swap_activate(struct swap_info_struct *sis,
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
+	if (folio_test_uptodate(folio))
+		goto unlock;
+
+	/* ->read_folio() unlocks the folio when the read completes. */
+	err = mapping->a_ops->read_folio(NULL, folio);
+	if (err) {
+		folio_put(folio);
+		if (err == AOP_TRUNCATED_PAGE)
+			goto repeat;
+		return ERR_PTR(err);
+	}
+	folio_lock(folio);
+	if (folio->mapping != mapping) {
+		/* Truncated while the read was in flight. */
+		folio_unlock(folio);
+		folio_put(folio);
+		goto repeat;
+	}
+	if (!folio_test_uptodate(folio)) {
+		folio_unlock(folio);
+		folio_put(folio);
+		return ERR_PTR(-EIO);
+	}
+unlock:
+	folio_unlock(folio);
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

