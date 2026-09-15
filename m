Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA94B4779A8;
	Tue, 15 Sep 2026 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461189; cv=none; b=ia1IJWDE34KDq9E5o5XiyiiUfBuPQm89f9JmOQI8TqU8UJaScjZfFPGdHJViVAnPAkNTQeBTpIaHTjP+QGYCnjPV3yAyC7fn5BDJ6b0S9VywbZicvsql82ejtjAPj2YIRtVTY2HaPT3nMbwQepitGMbfZSKtrtYOaeQLMRstgHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461189; c=relaxed/simple;
	bh=NnznJM9rr0VkukETqdSVD6fqwodHLDPuYDL1DGyN704=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fsaZiT4132+4SC6f/Ii7d80xn8LTPUoJZ91n4d4C0J/2CpQS4FWnOaQJLiFC3W9IAFB9rFn2YhZBN9VjhlRwKYmMqSVuv9fMvARy8SAIkcLmW+a6ZlKO2yHeZqyCqShPjJfl6G/RyM+ltQd51/M+0geqqFYvLLmy8q3wZ5oPa0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0fc9a110b0e011f19a56ed5b684f684d-20260915
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:c26330cd-db19-4233-b287-a6abf0d00313,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:c353a45abad57fe56ed8692e727afc35,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50|99,ED
	M:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0fc9a110b0e011f19a56ed5b684f684d-20260915
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 712537831; Tue, 15 Sep 2026 16:33:00 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	Baolin Liu <liubaolin@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v13 5/7] ntfs: do not clear the volume dirty bit during sync
Date: Tue, 15 Sep 2026 16:32:50 +0800
Message-Id: <20260915083252.812126-6-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260915083252.812126-1-zenghongling@kylinos.cn>
References: <20260915083252.812126-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_sync_fs() clears VOLUME_IS_DIRTY while the volume is still mounted
read-write, so a sync running concurrently with an in-flight metadata
modification can clear and persist a bit that was just set: the
modification then lands on a volume that is clean on disk, and a crash
does not run chkdsk.

Stop clearing the bit in ntfs_sync_fs() and leave the clearing to the
remount-to-read-only path, which the VFS reaches only after
sb_prepare_remount_readonly() has drained in-flight writers, and to
ntfs_put_super(), which runs after evict_inodes() on a quiesced
filesystem.  A mounted read-write volume now keeps the dirty bit until
it is dismounted cleanly, which matches the NTFS semantics; the cost is
a needless chkdsk if the machine crashes between a sync and the unmount.

A recorded error state is still persisted right away when the
filesystem is synced: with NVolErrors() set,
ntfs_sync_volume_dirty_state() can only set the bit, never clear it,
so it cannot lose a modification the way the old unconditional call
did.  This keeps the error report from being lost to a crash on a
volume that has seen no modification; an error recorded after the
last sync is still only persisted at the next quiescent transition.

sync_blockdev() and blkdev_issue_flush() are both called and the first
error is returned, so a writeback failure neither hides a flush failure
nor skips it.

A RWF_NOWAIT write still blocks in the marking when the volume looks
clean, as it already did on the base; a non-blocking marking is
follow-up work.

Reported-by: Baolin Liu <liubaolin@kylinos.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/file.c  |  7 ++++---
 fs/ntfs/super.c | 31 ++++++++++++++++++++++++-------
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index cfc7b36b7dff..99a2c7a5cf81 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -621,9 +621,10 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	/*
 	 * The volume must be marked dirty before the modification is made,
-	 * without an unlocked check of the in-memory flag: ntfs_sync_fs()
-	 * can clear the bit concurrently and the modification would then
-	 * land on a volume that is clean on disk.
+	 * without an unlocked check of the in-memory flag: the dirty bit
+	 * is only cleared at the quiescent transitions, under the same
+	 * $Volume mrec_lock this call takes, so an unlocked skip could
+	 * lose the set to one of them.
 	 */
 	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 3574c224fe28..463050ae1b0e 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -486,8 +486,9 @@ int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags)
  * This is the single point that persists the in-memory error state to disk.
  * The runtime error paths only record NVolErrors() because they run under a
  * variety of ntfs locks the dirty-bit write cannot be taken under (runlist
- * locks, vol->lcnbmp_lock, vol->mftbmp_lock, mrec_locks); the first
- * ntfs_sync_fs(), a remount, or the unmount then persists the flag here.
+ * locks, vol->lcnbmp_lock, vol->mftbmp_lock, mrec_locks); a sync of a
+ * volume with recorded errors, a remount to read-only, or the unmount,
+ * then persists the flag here.
  *
  * A hibernated volume is not written from these persistence paths:
  * resuming Windows from a modified image corrupts it, so the dirty bit
@@ -1955,7 +1956,7 @@ static void ntfs_shutdown(struct super_block *sb)
 static int ntfs_sync_fs(struct super_block *sb, int wait)
 {
 	struct ntfs_volume *vol = NTFS_SB(sb);
-	int err = 0;
+	int ret, err = 0;
 
 	if (NVolShutdown(vol))
 		return -EIO;
@@ -1963,14 +1964,30 @@ static int ntfs_sync_fs(struct super_block *sb, int wait)
 	if (!wait)
 		return 0;
 
-	/* If there are some dirty buffers in the bdev inode */
-	if (ntfs_sync_volume_dirty_state(vol)) {
+	/*
+	 * The volume dirty bit is deliberately not cleared here: a sync
+	 * running concurrently with an in-flight modification could clear
+	 * and persist a bit that was just set, leaving the modification
+	 * on a volume that is clean on disk.  The bit is only cleared at
+	 * the quiescent state transitions, remounting read-only and clean
+	 * unmount.  A recorded error state, however, is persisted right
+	 * away so that it is not lost to a crash on a volume that has
+	 * seen no modification; with NVolErrors() set this can only set
+	 * the bit, never clear it.
+	 */
+	if (NVolErrors(vol) &&
+	    ntfs_sync_volume_dirty_state(vol)) {
 		ntfs_warning(sb, "Failed to sync dirty bit in volume information flags.  Run chkdsk.");
 		err = -EIO;
 	}
 	sync_inodes_sb(sb);
-	sync_blockdev(sb->s_bdev);
-	blkdev_issue_flush(sb->s_bdev);
+	ret = sync_blockdev(sb->s_bdev);
+	if (ret && !err)
+		err = ret;
+
+	ret = blkdev_issue_flush(sb->s_bdev);
+	if (ret && !err)
+		err = ret;
 	return err;
 }
 
-- 
2.25.1

