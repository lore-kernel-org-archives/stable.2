Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195FA3914EB;
	Thu,  3 Sep 2026 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422101; cv=none; b=HDxgFSv8s/0NfSJx3on24xrW8roWhOKvoHzPZSQK0cWCrPJ0EncULae9s+V5Q8tYCj17KyLrt5yxUKOw+FDcEW31FWN3fXfhtMtmlB+IRwuJfOZYLIleZUCh96jkRAIWtw3AZaGhTJOLhBwpo27i5iyMhcM1IXYgoT2+FN/UoW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422101; c=relaxed/simple;
	bh=aX1V6/Vf49zCxLk0qjqYwyFQGUoFQFsAs2MfTn/CB3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ecHeKiEvhXXcXZHfiIWQA/libTolFjTujLmqd3Js6dqeOt6/F1zUDaLz5pypSZWTJbVyUzYdQ5YnrhLVeHZwUyeVLEjtCuuOOGXyazrYt9axW6HIOGiAXxSyeMkCQY6qB6GRl3VHMTVSjfCsQZczt+2KI8v4MzRL3/yXV79qMF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b9c09750a76c11f19a56ed5b684f684d-20260903
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:701721f6-5a94-48dd-965d-55a3b168d771,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:3f1299b84efbc4b4c71b09b315255d74,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b9c09750a76c11f19a56ed5b684f684d-20260903
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1247535226; Thu, 03 Sep 2026 15:54:43 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] ntfs: add helper to record error flag before setting volume dirty bit
Date: Thu,  3 Sep 2026 15:54:37 +0800
Message-Id: <20260903075438.306793-2-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260903075438.306793-1-zenghongling@kylinos.cn>
References: <20260903075438.306793-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The runtime metadata-corruption paths in fs/ntfs record the error flag
with a bare NVolSetErrors() and separately rely on ntfs_set_volume_flags()
or nothing at all to persist VOLUME_IS_DIRTY.  Since the clear side
(ntfs_sync_fs() via ntfs_clear_volume_dirty_if_no_errors()) evaluates
NVolErrors() under ni->mrec_lock, a writer that records the error flag
after the lock has been checked leaves a window in which the volume ends
up persisted as clean despite the recorded error, so chkdsk will not run
on the next mount and corrupted metadata can persist.

Introduce ntfs_mark_volume_dirty_with_error(), which records the error
flag before the locked dirty-bit write: the mutex acquire/release in
ntfs_write_volume_flags() then provides the ordering, as any clear path
running after us can only evaluate NVolErrors() under the lock once the
flag is set.

On a read-only mount or before the $Volume inode has been loaded, the
helper only records the in-memory error state because the dirty bit
cannot be persisted.  On a writable volume it waits for the lock instead
of silently dropping the dirty-bit update, and propagates any write
error to the caller.

Waiting is safe: the $Volume mrec_lock is a leaf lock.  Its critical
sections only look up and update the resident volume information
attribute and never acquire the locks the callers hold (lcnbmp_lock,
runlist locks), so no lock cycle exists.  To make that explicit to the
lock validator, give the $Volume inode its own mrec_lock class, the
same way $MFTMirr already gets one; otherwise the lockdep class shared
with regular file inodes would report an inversion for the
lcnbmp_lock -> $Volume mrec_lock ordering that the helper introduces,
even though no deadlock is possible.

Mount and remount paths remain serialized by sb->s_umount and keep
using NVolSetErrors() directly, since they do not race with
ntfs_sync_fs() and may not be allowed to write the volume: before
$Volume is loaded, with a read-only opened bdev, or on a hibernated
volume, which we must not write to at all.  The same applies to the
ntfs_attr_lookup() failure paths and the mft record writeback paths,
which hold a caller's mrec_lock and would self-deadlock the helper on
the $Volume inode.

Converting the runtime metadata-corruption call sites in mft.c,
lcnalloc.c, bitmap.c, inode.c and attrib.c to use the helper is done
in the next patch.

Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/ntfs.h  |  1 +
 fs/ntfs/super.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
index df5a75d506f6..63d7900b6dba 100644
--- a/fs/ntfs/ntfs.h
+++ b/fs/ntfs/ntfs.h
@@ -222,6 +222,7 @@ struct option_t {
 extern const struct option_t on_errors_arr[];
 int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags);
 int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags);
+int ntfs_mark_volume_dirty_with_error(struct ntfs_volume *vol);
 int ntfs_write_volume_label(struct ntfs_volume *vol, char *label);
 
 /* From fs/ntfs/mst.c */
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index a7977b95b967..64f8d4469af3 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -454,6 +454,45 @@ int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags)
 	return ntfs_write_volume_flags(vol, 0, flags, false);
 }
 
+/*
+ * ntfs_mark_volume_dirty_with_error - record an error and mark volume dirty
+ * @vol:	ntfs volume on which an error has been recorded
+ *
+ * To be called when runtime metadata corruption is detected so that chkdsk
+ * runs on the next mount.  NVolErrors() is recorded first, so the in-memory
+ * error state is kept even when the dirty bit cannot be persisted; the
+ * mutex acquire/release in ntfs_write_volume_flags() then provides the
+ * ordering against ntfs_clear_volume_dirty_if_no_errors(), which checks
+ * the flag under the same lock.
+ *
+ * On a read-only mount or before the $Volume inode has been loaded, it
+ * only records the in-memory error state because the dirty bit cannot be
+ * persisted.  On a writable volume it waits for the lock instead of
+ * silently dropping the dirty-bit update, and propagates any write error
+ * to the caller.
+ *
+ * Only for runtime error paths that can race sync and hold no mrec_lock.
+ * The $Volume mrec_lock is a leaf lock: its critical sections never
+ * acquire the locks those paths hold (lcnbmp_lock, runlist locks), so
+ * blocking here cannot deadlock.  Do not call while holding the $Volume
+ * mrec_lock itself (ntfs_attr_lookup() failure and mft writeback paths),
+ * on mount/remount paths (serialized by sb->s_umount, keep using
+ * NVolSetErrors()), or on volumes we must not write to, such as
+ * hibernated ones.
+ *
+ * Return 0 on success and -errno on error.
+ */
+int ntfs_mark_volume_dirty_with_error(struct ntfs_volume *vol)
+{
+	NVolSetErrors(vol);
+
+	/* Nothing to persist on a read-only or still-mounting volume. */
+	if (!vol->vol_ino || sb_rdonly(vol->sb))
+		return 0;
+
+	return ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+}
+
 /*
  * ntfs_clear_volume_dirty_if_no_errors - clear dirty bit if no errors exist
  * @vol:	ntfs volume whose dirty bit should be cleared
@@ -918,7 +957,8 @@ static void ntfs_setup_allocators(struct ntfs_volume *vol)
 }
 
 static struct lock_class_key mftmirr_runlist_lock_key,
-			     mftmirr_mrec_lock_key;
+			     mftmirr_mrec_lock_key,
+			     volume_mrec_lock_key;
 /*
  * load_and_init_mft_mirror - load and setup the mft mirror inode for a volume
  * @vol:	ntfs super block describing device whose mft mirror to load
@@ -1502,6 +1542,15 @@ static bool load_system_files(struct ntfs_volume *vol)
 		ntfs_error(sb, "Failed to load $Volume.");
 		goto iput_lcnbmp_err_out;
 	}
+	/*
+	 * Give the $Volume inode its own mrec_lock class: the error paths
+	 * take it while holding locks (lcnbmp_lock, runlist locks) that
+	 * nest inside mrec_lock elsewhere in the driver, and the lock
+	 * validator would otherwise see that as an inversion even though
+	 * the $Volume critical sections never acquire those locks.
+	 */
+	lockdep_set_class(&NTFS_I(vol->vol_ino)->mrec_lock,
+			  &volume_mrec_lock_key);
 	m = map_mft_record(NTFS_I(vol->vol_ino));
 	if (IS_ERR(m)) {
 iput_volume_failed:
-- 
2.25.1

