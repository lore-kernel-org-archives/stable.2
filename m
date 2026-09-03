Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238F6397933;
	Thu,  3 Sep 2026 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422097; cv=none; b=g0k0DpTxyRXlduDnZfF1x4SkMWR6q0bcq9zN2XEPQmgxcWX2Bt2A0RWmiC4QH+/4WccAkgSNX7Ozr512jiJwiXQGY9ISE/ymHzAFjsCBgFEDmCCYz0yo0Mw8nn54IGG7lh9EfxzUzUFAwBpcciGpFXVDrmnvfxAtuKAoaqaGiPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422097; c=relaxed/simple;
	bh=hxhngAuDx8GSokc6rP4LurdJaNYN0GNhcknj23j6Gkw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n7vi8/BrOTSDq1liTKeL165xjYsWftA1gPojDkcA7W7CuAAJ6e4Fo+837WiDpW4dHPvqJPwYPmOQilarnA2KLZe7Nw0JqxgVwNbzLNT0wZ6szbZk7gcSI88dmSXrS/Qlmy4fAuo17kjT+HTfbt3PIoRmUar7kEMXdQNSI95+DCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b9637e76a76c11f19a56ed5b684f684d-20260903
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:6d97758a-eaf8-4add-97d3-c86c06cb0074,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:92a878cece5ccbfd7dbe8a35f3c3a7ba,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50,EDM:-3|
	-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b9637e76a76c11f19a56ed5b684f684d-20260903
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 841964489; Thu, 03 Sep 2026 15:54:43 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] ntfs: fix volume flag update races
Date: Thu,  3 Sep 2026 15:54:36 +0800
Message-Id: <20260903075438.306793-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_set_volume_flags() and ntfs_clear_volume_flags() both read
vol->vol_flags outside any lock to compute the new value before handing
it to ntfs_write_volume_flags(), which only takes ni->mrec_lock around
the actual write. The read-modify-write is therefore not atomic, and two
concurrent callers can lose an update: ntfs_sync_fs() may derive a
"clean" value from vol->vol_flags while a writer concurrently records an
error and sets VOLUME_IS_DIRTY; the locked write then silently
overwrites the freshly-set dirty bit. The on-disk volume looks clean
despite the recorded errors, so chkdsk will not run on the next mount
and corrupted metadata can persist.

Fix by moving the read-modify-write inside the mrec_lock: pass the bits
to set and to clear separately, and combine them with the current flag
state under the lock inside ntfs_write_volume_flags(). The set/clear
helpers pass only the bits to modify, not the complete flag state. The
bit manipulation is done on CPU-endian values, and the result is
converted back to little-endian before storing it. The wrappers keep
their signatures so callers are unchanged.

Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
- Also fix the ntfs_sync_fs() race by checking NVolErrors() and clearing
  VOLUME_IS_DIRTY under ni->mrec_lock.
- Keep ntfs_set_volume_flags() and ntfs_clear_volume_flags() semantics
  unchanged.
- Do not tie setting VOLUME_IS_DIRTY to NVolSetErrors() in the generic
  set helper.
---
 fs/ntfs/super.c | 62 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index a1813093222b..a7977b95b967 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -353,31 +353,45 @@ void ntfs_handle_error(struct super_block *sb)
 }
 
 /*
- * ntfs_write_volume_flags - write new flags to the volume information flags
+ * ntfs_write_volume_flags - apply flag changes to the volume information flags
  * @vol:	ntfs volume on which to modify the flags
- * @flags:	new flags value for the volume information flags
+ * @set_bits:	bits to set in the volume information flags
+ * @clear_bits:	bits to clear in the volume information flags
  *
  * Internal function.  You probably want to use ntfs_{set,clear}_volume_flags()
  * instead (see below).
  *
- * Replace the volume information flags on the volume @vol with the value
- * supplied in @flags.  Note, this overwrites the volume information flags, so
- * make sure to combine the flags you want to modify with the old flags and use
- * the result when calling ntfs_write_volume_flags().
+ * Combine @set_bits and @clear_bits with the current in-memory flag state and
+ * write the result back.  The set/clear helpers pass only the bits to modify,
+ * not the complete flag state.  The read-modify-write happens under
+ * ni->mrec_lock so that concurrent set/clear operations cannot lose updates.
+ * All bit manipulation is done on CPU-endian values, and the result is
+ * converted back to little-endian before storing it.
  *
  * Return 0 on success and -errno on error.
  */
-static int ntfs_write_volume_flags(struct ntfs_volume *vol, const __le16 flags)
+static int ntfs_write_volume_flags(struct ntfs_volume *vol,
+		const __le16 set_bits, const __le16 clear_bits,
+		const bool skip_if_errors)
 {
 	struct ntfs_inode *ni = NTFS_I(vol->vol_ino);
 	struct volume_information *vi;
 	struct ntfs_attr_search_ctx *ctx;
+	u16 flags;
 	int err;
 
-	ntfs_debug("Entering, old flags = 0x%x, new flags = 0x%x.",
-			le16_to_cpu(vol->vol_flags), le16_to_cpu(flags));
 	mutex_lock(&ni->mrec_lock);
-	if (vol->vol_flags == flags)
+
+	if (skip_if_errors && NVolErrors(vol))
+		goto done;
+
+	flags = le16_to_cpu(vol->vol_flags);
+	flags |= le16_to_cpu(set_bits) & le16_to_cpu(VOLUME_FLAGS_MASK);
+	flags &= ~(le16_to_cpu(clear_bits) & le16_to_cpu(VOLUME_FLAGS_MASK));
+	ntfs_debug("Entering, old flags = 0x%x, new flags = 0x%x.",
+			le16_to_cpu(vol->vol_flags), flags);
+
+	if (le16_to_cpu(vol->vol_flags) == flags)
 		goto done;
 
 	ctx = ntfs_attr_get_search_ctx(ni, NULL);
@@ -393,7 +407,7 @@ static int ntfs_write_volume_flags(struct ntfs_volume *vol, const __le16 flags)
 
 	vi = (struct volume_information *)((u8 *)ctx->attr +
 			le16_to_cpu(ctx->attr->data.resident.value_offset));
-	vol->vol_flags = vi->flags = flags;
+	vol->vol_flags = vi->flags = cpu_to_le16(flags);
 	mark_mft_record_dirty(ctx->ntfs_ino);
 	ntfs_attr_put_search_ctx(ctx);
 done:
@@ -414,13 +428,14 @@ static int ntfs_write_volume_flags(struct ntfs_volume *vol, const __le16 flags)
  * @flags:	flags to set on the volume
  *
  * Set the bits in @flags in the volume information flags on the volume @vol.
+ * The bits are combined with the current flag state under the lock in
+ * ntfs_write_volume_flags(), so concurrent updates are not lost.
  *
  * Return 0 on success and -errno on error.
  */
 int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags)
 {
-	flags &= VOLUME_FLAGS_MASK;
-	return ntfs_write_volume_flags(vol, vol->vol_flags | flags);
+	return ntfs_write_volume_flags(vol, flags, 0, false);
 }
 
 /*
@@ -429,14 +444,27 @@ int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags)
  * @flags:	flags to clear on the volume
  *
  * Clear the bits in @flags in the volume information flags on the volume @vol.
+ * The bits are combined with the current flag state under the lock in
+ * ntfs_write_volume_flags(), so concurrent updates are not lost.
  *
  * Return 0 on success and -errno on error.
  */
 int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags)
 {
-	flags &= VOLUME_FLAGS_MASK;
-	flags = vol->vol_flags & cpu_to_le16(~le16_to_cpu(flags));
-	return ntfs_write_volume_flags(vol, flags);
+	return ntfs_write_volume_flags(vol, 0, flags, false);
+}
+
+/*
+ * ntfs_clear_volume_dirty_if_no_errors - clear dirty bit if no errors exist
+ * @vol:	ntfs volume whose dirty bit should be cleared
+ *
+ * Check NVolErrors() and clear VOLUME_IS_DIRTY under the same mrec_lock so
+ * ntfs_sync_fs() cannot clear the dirty bit after a concurrent error has been
+ * recorded.
+ */
+static int ntfs_clear_volume_dirty_if_no_errors(struct ntfs_volume *vol)
+{
+	return ntfs_write_volume_flags(vol, 0, VOLUME_IS_DIRTY, true);
 }
 
 int ntfs_write_volume_label(struct ntfs_volume *vol, char *label)
@@ -1862,7 +1890,7 @@ static int ntfs_sync_fs(struct super_block *sb, int wait)
 		return 0;
 
 	/* If there are some dirty buffers in the bdev inode */
-	if (ntfs_clear_volume_flags(vol, VOLUME_IS_DIRTY)) {
+	if (ntfs_clear_volume_dirty_if_no_errors(vol)) {
 		ntfs_warning(sb, "Failed to clear dirty bit in volume information flags.  Run chkdsk.");
 		err = -EIO;
 	}
-- 
2.25.1

