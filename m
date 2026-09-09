Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F301DA62E;
	Wed,  9 Sep 2026 02:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788920835; cv=none; b=P2pnJCbj/hRnK+8JYEzo7nVtySUrT15Dxo1CMGaegm0dDZBVrN7GlMz3d35SMVXmZIigIDc2YArl8SuYTCpgQ/IKOKIlllwZqTJk2IwhJGhDiyWUqF4w7I7QbAKqawUM8wHYdKMdSAbhqEpQPQS2AIsM5o00nWjH2BmlZpRuiRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788920835; c=relaxed/simple;
	bh=bmAnaO7F0br0vNUtqd6H/oKVkqbumw+uFJC6V1gspa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mbg5U+XT+PipsbulH35jv7IlAJcqBeW5cY4nK090xSNn9/47a4p4KAckkW/R6D2ZQ0YYkMrC+kzdQS+LwBY76Rr97DRrVUXK2Zen/QOQ+LbO/twoYGxkccJ/tKeMxOQFZ65n1EgAWpyPWiXYlkbpn75ntLFkoUAL3w8+GFCgSOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ef4c13c6abf511f19a56ed5b684f684d-20260909
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:845975de-c619-4f91-a8e9-6c9fe0d8ff8b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:99d95d2b6c3c8fcd7b1205693813f57b,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50|99,ED
	M:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ef4c13c6abf511f19a56ed5b684f684d-20260909
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 818436296; Wed, 09 Sep 2026 10:26:59 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 4/4] ntfs: persist the dirty state after the final put_super() commits
Date: Wed,  9 Sep 2026 10:26:52 +0800
Message-Id: <20260909022652.798691-5-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260909022652.798691-1-zenghongling@kylinos.cn>
References: <20260909022652.798691-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The just-in-case mftmirr/mft commits and the final write_inode_now()
in ntfs_put_super() can record NVolErrors() after the dirty state has
been persisted, so errors from those points would leave the volume
unmounted with a clean on-disk dirty bit - contradicting the "cannot
unmount clean" guarantee ntfs_sync_volume_dirty_state() is meant to
provide.

Move the persistence to the end of ntfs_put_super(): keep the gated
re-commits and the tail commits where they are, run
ntfs_sync_volume_dirty_state() and the $Volume commit after the last
write_inode_now(), and move the iput(vol->vol_ino) down so
vol->vol_ino stays available for the sync.

Reported-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/super.c | 52 +++++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 4b4af1ea8b09..b31ea2747f57 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1826,26 +1826,13 @@ static void ntfs_put_super(struct super_block *sb)
 	ntfs_commit_inode(vol->mft_ino);
 
 	/*
-	 * If a read-write mount, persist the error state in the volume flags:
-	 * mark the volume clean if no volume errors have occurred, and make
-	 * sure VOLUME_IS_DIRTY is on disk if any have, so chkdsk runs on the
-	 * next mount.  Also, re-commit all affected inodes.
+	 * If a read-write mount, re-commit all affected inodes once more.
+	 * The dirty state itself is persisted at the end of ntfs_put_super(),
+	 * after the last commits and the final write_inode_now(): those can
+	 * still record errors via __ntfs_write_inode(), and the sync must
+	 * evaluate NVolErrors() with the last setter already run.
 	 */
 	if (!sb_rdonly(sb)) {
-		if (ntfs_sync_volume_dirty_state(vol)) {
-			ntfs_warning(sb,
-				"Failed to sync dirty bit in volume information flags.  Run chkdsk.");
-		} else if (NVolErrors(vol)) {
-			/*
-			 * The dirty bit is on disk now; only warn when the
-			 * sync actually succeeded, or this message would
-			 * contradict the one above.
-			 */
-			ntfs_warning(sb,
-				"Volume has errors.  Leaving volume marked dirty.  Run chkdsk.");
-		}
-		/* Commits the updated volume flags if they were written. */
-		ntfs_commit_inode(vol->vol_ino);
 		if (!NVolErrors(vol)) {
 			ntfs_commit_inode(vol->root_ino);
 			if (vol->mftmirr_ino)
@@ -1854,9 +1841,6 @@ static void ntfs_put_super(struct super_block *sb)
 		}
 	}
 
-	iput(vol->vol_ino);
-	vol->vol_ino = NULL;
-
 	/* NTFS 3.0+ specific clean up. */
 	if (vol->major_ver >= 3) {
 		if (vol->extend_ino) {
@@ -1897,10 +1881,36 @@ static void ntfs_put_super(struct super_block *sb)
 	ntfs_commit_inode(vol->mft_ino);
 	write_inode_now(vol->mft_ino, 1);
 
+	/*
+	 * If a read-write mount, persist the error state in the volume flags:
+	 * mark the volume clean if no volume errors have occurred, and make
+	 * sure VOLUME_IS_DIRTY is on disk if any have, so chkdsk runs on the
+	 * next mount.
+	 */
+	if (!sb_rdonly(sb)) {
+		if (ntfs_sync_volume_dirty_state(vol)) {
+			ntfs_warning(sb,
+				"Failed to sync dirty bit in volume information flags.  Run chkdsk.");
+		} else if (NVolErrors(vol)) {
+			/*
+			 * The dirty bit is on disk now; only warn when the
+			 * sync actually succeeded, or this message would
+			 * contradict the one above.
+			 */
+			ntfs_warning(sb,
+				"Volume has errors.  Leaving volume marked dirty.  Run chkdsk.");
+		}
+		/* Commits the updated volume flags if they were written. */
+		ntfs_commit_inode(vol->vol_ino);
+	}
+
 	iput(vol->mft_ino);
 	vol->mft_ino = NULL;
 	blkdev_issue_flush(sb->s_bdev);
 
+	iput(vol->vol_ino);
+	vol->vol_ino = NULL;
+
 	ntfs_volume_free(vol);
 }
 
-- 
2.25.1

