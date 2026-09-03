Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D912882DE;
	Thu,  3 Sep 2026 01:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788398479; cv=none; b=rURlq2LW3ATDnq6cvAdJZIp7/fkm6szr8OQCH7YYRFARPBKd5bGLiV6+fmgWi5zbz6WfhhxTkHkhPfO6qtc2czHEnDSKX0t8b75o+UUCoh+P1O1e/q0VxAhflea68gJJLckAEfOatx8wZtvb+ONn3mx9UzYZrt83a1WZO5kH2PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788398479; c=relaxed/simple;
	bh=GgS14IMmNL5dcssotwVo/4B1rAW3pL7fnpjiNwNLo5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c3eFiu9GRnpF1WsBsEq5haWOzm/A44zRjCeNsavFJXoVH6FvWom6OqTS6grV7TvR92yRXHDDfwk6NRl7ihKQcrLf0jrRnLX02Eq0mrTpEXiBVsxaHfPISFELuqMTYwC0bRvE11aL9+nqxx+/fpa5PHJhvqfx9+mUKy7HLNLXGRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: be2db20aa73511f19a56ed5b684f684d-20260903
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:782ee2c6-c032-486b-aca6-d611ad47db23,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:b33cb589691adf949d45d5bc10a75008,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50,E
	DM:2|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: be2db20aa73511f19a56ed5b684f684d-20260903
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 642936962; Thu, 03 Sep 2026 09:21:09 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ntfs: add helper to record error flag before setting volume dirty bit
Date: Thu,  3 Sep 2026 09:21:04 +0800
Message-Id: <20260903012104.185926-2-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260903012104.185926-1-zenghongling@kylinos.cn>
References: <20260903012104.185926-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The runtime error paths in fs/ntfs/super.c record the error flag with a
bare NVolSetErrors() and separately rely on ntfs_set_volume_flags() or
nothing at all to persist VOLUME_IS_DIRTY.  Since the clear side
(ntfs_sync_fs() via ntfs_clear_volume_dirty_if_no_errors()) evaluates
NVolErrors() under ni->mrec_lock, a writer that records the error flag
after the lock has been checked leaves a window:

    Sync thread                          Error path
    -----------
    lock
    NVolErrors() == false
    clear VOLUME_IS_DIRTY
    unlock
                                         NVolSetErrors()

The on-disk volume ends up clean despite the recorded error, so chkdsk
will not run on the next mount.

Add ntfs_mark_volume_dirty_with_error() which records the error flag
before the locked dirty-bit write: the mutex acquire/release in
ntfs_write_volume_flags() then provides the ordering, as any clear path
running after us can only evaluate NVolErrors() under the lock once the
flag is set.  Convert the super.c error paths that run with $Volume
loaded and a writable bdev to use it:

 - the ntfs_reconfigure() failure to empty the LogFile on remount
   read-write.  This branch only runs when remounting read-only to
   read-write, and the VFS has already rejected the remount with
   -EACCES if the bdev is read-only (reconfigure_super()), so the
   dirty bit can be written here.  A hibernated volume never reaches
   this point because the earlier NVolErrors() check rejects the
   remount first;

 - the load_system_files() failure to empty the LogFile on a
   read-write mount.

The remaining super.c call sites keep calling NVolSetErrors() directly,
now with comments explaining why:

 - the $MFTMirr check failure runs before $Volume is loaded, so the
   dirty bit cannot be persisted yet;

 - the LogFile load failure is also reached on read-only mounts, which
   open the bdev read-only, so the dirty bit cannot be written;

 - the hibernation check must not write to the volume at all.

The helper is only for runtime error paths: it returns success without
doing anything if vol_ino is still NULL during mount, a state no
runtime caller can observe, rather than dereference a NULL inode;
mount-time error paths record the error flag with NVolSetErrors()
directly instead.  It stays static to this file; converting the runtime
metadata-corruption call sites in mft.c, lcnalloc.c, bitmap.c and
inode.c is left to a follow-up patch which will also move it to shared
code if needed.

This covers the writer-side ordering for the super.c error paths only;
it does not change ntfs_sync_fs(), which already clears the dirty bit
via the in-lock NVolErrors() check of
ntfs_clear_volume_dirty_if_no_errors().

Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/super.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index a7977b95b967..8c5681472002 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -262,6 +262,41 @@ static int ntfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	return 0;
 }
 
+/*
+ * ntfs_mark_volume_dirty_with_error - record an error and mark volume dirty
+ * @vol:	ntfs volume on which an error has been recorded
+ *
+ * To be called when metadata corruption is detected so that chkdsk runs on
+ * the next mount.  NVolSetErrors() is called before the dirty bit is
+ * written, and the mutex acquire/release in ntfs_write_volume_flags()
+ * provides the ordering: a concurrent ntfs_clear_volume_dirty_if_no_errors()
+ * can only run under the lock after the error flag is set and will
+ * therefore leave the dirty bit alone.
+ *
+ * Only for runtime error paths on a writable volume.  Do not call while
+ * holding the mrec_lock of the $Volume inode itself (the ntfs_attr_lookup()
+ * failure paths).  Error paths that run before $Volume is loaded, that may
+ * run with a read-only opened bdev, or on a hibernated volume, which we
+ * must not write to at all, keep calling NVolSetErrors() directly.
+ *
+ * Return 0 on success and -errno on error.
+ */
+static int ntfs_mark_volume_dirty_with_error(struct ntfs_volume *vol)
+{
+	/*
+	 * vol_ino is NULL while the volume is still being mounted.  This is a
+	 * runtime-only helper and no runtime caller can see that state, but if
+	 * one ever does, there is nothing on disk to update yet, so do nothing
+	 * rather than dereference a NULL inode.  Mount-time error paths record
+	 * the error flag with NVolSetErrors() directly instead.
+	 */
+	if (!vol->vol_ino)
+		return 0;
+
+	NVolSetErrors(vol);
+	return ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+}
+
 static int ntfs_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
@@ -307,7 +342,7 @@ static int ntfs_reconfigure(struct fs_context *fc)
 		if (vol->logfile_ino && !ntfs_empty_logfile(vol->logfile_ino)) {
 			ntfs_error(sb, "Failed to empty journal LogFile%s",
 					es);
-			NVolSetErrors(vol);
+			ntfs_mark_volume_dirty_with_error(vol);
 			return -EROFS;
 		}
 	} else if (!sb_rdonly(sb) && (fc->sb_flags & SB_RDONLY)) {
@@ -1446,6 +1481,11 @@ static bool load_system_files(struct ntfs_volume *vol)
 			ntfs_error(sb, "%s.  Mounting read-only%s",
 					!vol->mftmirr_ino ? es1 : es2, es3);
 		}
+		/*
+		 * $Volume is not loaded yet, so the dirty bit cannot be
+		 * persisted; record the error flag only.  Mount is
+		 * serialized against sync anyway.
+		 */
 		NVolSetErrors(vol);
 	}
 	/* Get mft bitmap attribute inode. */
@@ -1588,6 +1628,11 @@ static bool load_system_files(struct ntfs_volume *vol)
 			sb->s_flags |= SB_RDONLY;
 			ntfs_error(sb, "Failed to load LogFile. Mounting read-only.");
 		}
+		/*
+		 * Read-only mounts reach this too with a read-only opened
+		 * bdev, so the dirty bit cannot be written; record the
+		 * error flag only.  Mount is serialized against sync anyway.
+		 */
 		NVolSetErrors(vol);
 	}
 
@@ -1633,7 +1678,7 @@ static bool load_system_files(struct ntfs_volume *vol)
 		/* Convert to a read-only mount. */
 		ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
 		sb->s_flags |= SB_RDONLY;
-		NVolSetErrors(vol);
+		ntfs_mark_volume_dirty_with_error(vol);
 	}
 	/* If on NTFS versions before 3.0, we are done. */
 	if (unlikely(vol->major_ver < 3))
-- 
2.25.1

