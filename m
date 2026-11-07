Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050746;
	b=Ohbn9kjvYKYRZ0MErZwWmM7VqhEuDzkeInyerTTzRkgQ32dWIWq63tUvM08LFyM1C9K2
	 j5xdFmTUaF1z7hkLB4GffF7fEAtWFWtxLBIRixiF2YSerzn1IDG5yMKgYApa3RJQ8KvT1
	 zr197SfKSTWJXwr+kvM6glwVYlAfSTAPJNSjDNSsNISKqcEphgEpdbCYf+w9dWMFVFVLD
	 XbTEXm+1bAt4ik7zoPURCBrFaO4SxTZ0mPWB4TayCmC+XqPjQ0r+DmVw7m4no+UxkyeUY
	 72NlYWu6KdASsY/+VI0JE5+3qvRxdT4gwxYoqkMywWqHmZvGmr9OvPJNGcq4kCazcDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050746;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FL5j36PmGyF5dh6ftzLkJQLqQcnSWdDBlQXL4sExJuc=;
	b=5WBM/mRNy0InNNQnMRc6wU1VrJXCJGJ+4OKjuPxnsUtNz6hCmM2FFMNCEJlEGfjua1HB
	 kXpmQnvyktCqQlc1HWcgILs/D8KJpkUE/aaRNOHi93JR0XW2dj7ZYnGBgqBZBgydS5lr2
	 wMMTjNTsaNqsXtq8dg3V1Fm0SznO+RFKth09WtoOfv+DAqCqjBigX0tXDnXrS/7/ihwry
	 34qn1WxP6NXCKOviheVATgTN+oHkTtX2A68xXo88wUyjPcVJEPsGeUS8Muk8RdlMUsHsr
	 oO3XRjiySayB99obnD8lm06mchFI+W6ObNfM2YfLSP299c0hCWaqV3eZUJ/oa1XI3Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PcFSLt1u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE526606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PcFSLt1u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417881F0089F;
	Sat,  7 Nov 2026 11:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050745;
	bh=FL5j36PmGyF5dh6ftzLkJQLqQcnSWdDBlQXL4sExJuc=;
	h=From:To:Cc:Subject:Date;
	b=PcFSLt1uAiljbItwXOz5iRpCcMbjHdCO3yj2amIK8sIJ9iCwImPREVeMfgwN8zibN
	 6k9E9j2OWbNeRc3MzioPVDVVsA90htRnEsHj7APDSCKsV8ryk7EVpXsvFKKxDyDmLB
	 el2DWS8MaBm7nPZUGX+35o8JbQhsMG/Mx3lrKlL1fy90foXPxdvUxdpg3CVAxBNZEo
	 djf5rqBWWpFCqmtSt46j0pkywB1yI4AFEThWoiDO/khPtr83bJ771nvujvUb3LlTLC
	 BZOM6Wc/DXUI/U+R8fpd2O7MCUjrSS2eUoYpKC/jk1qELpV1Yt6cMlrxWGKCxNYEcH
	 2Jx0ikInU9J+Q==
From: Sasha Levin <sashal@kernel.org>
To: zenghongling@kylinos.cn,
	liubaolin@kylinos.cn,
	hyc.lee@gmail.com,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ntfs: persist the dirty state after the final put_super() commits" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:25:44 -0500
Message-ID: <20261107062543-failed-5.10-5d0e57ea8e37@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5d0e57ea8e37db3e32d1b1b7fa4f3c7a94ff8e56
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062543-failed-5.10-5d0e57ea8e37@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5d0e57ea8e37db3e32d1b1b7fa4f3c7a94ff8e56 Mon Sep 17 00:00:00 2001
From: Hongling Zeng <zenghongling@kylinos.cn>
Date: Tue, 15 Sep 2026 16:32:49 +0800
Subject: [PATCH] ntfs: persist the dirty state after the final put_super()
 commits

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
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/super.c | 75 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 23 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 785f5b2222934..42d895776f326 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1880,26 +1880,13 @@ static void ntfs_put_super(struct super_block *sb)
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
@@ -1908,9 +1895,6 @@ static void ntfs_put_super(struct super_block *sb)
 		}
 	}
 
-	iput(vol->vol_ino);
-	vol->vol_ino = NULL;
-
 	/* NTFS 3.0+ specific clean up. */
 	if (vol->major_ver >= 3) {
 		if (vol->extend_ino) {
@@ -1940,8 +1924,6 @@ static void ntfs_put_super(struct super_block *sb)
 		/* Re-commit the mft mirror and mft just in case. */
 		ntfs_commit_inode(vol->mftmirr_ino);
 		ntfs_commit_inode(vol->mft_ino);
-		iput(vol->mftmirr_ino);
-		vol->mftmirr_ino = NULL;
 	}
 	/*
 	 * We should have no dirty inodes left, due to
@@ -1951,6 +1933,53 @@ static void ntfs_put_super(struct super_block *sb)
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
2.53.0




