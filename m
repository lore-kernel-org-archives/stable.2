Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049743;
	b=ETMFLUqdpeH3iB/G3OJdag7TGb2FaYq0PbacWanNm/ygBcyAyEPhiRxnmRmUQbpAt6oa
	 esAFQH9GsvPX4vjxm50+7Dr6WF8eRy1jUTeCRQeniUy6K+8TpCT6GJHgi1PQjmZkHL/bQ
	 4SfVT+lFuUZ7emqUH8shCKft6D/3qhlDtWz0s4bHiUN7JEgnboCHYax8wIfo1L9Ru8yyk
	 wVRnRlEmfFI6jQZTgVBWqgX1Mn3gmed0FBBCfswU6vIxWK4PXfHcCpGBSyKhZcP6lm2AD
	 kQHpnU2stlBwFxKDKrBc6aSzUnui1sGGon4OCnBgV8jFcXxJEPuSiyfMmNALy0rtnFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049743;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lqpoRLCYSaTDIEyiWwMYQqdRxsXcW+W8c0T1di0Q+Dw=;
	b=VNpsvgFAjQMrkSHENhOTiGtCR7J2xCF3ZpaiVn3rdzbzWNOuCxHRwCrChDEGYcwhHoTK
	 cEiiuJxm0IaYJJu+7MTGcx6V1sW2wH8KaIDZXta7wSJUVMm0eBEsJwrHzhqPLqabIxk7s
	 kcpflxf2owP8DxOHhaaJXJNmRJB1bOuJMrAgZN2ryMxwB6idwBMXejBrwIZxsT4rqcUx1
	 VazpeA/IptYjiM8LZeq98fPG+6ABda9hdfnLxrrLkkukKIw0Yk3pyLGnu7uOcjNV+BKiu
	 JRa+dhPyQkYHNvQmFdL9ehlqeGFmipOLWSift0xYo2HeFmqgpm/h0mFdy9EAQ2uQQLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hhlgORya;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74782606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hhlgORya
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB6F1F008A1;
	Sat,  7 Nov 2026 11:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049743;
	bh=lqpoRLCYSaTDIEyiWwMYQqdRxsXcW+W8c0T1di0Q+Dw=;
	h=From:To:Cc:Subject:Date;
	b=hhlgORyamrfKPn8ptVYxaNjl+p8WbpkGK/rV2poi/qHpCbrov4iAyapSH2w9xfT2e
	 H602YZDV4c9LaHT5/6aJD6DI/VmECAxal/5dYu89qohmA8hSIbCSI05WCajLptz9sC
	 zsdit8WrhvKUvY3pIErBf+d1/DUFDX6QLoWzwsnFSd41ThCUDF+c7b51apX+yab3he
	 H39wu5Wsol/6rjiIEq//fpO833Lsmi4ius3Wjh/iPH2YcPUXv5YzGrS22K/a2XVUkw
	 dD7hwjb2X5U0+mDDhWen5u4H6lcY7ITmdZmdtiad0S6dKMyOlonp9sJGf7yHyrXlsU
	 qP1bCjcbLE+xQ==
From: Sasha Levin <sashal@kernel.org>
To: zenghongling@kylinos.cn,
	liubaolin@kylinos.cn,
	hyc.lee@gmail.com,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ntfs: do not clear the volume dirty bit during sync" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:09:01 -0500
Message-ID: <20261107060901-failed-5.15-4a1bb54f571c@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4a1bb54f571cbef67a7c470a3139ffec1a15a8e4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060901-failed-5.15-4a1bb54f571c@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4a1bb54f571cbef67a7c470a3139ffec1a15a8e4 Mon Sep 17 00:00:00 2001
From: Hongling Zeng <zenghongling@kylinos.cn>
Date: Tue, 15 Sep 2026 16:32:50 +0800
Subject: [PATCH] ntfs: do not clear the volume dirty bit during sync

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
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/file.c  |  7 ++++---
 fs/ntfs/super.c | 31 ++++++++++++++++++++++++-------
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index e8b056c3e4ccd..bb8641103d268 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -637,9 +637,10 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
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
index 42d895776f326..a08523457fe01 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -493,8 +493,9 @@ int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags)
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
@@ -2023,7 +2024,7 @@ static void ntfs_shutdown(struct super_block *sb)
 static int ntfs_sync_fs(struct super_block *sb, int wait)
 {
 	struct ntfs_volume *vol = NTFS_SB(sb);
-	int err = 0;
+	int ret, err = 0;
 
 	if (NVolShutdown(vol))
 		return -EIO;
@@ -2031,14 +2032,30 @@ static int ntfs_sync_fs(struct super_block *sb, int wait)
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
2.53.0




