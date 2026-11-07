Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048699;
	b=2B+wR9qsYrEeSk1XYL/0j0hXWcy3LttP2dm+fxSEyyLdwp33/Mkt5F0/W4Z6xXIOCFZz
	 R/FdSvm4Th6F84K7puPYcQtvyXlzM6RfVe7T4xqpHjX3+UCvNUKvdYFi/5Csyo1Jo9t3t
	 qAqkDPCaGafwDOU9qMvyZz188E5+dsBzwKHYq7RWgiuIyU0D+ZmgXbueKaYyFa+8w//FD
	 SktMnnpnqKcLpCSZAT4nWz8okxQQ/tF4rDmNh0KSKdLkh0SAHI2rImBviI+854rtlbYWf
	 CF0WlI/YTI68rKKTHePxfbAOqIhK8j/ME5AChFNb52vVpd+KuSdcQpdguETCGK5Mikg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048699;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TpUCoY7ZdayjsuhpwhRP2vjjLJg+IFI/R2n07aHnEQA=;
	b=ZTlrTiqUzaofqKOwPuaREZHPzPTI4sBmkptW+Qk7B69zx1NIz2pG19RAcYWr40q/41h1
	 ZwYbgqyPldswEPEXuxhTTc/mXE6NU1rSIpHl4q+yBtOh7Q6/KQHy3vD9s/AVvKsqcSjm8
	 MKTSSNUybwLOb56EjJ49ME5h6IxzNRgiVDX9BAviu0ZTwH5KakVdLQdXdjxErypKAoQKz
	 8XcddBmp29g1suRm5XQDe0rFv4UBe39cSUVwKMlwxxsHY5xERHx2dFB2JaVc7G6q9eE8m
	 7IqJruuGgDF2ZvOyba1R3TeKJfNw0/3YKbUA7VEjPp0D0G0rwxL2Kxk2EQ9fdodum8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qw7sRkZ6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDD2606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qw7sRkZ6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7CC1F0089F;
	Sat,  7 Nov 2026 10:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048698;
	bh=TpUCoY7ZdayjsuhpwhRP2vjjLJg+IFI/R2n07aHnEQA=;
	h=From:To:Cc:Subject:Date;
	b=Qw7sRkZ6oLsiLMJyz7TkkFsFa6Ih3NMU9NPCgmiUNtVS5Jh/mILH/i0ZjCI+3NXy4
	 C4yHMiYUiqshw7CRcr4bc5UJRQHLsHC/NCKl99DfZoTAbkgfe8Duk3YiBX4AtfIzTe
	 HIyBLfA4tqb+ckvs5HAMMREp+vPncscXtKz4TD2ENPKIuLRsIKL/UqB8jWQOw5nz5D
	 eQ1+yyhjKEIngikfIpyYs16FltPW6xSGTD0JQgc2jFHp14tZ2dF0WPgfIjvv9gXfat
	 3mI7zTntrYHNgCR/2vB108F2hg0lg1hTxEGAyNMm62OkE/SZvPwCFG9OIv+Bif4OU8
	 LNbcxouc41JQA==
From: Sasha Levin <sashal@kernel.org>
To: zenghongling@kylinos.cn,
	hyc.lee@gmail.com,
	liubaolin@kylinos.cn,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ntfs: sync the volume dirty bit with the recorded error state" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:51:36 -0500
Message-ID: <20261107055136-failed-6.1-521978c4f444@kernel.org>
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
git cherry-pick -x 521978c4f4441953d67297286e5804485ae05698
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055136-failed-6.1-521978c4f444@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 521978c4f4441953d67297286e5804485ae05698 Mon Sep 17 00:00:00 2001
From: Hongling Zeng <zenghongling@kylinos.cn>
Date: Tue, 15 Sep 2026 16:32:48 +0800
Subject: [PATCH] ntfs: sync the volume dirty bit with the recorded error state

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
with recorded errors so they unmount with chkdsk scheduled.  The
ntfs_clear_volume_flags() wrapper, whose last callers this patch
replaces, has no users left and is removed.

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
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/ntfs.h   |   1 -
 fs/ntfs/super.c  | 129 ++++++++++++++++++++++++++++++++---------------
 fs/ntfs/volume.h |   4 ++
 3 files changed, 93 insertions(+), 41 deletions(-)

diff --git a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
index 1bee1626abdf6..dd56894762a91 100644
--- a/fs/ntfs/ntfs.h
+++ b/fs/ntfs/ntfs.h
@@ -219,7 +219,6 @@ struct option_t {
 };
 extern const struct option_t on_errors_arr[];
 int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags);
-int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags);
 int ntfs_write_volume_label(struct ntfs_volume *vol, char *label);
 
 /* From fs/ntfs/mst.c */
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 5c71aaa0e25d5..785f5b2222934 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -263,6 +263,8 @@ static int ntfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	return 0;
 }
 
+static int ntfs_sync_volume_dirty_state(struct ntfs_volume *vol);
+
 static int ntfs_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
@@ -319,10 +321,24 @@ static int ntfs_reconfigure(struct fs_context *fc)
 		}
 	} else if (!sb_rdonly(sb) && (fc->sb_flags & SB_RDONLY)) {
 		/* Remounting read-only. */
-		if (!NVolErrors(vol)) {
-			if (ntfs_clear_volume_flags(vol, VOLUME_IS_DIRTY))
-				ntfs_warning(sb,
-					"Failed to clear dirty bit in volume information flags.  Run chkdsk.");
+		/*
+		 * With errors recorded the dirty bit is set rather than
+		 * cleared, and it is committed right away: the VFS does
+		 * not sync the filesystem during a remount, and once the
+		 * remount succeeds no further persistence point exists -
+		 * ntfs_sync_fs() is only ever invoked for read-write
+		 * superblocks (all its VFS callers skip read-only ones)
+		 * and ntfs_put_super() skips them, so the only remaining
+		 * write would be the evict-time commit at unmount, which
+		 * a crash never reaches.  An error recorded only after
+		 * the remount is still never persisted.
+		 */
+		if (ntfs_sync_volume_dirty_state(vol)) {
+			ntfs_warning(sb,
+				"Failed to update dirty bit in volume information flags.  Run chkdsk.");
+		} else if (NInoDirty(NTFS_I(vol->vol_ino))) {
+			ntfs_commit_inode(vol->vol_ino);
+			blkdev_issue_flush(sb->s_bdev);
 		}
 	}
 
@@ -364,9 +380,10 @@ void ntfs_handle_error(struct super_block *sb)
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
@@ -375,11 +392,18 @@ void ntfs_handle_error(struct super_block *sb)
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
@@ -389,12 +413,11 @@ static int ntfs_write_volume_flags(struct ntfs_volume *vol,
 
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
 
@@ -446,31 +469,43 @@ int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags)
 }
 
 /*
- * ntfs_clear_volume_flags - clear bits in the volume information flags
- * @vol:	ntfs volume on which to modify the flags
- * @flags:	flags to clear on the volume
+ * ntfs_sync_volume_dirty_state - persist the dirty bit per the error state
+ * @vol:	ntfs volume whose dirty bit to persist
  *
- * Clear the bits in @flags in the volume information flags on the volume @vol.
- * The bits are combined with the current flag state under the lock in
- * ntfs_write_volume_flags(), so concurrent updates are not lost.
+ * Set VOLUME_IS_DIRTY if errors have been recorded on @vol and clear it
+ * otherwise, under the $Volume mrec_lock.
  *
- * Return 0 on success and -errno on error.
- */
-int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags)
-{
-	return ntfs_write_volume_flags(vol, 0, flags, false);
-}
-
-/*
- * ntfs_clear_volume_dirty_if_no_errors - clear dirty bit if no errors exist
- * @vol:	ntfs volume whose dirty bit should be cleared
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
+ *
+ * A hibernated volume is not written from these persistence paths:
+ * resuming Windows from a modified image corrupts it, so the dirty bit
+ * is left as it is on disk and only the in-memory error state is kept.
  *
- * Check NVolErrors() and clear VOLUME_IS_DIRTY under the same mrec_lock so
- * ntfs_sync_fs() cannot clear the dirty bit after a concurrent error has been
- * recorded.
+ * Return 0 on success and -errno on error.
  */
-static int ntfs_clear_volume_dirty_if_no_errors(struct ntfs_volume *vol)
+static int ntfs_sync_volume_dirty_state(struct ntfs_volume *vol)
 {
+	if (NVolHibernated(vol))
+		return 0;
 	return ntfs_write_volume_flags(vol, 0, VOLUME_IS_DIRTY, true);
 }
 
@@ -1683,6 +1718,11 @@ static bool load_system_files(struct ntfs_volume *vol)
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
@@ -1840,22 +1880,31 @@ static void ntfs_put_super(struct super_block *sb)
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
 
@@ -1954,8 +2003,8 @@ static int ntfs_sync_fs(struct super_block *sb, int wait)
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
index 8c17a66b4f22c..fdb57279de84c 100644
--- a/fs/ntfs/volume.h
+++ b/fs/ntfs/volume.h
@@ -189,6 +189,8 @@ struct ntfs_volume {
  *				Windows-reserved names (CON, AUX, NUL, COM1,
  *				LPT1, etc.) or invalid characters.
  *
+ * NV_Hibernated		Windows is hibernated on the volume; the sync
+ *				paths must not write the volume flags.
  * NV_Discard			Issue discard/TRIM commands for freed clusters.
  * NV_DisableSparse		Disable creation of sparse regions.
  * NV_NativeSymlinkRel		Translate absolute Windows reparse targets (native_symlink=rel).
@@ -207,6 +209,7 @@ enum {
 	NV_ShowHiddenFiles,
 	NV_HideDotFiles,
 	NV_CheckWindowsNames,
+	NV_Hibernated,
 	NV_Discard,
 	NV_DisableSparse,
 	NV_NativeSymlinkRel,
@@ -245,6 +248,7 @@ DEFINE_NVOL_BIT_OPS(SysImmutable)
 DEFINE_NVOL_BIT_OPS(ShowHiddenFiles)
 DEFINE_NVOL_BIT_OPS(HideDotFiles)
 DEFINE_NVOL_BIT_OPS(CheckWindowsNames)
+DEFINE_NVOL_BIT_OPS(Hibernated)
 DEFINE_NVOL_BIT_OPS(Discard)
 DEFINE_NVOL_BIT_OPS(DisableSparse)
 DEFINE_NVOL_BIT_OPS(NativeSymlinkRel)
-- 
2.53.0




