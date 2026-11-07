Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048712;
	b=2Ds6gzVdz+h5pcyQY4ignqfSpxjtkK17n5F45bp6045+n4S5tWAKIb/jN3kTrDWWTMx+
	 NAOS2JcsFsKu9I7KQuy3/HxoM6ZTcE4AnBLP1NJRlJ1VGii24TbZwACtpD6dWfYO15WmS
	 cCCcfWQ4cCiBpmoSj025pnLrePGXQnB+I71hboH3YH+fmoNFXor+n89sVPMfyx7mSnNNv
	 k/s186DEKKsiAY+WI4lTui1TwhGAZjaxd4TdhGXjzD+16TdcGP38d2eGL/7hfKFFGj9LH
	 N9kN57sxtgkm2Lohk9H8kUvQ7P4imxN0+yjlYzKEXUN+skKWA9GHqnW8fShw3YZprJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048712;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vG74RurYR65f0YKHGfbDUz466nI6Y2HjZGnw6YCUrZ4=;
	b=pVS4dzRnWJVl3iQbTY1oAttWuENqRNnz09LRPzzyuUT6BuMHZp/2T3KZ5YQbc3mw98ki
	 lgCCIAJRWQDaWApQxl73nBJsSG71i1tkE8HaLcV+rrOdQcyIXLdijDBAkO3KIYgNxA0HW
	 lXqzyyswkgxCMIeD2f39n1XcES043jhwAzBd1Q2ka82+nChrXuUp1PR10ckfDS6arOBYE
	 CrzDbqB/GQ0vAgNC2JJkJMWQ516ox+EHrM6jN0yFwXEl6W1n/kvaRRMvAesIDE+a7rwi5
	 yAlW/B4H7DOOKic06K66Tr/kC/dqppSLL1Jpy9QhkIL8NGIyMhIC01Vnj+IgpmRObbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvgCDQIC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7BE606A336
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvgCDQIC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC001F0089F;
	Sat,  7 Nov 2026 10:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048711;
	bh=vG74RurYR65f0YKHGfbDUz466nI6Y2HjZGnw6YCUrZ4=;
	h=From:To:Cc:Subject:Date;
	b=QvgCDQICy7fa+ViElB/PkC0G5Iz0vhPf3Yi6abG/j6Fgjc0chnQ642DdbfQHSw9z+
	 SvUIg7CbKXc1P5Fufds0cTqnHwd8IMFjYFc0pUHdmUT5996xq8whJvl7xAb+FIrrN8
	 kShIs/Gk/AUIBWNFuH56EqGkO66trJTQsIc38PXLezS/MvhP7IVvTJ0xf4cysL19Q5
	 MqRN7DtOBYPGc5i9V8GTBTFLID9QiPHrlt6tW5C6BL4j1GMyOTgKNPISHAuwRd/h5i
	 tSpmOL9WVEI5RX/ozu5edE7eI90vv0W8EkZZ3/Vsg1vx6CoyMmYFzSZBW93AGiWiTr
	 iM+8xBXGViAQw==
From: Sasha Levin <sashal@kernel.org>
To: zenghongling@kylinos.cn,
	liubaolin@kylinos.cn,
	hyc.lee@gmail.com,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ntfs: persist the dirty state after the final put_super() commits" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:51:49 -0500
Message-ID: <20261107055149-failed-6.1-5d0e57ea8e37@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5d0e57ea8e37db3e32d1b1b7fa4f3c7a94ff8e56
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055149-failed-6.1-5d0e57ea8e37@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




