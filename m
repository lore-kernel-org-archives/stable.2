Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047815;
	b=Q9dUZDIj1pyt4POQgCUtrw+QAQh9izTsG5wC4tRems+wmFx9nXes844bj5M/1VhF81yN
	 NmhdCJmf1M7g522D6/5v7Bhe17/kCbjXEghpnDXiA1KViL/OIZcJeeV9ClBuGAF78nZ2C
	 jBJGLhrk1aOKcg0eqTEPVibAAT4LTv8a7SozAUsIJvSk6q3koEbmo7hEw7Sp/SEncnaPG
	 aXrwavjsTGxU2ZggE6tcSdp9Rc5PiuatVjzCqtYDQvqGgdqIvd2mW259WH3XofneRq9Vw
	 EjcZc+0+LDjVtDl+GEJKAlH09VI8kc13Cltrc2/IOqW/zkegIU4VKlfwzw/Vdsa0DOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047815;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IxdYGpGFtl0ftj0mD9nE16qZjb4bk/bTdFXkLThO4EM=;
	b=5pIUZ0UawuxdjB5Dpgf2b+ysfv6iZFkDko5se19O8eb8dxQq6ahagwi08zL4eBXpexkI
	 XL0swW6DNSRoWN3VRtdyPgEBsp7TFMDejtuA5hc6s+aF569/bUyzgA4yOcEaQuR+WCB7S
	 HYSFOGF1z79tGnoa+N9g4ivyW5MNjCHmDfxlnsGeoBk01JWGDR0Z5WGYXIJG/YDq7jkNz
	 JnVXnGUxbSTkXIJLl4wN3/FBPIofF/4mkSAl/3Gcnf5IQyhXCUqix0GuLD9xHia+12PgT
	 EcSgB3Ot6ZNr6loVzS/6ld3cwroNXxuWi82flYkt4H+/U5Uar6kQ8ftSeSI3aYJASCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOR3dN56;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127FA606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOR3dN56
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2081F0089F;
	Sat,  7 Nov 2026 10:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047814;
	bh=IxdYGpGFtl0ftj0mD9nE16qZjb4bk/bTdFXkLThO4EM=;
	h=From:To:Cc:Subject:Date;
	b=hOR3dN56ooMte+ozIduuO1GtYqttbfEaLcilW38CUhNYVrGg53ekBynf6NPXC0OC2
	 Hd87a/viHHMLt3CNR/N1v0v2y1X/VtOWCVGpmKMsSKcRFxcTsFqdD/fWLcLRyJMXqd
	 Ndkxf8/vyD28k+tfQA36xwLMiEmLcxLSguiUspHfZuNuxtnGRuMFX3jVJOQnQEn4Oe
	 R2I5/gLuPwwPfGuO3wxiq3q1yJjhZBIR9VhM8MVW0B6mir/8ZeRvb9PwJIGRf8K0CC
	 gW2nKB9brt+4wA08s0gQhOwUV8pSYAmXoeNHAoXEsVO/oJnk7ZoITvKeI+1v0RqpH4
	 kJDXu/a5j64Ug==
From: Sasha Levin <sashal@kernel.org>
To: zenghongling@kylinos.cn,
	liubaolin@kylinos.cn,
	hyc.lee@gmail.com,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ntfs: persist the dirty state after the final put_super() commits" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:36:53 -0500
Message-ID: <20261107053653-failed-6.6-5d0e57ea8e37@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5d0e57ea8e37db3e32d1b1b7fa4f3c7a94ff8e56
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053653-failed-6.6-5d0e57ea8e37@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




