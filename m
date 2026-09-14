Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C376640EBAE;
	Mon, 14 Sep 2026 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375078; cv=none; b=oKtTS8A9ioAGpmRRjzK/rsvoIpkeKOQyBl7/+5RzAc2RwkWHJ1WDjdsjI+17sp/8oeHv/FGKZEsdMs2qb9jxB/ArHoOqR1PbhTP1TAFpokH2MHUMXgS+3mEbdN6Qji6lnzkw2uzHbnPs8FRXfgh/5UPz8ykKeznGPjJJs/mzffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375078; c=relaxed/simple;
	bh=uptId5k+YVSOOa7XT+eqPnKSj+g74WfcsvXMwKlWOvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/lWjO42003FkVJMI7drPKD0CMgVlPqMh9TgF4pR+qKHEDLWcympA6GI4jUX/Nxk2cFlP4pDWwew0k2FCilQ1CoTvZfzJpwgZjksL/BVYxV03keDcqcDAA9e71FP0ZD3nOJl/3nvccnr7Yo5yuXBFq7qOJFWPMmZJy0Iip82f5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9123ae50b01711f19a56ed5b684f684d-20260914
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:11477c5c-d00e-453e-a9ac-97aa3fd72299,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:a0ae831382883aca66c4dde88da0e75f,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50|99,ED
	M:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9123ae50b01711f19a56ed5b684f684d-20260914
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 535674007; Mon, 14 Sep 2026 16:37:49 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	Baolin Liu <liubaolin@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v12 4/6] ntfs: persist the dirty state after the final put_super() commits
Date: Mon, 14 Sep 2026 16:37:39 +0800
Message-Id: <20260914083741.146689-5-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260914083741.146689-1-zenghongling@kylinos.cn>
References: <20260914083741.146689-1-zenghongling@kylinos.cn>
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
write_inode_now(), and release vol->vol_ino only after the sync.

The release order of the special inodes matters for the $Volume
commit: writing the $Volume record mirrors it through
ntfs_sync_mft_mirror() (record number 3 is below vol->mftmirr_size),
which fails with -EIO and leaves the mirror stale once
vol->mftmirr_ino is gone, so the mirror inode is released only after
that commit.  vol->vol_ino is then put before vol->mft_ino is dropped:
if the commit failed before it could clear the dirty flag,
ntfs_evict_big_inode() commits the inode again on its way out, and
__ntfs_write_inode() resolves the runlist through vol->mft_ino.

Reported-by: Baolin Liu <liubaolin@kylinos.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/super.c | 75 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 23 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 733565953302..3574c224fe28 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1812,26 +1812,13 @@ static void ntfs_put_super(struct super_block *sb)
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
@@ -1840,9 +1827,6 @@ static void ntfs_put_super(struct super_block *sb)
 		}
 	}
 
-	iput(vol->vol_ino);
-	vol->vol_ino = NULL;
-
 	/* NTFS 3.0+ specific clean up. */
 	if (vol->major_ver >= 3) {
 		if (vol->extend_ino) {
@@ -1872,8 +1856,6 @@ static void ntfs_put_super(struct super_block *sb)
 		/* Re-commit the mft mirror and mft just in case. */
 		ntfs_commit_inode(vol->mftmirr_ino);
 		ntfs_commit_inode(vol->mft_ino);
-		iput(vol->mftmirr_ino);
-		vol->mftmirr_ino = NULL;
 	}
 	/*
 	 * We should have no dirty inodes left, due to
@@ -1883,6 +1865,53 @@ static void ntfs_put_super(struct super_block *sb)
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
+		/*
+		 * Commits the updated volume flags if they were written.
+		 * The mft mirror must still be around for this: the
+		 * $Volume record (mft record number 3, below
+		 * vol->mftmirr_size) is mirrored by write_mft_record()
+		 * through ntfs_sync_mft_mirror(), which fails with -EIO
+		 * and leaves the mirror stale once vol->mftmirr_ino is
+		 * gone, so the mirror inode is only released after this
+		 * commit.
+		 */
+		ntfs_commit_inode(vol->vol_ino);
+	}
+
+	/*
+	 * Release $Volume while the mft inode is still available: if the
+	 * commit above failed before it could clear the dirty flag,
+	 * ntfs_evict_big_inode() commits the inode again on its way out,
+	 * and __ntfs_write_inode() needs vol->mft_ino to look up the
+	 * runlist of the record to write.
+	 */
+	iput(vol->vol_ino);
+	vol->vol_ino = NULL;
+
+	if (vol->mftmirr_ino) {
+		iput(vol->mftmirr_ino);
+		vol->mftmirr_ino = NULL;
+	}
+
 	iput(vol->mft_ino);
 	vol->mft_ino = NULL;
 	blkdev_issue_flush(sb->s_bdev);
-- 
2.25.1

