Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BC6395ADE;
	Mon,  7 Sep 2026 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762146; cv=none; b=ENfKyNrPRHBKhyZgjcMoegE81jQc8ALHuZrbJ2MjgDZkxY07Ru/0RY4ExtVGTgyzHZLphwF/egbTZp13jHiDqdiddYGx2fWoFqQTCtYjG6WH+5STEGsgnNCM+80r+J2U8kjLkrBfMl9y1szO2QKUXo5OV1EvpH/QyEaknk60a0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762146; c=relaxed/simple;
	bh=A0Z3SKU9dRA0o1nFHGDFG4lN7MmB4cHHwi0maWVXV/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a8znyZy126fG+nPR/OPXgMugg8g8dhvuujkm+PfhdqTJNSV/owqZaCN1NBzxyQdt45H+P7XGNqk541ZgbzA5UHXtU0Lsb5lhXkl2KUNAItnA+Z7zTU+ftemepN15X8+ij1LyVPNu+Nim8Zmea2uqDZZJRch7e5xtkklw8k201eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 764fdec0aa8411f19a56ed5b684f684d-20260907
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b34b7e60-8fbd-45f2-a7ed-fe2d9ccc3853,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:76606b53fbbdc8246b2ff2627478d748,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 764fdec0aa8411f19a56ed5b684f684d-20260907
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 304553424; Mon, 07 Sep 2026 14:22:12 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] ntfs: sync the volume dirty bit with the recorded error state
Date: Mon,  7 Sep 2026 14:22:05 +0800
Message-Id: <20260907062206.260638-3-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260907062206.260638-1-zenghongling@kylinos.cn>
References: <20260907062206.260638-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The runtime metadata-corruption paths in fs/ntfs only record the
in-memory NVolErrors() flag; whether VOLUME_IS_DIRTY ever reaches disk
depends on ntfs_set_volume_flags() being called by some other path,
which for most error sites never happens.  A volume can therefore
unmount with a clean on-disk flag despite recorded corruption, and
chkdsk will not run on the next mount.

Persisting the dirty bit from the error paths themselves does not work:
they run under a wide variety of ntfs locks, and the dirty-bit write
takes the $Volume mrec_lock and maps the $Volume mft record, which on
an $MFT page-cache miss takes the $MFT runlist lock for writing.  That
is enough to self-deadlock or form ABBA cycles from several of them:
the $MFT extend undo paths hold the $MFT runlist lock and then take
vol->lcnbmp_lock inside ntfs_cluster_free(); the cluster allocation and
free rollback paths hold vol->lcnbmp_lock; and the whole mft record
allocation tree is reachable from ntfs_write_volume_label()'s
attribute-list maintenance while it holds the $Volume mrec_lock itself.

Instead, make the persistence a property of the sync paths, which run
without ntfs locks held.  The new ntfs_sync_volume_dirty_state() sets
VOLUME_IS_DIRTY when NVolErrors() is recorded and clears it otherwise,
evaluating the error flag under the $Volume mrec_lock.  It is called
from ntfs_sync_fs(), from the remount-to-read-only path of
ntfs_reconfigure(), and from ntfs_put_super(), which previously
evaluated NVolErrors() outside the lock before clearing the dirty bit
unconditionally, and which now also persists the dirty bit for volumes
with recorded errors so they unmount with chkdsk scheduled.

The guarantee this provides is eventual, not instantaneous: the error
paths record NVolErrors() with a lock-free set_bit(), so a persistence
point that evaluates the flag just before an error is recorded can
still leave the on-disk bit clean until the next one.  This is sound
because NVolErrors() is sticky for the lifetime of the mount and every
persistence point re-derives the on-disk bit from it; the last one,
ntfs_put_super(), runs after evict_inodes() on a quiesced filesystem,
so a volume that is read-write at unmount time cannot unmount clean.
A volume that is already read-only when the error is recorded
(errors=remount-ro flips the superblock on the first error, as does an
earlier remount-ro) has no persistence point left and keeps whatever
on-disk bit it had; that behaviour is unchanged.  The residual window
is a crash between the error and the next persistence point.

The persistence paths never write a hibernated volume: resuming Windows
from a modified image corrupts it.  Record the mount-time hibernation
verdict in the new NV_Hibernated volume flag and make
ntfs_sync_volume_dirty_state() a no-op while it is set, so the dirty
bit is left exactly as it is on disk and only the in-memory error
state is kept.  Without this, an rw mount of a hibernated volume with
the default errors=continue would gain a filesystem-internal write on
the first sync, remount or unmount.  Other writes to such a mount,
like the mount-time logfile emptying, are pre-existing and unchanged.

Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/super.c  | 113 ++++++++++++++++++++++++++++++++++++-----------
 fs/ntfs/volume.h |   4 ++
 2 files changed, 90 insertions(+), 27 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index a7977b95b967..920b1420a26f 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -262,6 +262,8 @@ static int ntfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	return 0;
 }
 
+static int ntfs_sync_volume_dirty_state(struct ntfs_volume *vol);
+
 static int ntfs_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
@@ -312,11 +314,19 @@ static int ntfs_reconfigure(struct fs_context *fc)
 		}
 	} else if (!sb_rdonly(sb) && (fc->sb_flags & SB_RDONLY)) {
 		/* Remounting read-only. */
-		if (!NVolErrors(vol)) {
-			if (ntfs_clear_volume_flags(vol, VOLUME_IS_DIRTY))
-				ntfs_warning(sb,
-					"Failed to clear dirty bit in volume information flags.  Run chkdsk.");
-		}
+		/*
+		 * With errors recorded the dirty bit is set rather than
+		 * cleared, so it survives until the unmount.  Note that
+		 * once this remount succeeds no further persistence point
+		 * exists: ntfs_sync_fs() is only ever invoked for
+		 * read-write superblocks (all its VFS callers skip
+		 * read-only ones) and ntfs_put_super() skips them, so an
+		 * error recorded only after the remount is never
+		 * persisted.
+		 */
+		if (ntfs_sync_volume_dirty_state(vol))
+			ntfs_warning(sb,
+				"Failed to update dirty bit in volume information flags.  Run chkdsk.");
 	}
 
 	ntfs_debug("Done.");
@@ -357,9 +367,10 @@ void ntfs_handle_error(struct super_block *sb)
  * @vol:	ntfs volume on which to modify the flags
  * @set_bits:	bits to set in the volume information flags
  * @clear_bits:	bits to clear in the volume information flags
+ * @dirty_if_errors:	force VOLUME_IS_DIRTY on when NVolErrors() is set
  *
  * Internal function.  You probably want to use ntfs_{set,clear}_volume_flags()
- * instead (see below).
+ * or ntfs_sync_volume_dirty_state() instead (see below).
  *
  * Combine @set_bits and @clear_bits with the current in-memory flag state and
  * write the result back.  The set/clear helpers pass only the bits to modify,
@@ -368,11 +379,18 @@ void ntfs_handle_error(struct super_block *sb)
  * All bit manipulation is done on CPU-endian values, and the result is
  * converted back to little-endian before storing it.
  *
+ * When @dirty_if_errors is true and errors have been recorded on @vol,
+ * VOLUME_IS_DIRTY is forced on after the requested changes.  NVolErrors() is
+ * evaluated under the same mrec_lock, which orders this against other
+ * locked flag updates; the runtime error paths themselves record the flag
+ * lock-free, so see ntfs_sync_volume_dirty_state() for the guarantee this
+ * provides against them.
+ *
  * Return 0 on success and -errno on error.
  */
 static int ntfs_write_volume_flags(struct ntfs_volume *vol,
 		const __le16 set_bits, const __le16 clear_bits,
-		const bool skip_if_errors)
+		const bool dirty_if_errors)
 {
 	struct ntfs_inode *ni = NTFS_I(vol->vol_ino);
 	struct volume_information *vi;
@@ -382,12 +400,11 @@ static int ntfs_write_volume_flags(struct ntfs_volume *vol,
 
 	mutex_lock(&ni->mrec_lock);
 
-	if (skip_if_errors && NVolErrors(vol))
-		goto done;
-
 	flags = le16_to_cpu(vol->vol_flags);
 	flags |= le16_to_cpu(set_bits) & le16_to_cpu(VOLUME_FLAGS_MASK);
 	flags &= ~(le16_to_cpu(clear_bits) & le16_to_cpu(VOLUME_FLAGS_MASK));
+	if (dirty_if_errors && NVolErrors(vol))
+		flags |= le16_to_cpu(VOLUME_IS_DIRTY);
 	ntfs_debug("Entering, old flags = 0x%x, new flags = 0x%x.",
 			le16_to_cpu(vol->vol_flags), flags);
 
@@ -455,15 +472,43 @@ int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags)
 }
 
 /*
- * ntfs_clear_volume_dirty_if_no_errors - clear dirty bit if no errors exist
- * @vol:	ntfs volume whose dirty bit should be cleared
+ * ntfs_sync_volume_dirty_state - persist the dirty bit per the error state
+ * @vol:	ntfs volume whose dirty bit to persist
+ *
+ * Set VOLUME_IS_DIRTY if errors have been recorded on @vol and clear it
+ * otherwise, under the $Volume mrec_lock.
+ *
+ * The guarantee this provides is eventual, not instantaneous: the runtime
+ * error paths record NVolErrors() with a lock-free set_bit(), so a
+ * persistence point that evaluates the flag just before an error is
+ * recorded can still leave the on-disk bit clean.  This is sound because
+ * NVolErrors() is sticky (nothing clears it for the lifetime of the mount)
+ * and every persistence point re-derives the on-disk bit from it; the
+ * last one, ntfs_put_super(), runs after evict_inodes() on a quiesced
+ * filesystem, so a volume that is read-write at unmount time cannot
+ * unmount clean.  A volume that is already read-only when the error is
+ * recorded (errors=remount-ro flips the superblock on the first error,
+ * as does an earlier remount-ro) has no persistence point left and
+ * keeps whatever on-disk bit it had; that behaviour is unchanged.  The
+ * residual window is a crash between the error and the next
+ * persistence point.
+ *
+ * This is the single point that persists the in-memory error state to disk.
+ * The runtime error paths only record NVolErrors() because they run under a
+ * variety of ntfs locks the dirty-bit write cannot be taken under (runlist
+ * locks, vol->lcnbmp_lock, vol->mftbmp_lock, mrec_locks); the first
+ * ntfs_sync_fs(), a remount, or the unmount then persists the flag here.
  *
- * Check NVolErrors() and clear VOLUME_IS_DIRTY under the same mrec_lock so
- * ntfs_sync_fs() cannot clear the dirty bit after a concurrent error has been
- * recorded.
+ * A hibernated volume is not written from these persistence paths:
+ * resuming Windows from a modified image corrupts it, so the dirty bit
+ * is left as it is on disk and only the in-memory error state is kept.
+ *
+ * Return 0 on success and -errno on error.
  */
-static int ntfs_clear_volume_dirty_if_no_errors(struct ntfs_volume *vol)
+static int ntfs_sync_volume_dirty_state(struct ntfs_volume *vol)
 {
+	if (NVolHibernated(vol))
+		return 0;
 	return ntfs_write_volume_flags(vol, 0, VOLUME_IS_DIRTY, true);
 }
 
@@ -1621,6 +1666,11 @@ static bool load_system_files(struct ntfs_volume *vol)
 			ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
 		}
 		NVolSetErrors(vol);
+		/*
+		 * Remember it for the lifetime of the mount: see
+		 * ntfs_sync_volume_dirty_state().
+		 */
+		NVolSetHibernated(vol);
 	}
 
 	/* If (still) a read-write mount, empty the logfile. */
@@ -1776,22 +1826,31 @@ static void ntfs_put_super(struct super_block *sb)
 	ntfs_commit_inode(vol->mft_ino);
 
 	/*
-	 * If a read-write mount and no volume errors have occurred, mark the
-	 * volume clean.  Also, re-commit all affected inodes.
+	 * If a read-write mount, persist the error state in the volume flags:
+	 * mark the volume clean if no volume errors have occurred, and make
+	 * sure VOLUME_IS_DIRTY is on disk if any have, so chkdsk runs on the
+	 * next mount.  Also, re-commit all affected inodes.
 	 */
 	if (!sb_rdonly(sb)) {
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
 		if (!NVolErrors(vol)) {
-			if (ntfs_clear_volume_flags(vol, VOLUME_IS_DIRTY))
-				ntfs_warning(sb,
-					"Failed to clear dirty bit in volume information flags.  Run chkdsk.");
-			ntfs_commit_inode(vol->vol_ino);
 			ntfs_commit_inode(vol->root_ino);
 			if (vol->mftmirr_ino)
 				ntfs_commit_inode(vol->mftmirr_ino);
 			ntfs_commit_inode(vol->mft_ino);
-		} else {
-			ntfs_warning(sb,
-				"Volume has errors.  Leaving volume marked dirty.  Run chkdsk.");
 		}
 	}
 
@@ -1890,8 +1949,8 @@ static int ntfs_sync_fs(struct super_block *sb, int wait)
 		return 0;
 
 	/* If there are some dirty buffers in the bdev inode */
-	if (ntfs_clear_volume_dirty_if_no_errors(vol)) {
-		ntfs_warning(sb, "Failed to clear dirty bit in volume information flags.  Run chkdsk.");
+	if (ntfs_sync_volume_dirty_state(vol)) {
+		ntfs_warning(sb, "Failed to sync dirty bit in volume information flags.  Run chkdsk.");
 		err = -EIO;
 	}
 	sync_inodes_sb(sb);
diff --git a/fs/ntfs/volume.h b/fs/ntfs/volume.h
index 65fd3908af26..b946263153db 100644
--- a/fs/ntfs/volume.h
+++ b/fs/ntfs/volume.h
@@ -175,6 +175,8 @@ struct ntfs_volume {
  *				Windows-reserved names (CON, AUX, NUL, COM1,
  *				LPT1, etc.) or invalid characters.
  *
+ * NV_Hibernated		Windows is hibernated on the volume; the sync
+ *				paths must not write the volume flags.
  * NV_Discard			Issue discard/TRIM commands for freed clusters.
  * NV_DisableSparse		Disable creation of sparse regions.
  * NV_NativeSymlinkRel		Translate absolute Windows reparse targets (native_symlink=rel).
@@ -193,6 +195,7 @@ enum {
 	NV_ShowHiddenFiles,
 	NV_HideDotFiles,
 	NV_CheckWindowsNames,
+	NV_Hibernated,
 	NV_Discard,
 	NV_DisableSparse,
 	NV_NativeSymlinkRel,
@@ -231,6 +234,7 @@ DEFINE_NVOL_BIT_OPS(SysImmutable)
 DEFINE_NVOL_BIT_OPS(ShowHiddenFiles)
 DEFINE_NVOL_BIT_OPS(HideDotFiles)
 DEFINE_NVOL_BIT_OPS(CheckWindowsNames)
+DEFINE_NVOL_BIT_OPS(Hibernated)
 DEFINE_NVOL_BIT_OPS(Discard)
 DEFINE_NVOL_BIT_OPS(DisableSparse)
 DEFINE_NVOL_BIT_OPS(NativeSymlinkRel)
-- 
2.25.1

