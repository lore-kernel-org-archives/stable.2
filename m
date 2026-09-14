Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E591DED42;
	Mon, 14 Sep 2026 05:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789364989; cv=none; b=AGjt8MJr0g3JWlO6+2vq7qUUqFR7iOwuzjkfXAf+hZ/V6FoQ0Qaa1ST3ETivZcDp2TsckXve/6x/5BNoYGomhLUDvaWOXCWaRnumXXkva6xmV1/5Iahty5Q06HhnWdVj8PsBamrDZpeZdRFVtZujwiJ2X6/f1yqTvc6/8p60DxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789364989; c=relaxed/simple;
	bh=m4/BXjLGVuVAlRj8pGSSsD0J60QoI9urtJmiCrZFwk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F7oHhu5j8HK+2FAPuP4YvBWoBamgum/pQWyRzBWyzF10cgJ+m0uouVLCU+TNDDkpqibHSXQqAcAXFq6W0ApoukwViak+UdR58IFVOgrYm+IEbrc1hv0+lMwVECilAC9n15kKl+u+trKmEqGWA3yI/iowGURJ01RnEewKobXxCZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 116cb736b00011f19a56ed5b684f684d-20260914
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ec0ad7ee-8267-4980-8ad0-40a37e860360,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:a243d128a0b9e0e2ad890da20d224acb,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50|99,ED
	M:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 116cb736b00011f19a56ed5b684f684d-20260914
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1597423051; Mon, 14 Sep 2026 13:49:36 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	Baolin Liu <liubaolin@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v11 6/6] ntfs: check the dirty-state commit on remount and unmount
Date: Mon, 14 Sep 2026 13:49:26 +0800
Message-Id: <20260914054926.78808-7-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260914054926.78808-1-zenghongling@kylinos.cn>
References: <20260914054926.78808-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 fs/ntfs/super.c | 76 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 22 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index f155f16b252d..c547d2ca51ca 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -268,6 +268,7 @@ static int ntfs_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
 	struct ntfs_volume *vol = NTFS_SB(sb);
+	int err;
 
 	ntfs_debug("Entering with remount");
 
@@ -324,14 +325,39 @@ static int ntfs_reconfigure(struct fs_context *fc)
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
 
@@ -1875,26 +1901,32 @@ static void ntfs_put_super(struct super_block *sb)
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
2.25.1

