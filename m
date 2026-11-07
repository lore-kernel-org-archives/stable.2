Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046381;
	b=rdMXoegu+8zlgJoLKMt4rSW0fRWOk/VcS5T7ECI161J5hKURJzNO2Rhb5cTfHDtN4Kgr
	 GcgjOySab7ld8NfIGbUOUh1RywxFXQQONgZSoplkSyy5IAyw7YqNNQ8ejPUWDoflFizvY
	 6OTwYQSU5IutH6kG8KjDMth2WcSYl22JnaqknP2b1HhVa6zl7cMyZHsEeczr6BpcUxxyb
	 of8VTE8i5HelaEVJkWUzpQIo+vWp4dFZBUev2ndmfTrOW9zIbfLo7mQUGV5y9JdnRLkdU
	 gw08UrXljSU3PSTos8N16/CfPMwa4zlyHpwAGP3wZSw3gvF0wFoZ2GUGdnY2tuvpUGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046381;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Cc06O/YIRdBM7CApsMho5ZJ2cd/dtrh0K1uXTXwApjE=;
	b=K/vx3NA5opeKTtf9B25fd/LZ/qiXiuYFT0+LstJzr8utt6s3+VRRS/FR05bsIy1ZG71W
	 j4xkAjlQ994Nbb9NKZ7G4snJ0bXSsqLCKJZzovcWMRO3XYfOKdbXEs7MhroZW+3aK3DN5
	 zm8SsdANV1I0loOosMy2VSj+K2C2a0jSyEckfumLuJg6Yo2PHXxiIaU0v9PVt+opFl9i4
	 tmXGCWkcbkH39lXVb7x0Nt0LqU2wwJa8qpntLM4WrOGVysVkXmuON82jmLl67Dd3XkYOa
	 p0mpsgNZ88f5LISyn1aq4odBlPwScp8LxSr/Y1SLnaPR9f2iWjF/lNKljf0q+bUsuiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vg1EqwJz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF8B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vg1EqwJz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DECA1F0089F;
	Sat,  7 Nov 2026 10:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046380;
	bh=Cc06O/YIRdBM7CApsMho5ZJ2cd/dtrh0K1uXTXwApjE=;
	h=From:To:Cc:Subject:Date;
	b=Vg1EqwJz0torep5MbAFWsWzCqTTvz4hVejlfZwJ8KR9fkaMnCM2rlSKC07/8PrcAw
	 GGG3T595KMtlaM281yf8P37PhaO5SUbXRB7STo73t/cfEneucnxPZQsFf2ZYYqe91R
	 datyICYodQ5UMDYNgwYuGKui3TZEwkLZVskcpcn0oQLivg/eqJldMWzuXaF/6anDHW
	 Y0NtxfNl20YD0iCUlnDQP0rxM7NrL0fsR1dbWwTctNFC98GJ6qlSNbawJqL7ruUqEd
	 zNrk2+SGhs9o48Jyq12JrDXzgp8MqKRy5kvZQkrmsskyqzYjFNAEEQKD7eTeViGVI2
	 BaD39pHwIuB/g==
From: Sasha Levin <sashal@kernel.org>
To: zenghongling@kylinos.cn,
	liubaolin@kylinos.cn,
	hyc.lee@gmail.com,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ntfs: check the dirty-state commit on remount and unmount" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:12:58 -0500
Message-ID: <20261107051258-failed-6.18-1a3883b3685c@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 1a3883b3685cc4c8bc41927cc9df539239d7c961
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051258-failed-6.18-1a3883b3685c@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1a3883b3685cc4c8bc41927cc9df539239d7c961 Mon Sep 17 00:00:00 2001
From: Hongling Zeng <zenghongling@kylinos.cn>
Date: Tue, 15 Sep 2026 16:32:51 +0800
Subject: [PATCH] ntfs: check the dirty-state commit on remount and unmount

The remount-to-read-only path commits the updated volume flags with
ntfs_commit_inode(), a void wrapper around __ntfs_write_inode(), and
ignores the blkdev_issue_flush() return value, so a failed commit or
flush is reported as success.  Once the remount has succeeded no
persistence point is ever reached again: ntfs_put_super() skips
read-only superblocks and the VFS never syncs one, so fail the
remount unless the commit and the flush succeed.  The superblock
then stays read-write and ntfs_put_super() retries the persistence
at unmount.  The errors=remount-ro downgrade does not go through
ntfs_reconfigure() and is unchanged.

A zero-return commit is not trusted blindly: write_mft_record()
redirties the record on allocation failure and reports success, so
the $Volume inode is required to be clean afterwards.

ntfs_put_super() discards the same commit error.  Call
__ntfs_write_inode() there with the same dirty re-check and warn on
failure, as put_super() cannot return an error.  The commit is
skipped when the dirty-state sync itself failed, as that could write
back an inconsistent flag state; a record left dirty by an earlier
update is still committed at evict time.

NVolErrors() is deliberately not used to detect the failure: it is
sticky for the lifetime of the mount, so it cannot distinguish a
fresh commit failure from errors recorded before the remount.

Hibernated volumes: ntfs_sync_volume_dirty_state() is a no-op for
them and never dirties the $Volume inode on such a mount, since the
on-disk flags are already dirty and ntfs_set_volume_flags() has
nothing to change.  The commit only runs if something dirtied the
inode independently, as before this patch; mounting hibernated
volumes read-only removes even that.

Reported-by: Baolin Liu <liubaolin@kylinos.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/super.c | 76 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 22 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index a08523457fe01..0ec4d2ddf6219 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -269,6 +269,7 @@ static int ntfs_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
 	struct ntfs_volume *vol = NTFS_SB(sb);
+	int err;
 
 	ntfs_debug("Entering with remount");
 
@@ -331,14 +332,39 @@ static int ntfs_reconfigure(struct fs_context *fc)
 		 * and ntfs_put_super() skips them, so the only remaining
 		 * write would be the evict-time commit at unmount, which
 		 * a crash never reaches.  An error recorded only after
-		 * the remount is still never persisted.
+		 * the remount is still never persisted; a failed commit
+		 * or flush fails the remount, leaving the superblock
+		 * read-write so ntfs_put_super() retries at unmount.
 		 */
-		if (ntfs_sync_volume_dirty_state(vol)) {
+		err = ntfs_sync_volume_dirty_state(vol);
+		if (err) {
 			ntfs_warning(sb,
 				"Failed to update dirty bit in volume information flags.  Run chkdsk.");
-		} else if (NInoDirty(NTFS_I(vol->vol_ino))) {
-			ntfs_commit_inode(vol->vol_ino);
-			blkdev_issue_flush(sb->s_bdev);
+			return err;
+		}
+		if (NInoDirty(NTFS_I(vol->vol_ino))) {
+			/* ntfs_commit_inode() would discard the error. */
+			err = __ntfs_write_inode(vol->vol_ino, 1);
+			if (err) {
+				ntfs_warning(sb,
+					"Failed to commit volume information flags.  Run chkdsk.");
+				return err;
+			}
+			/*
+			 * write_mft_record() redirties the record on
+			 * -ENOMEM and still reports success.
+			 */
+			if (NInoDirty(NTFS_I(vol->vol_ino))) {
+				ntfs_warning(sb,
+					"Volume information flags remain dirty after commit.  Run chkdsk.");
+				return -EIO;
+			}
+			err = blkdev_issue_flush(sb->s_bdev);
+			if (err) {
+				ntfs_warning(sb,
+					"Failed to flush volume information flags.  Run chkdsk.");
+				return err;
+			}
 		}
 	}
 
@@ -1944,26 +1970,32 @@ static void ntfs_put_super(struct super_block *sb)
 		if (ntfs_sync_volume_dirty_state(vol)) {
 			ntfs_warning(sb,
 				"Failed to sync dirty bit in volume information flags.  Run chkdsk.");
-		} else if (NVolErrors(vol)) {
+		} else {
 			/*
-			 * The dirty bit is on disk now; only warn when the
-			 * sync actually succeeded, or this message would
-			 * contradict the one above.
+			 * __ntfs_write_inode(), not the void
+			 * ntfs_commit_inode() wrapper: the error can only
+			 * be warned about here.  The mirror inode is only
+			 * released below: writing the $Volume record (mft
+			 * record number 3, below vol->mftmirr_size) mirrors
+			 * it through ntfs_sync_mft_mirror(), which fails
+			 * with -EIO once vol->mftmirr_ino is gone.
 			 */
-			ntfs_warning(sb,
-				"Volume has errors.  Leaving volume marked dirty.  Run chkdsk.");
+			if (__ntfs_write_inode(vol->vol_ino, 1)) {
+				ntfs_warning(sb,
+					"Failed to commit volume information flags.  Run chkdsk.");
+			} else if (NInoDirty(NTFS_I(vol->vol_ino))) {
+				ntfs_warning(sb,
+					"Volume information flags remain dirty after commit.  Run chkdsk.");
+			} else if (NVolErrors(vol)) {
+				/*
+				 * Only warn once the commit has succeeded,
+				 * or this could contradict a failure
+				 * reported above.
+				 */
+				ntfs_warning(sb,
+					"Volume has errors.  Leaving volume marked dirty.  Run chkdsk.");
+			}
 		}
-		/*
-		 * Commits the updated volume flags if they were written.
-		 * The mft mirror must still be around for this: the
-		 * $Volume record (mft record number 3, below
-		 * vol->mftmirr_size) is mirrored by write_mft_record()
-		 * through ntfs_sync_mft_mirror(), which fails with -EIO
-		 * and leaves the mirror stale once vol->mftmirr_ino is
-		 * gone, so the mirror inode is only released after this
-		 * commit.
-		 */
-		ntfs_commit_inode(vol->vol_ino);
 	}
 
 	/*
-- 
2.53.0




