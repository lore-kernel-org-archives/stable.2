Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3231F5825;
	Thu,  3 Sep 2026 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788401982; cv=none; b=YM9RE/NfyGdd+Zw6YEf8Yw+BVgho7lf50LLmQqKWVwkfA1xEs8SkR5QOjLJv8xPQYwgQsAKQY4WAv59R+il7zRbrgU/Wsrv2eVN9QLWzTg+zRAlWp+WZeUoypWw/B/WZr/k7mF01vzAtXJRowsfIiAZN8AyQ0HZaBEkv8VF1ppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788401982; c=relaxed/simple;
	bh=Ez+8TJ3pJyXiSoMnWNP8tFLcDaj6SpkJFJTjuPZHs3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AoaOIxmm9mWH//Z93Ny28GoEu22ASVU+3Q9WEua6RwdldkFfwHANraAENN3UWVEO+u5ypzzGRSuL1AiVZ592Sp+aQpsJZSrOmhdiX7asT8P0Wnak+psoQMgAcZeBjX/mU16W99qDbQVnGxB8dPp2Eu9TkQjlVGQLV3JJ4Dz9RcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e87df526a73d11f19a56ed5b684f684d-20260903
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:472d5d95-18cb-461e-85cb-9dc96f097c4c,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:677e86e8e83dfe87aa4b9252e010e7dd,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50,E
	DM:2|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e87df526a73d11f19a56ed5b684f684d-20260903
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 534455088; Thu, 03 Sep 2026 10:19:36 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] ntfs: add helper to record error flag before setting volume dirty bit
Date: Thu,  3 Sep 2026 10:19:29 +0800
Message-Id: <20260903021930.201169-2-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260903021930.201169-1-zenghongling@kylinos.cn>
References: <20260903021930.201169-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The runtime metadata-corruption paths in fs/ntfs record the error flag
with a bare NVolSetErrors() and separately rely on ntfs_set_volume_flags()
or nothing at all to persist VOLUME_IS_DIRTY.  Since the clear side
(ntfs_sync_fs() via ntfs_clear_volume_dirty_if_no_errors()) evaluates
NVolErrors() under ni->mrec_lock, a writer that records the error flag
after the lock has been checked leaves a window in which the volume ends
up persisted as clean despite the recorded error, so chkdsk will not run
on the next mount and corrupted metadata can persist.

Introduce ntfs_mark_volume_dirty_with_error(), which records the error
flag before the locked dirty-bit write: the mutex acquire/release in
ntfs_write_volume_flags() then provides the ordering, as any clear path
running after us can only evaluate NVolErrors() under the lock once the
flag is set.

The helper is only for runtime error paths that can run concurrently
with sync and hold no mrec_lock.  Mount and remount paths remain
serialized by sb->s_umount and keep using NVolSetErrors() directly,
since they do not race with ntfs_sync_fs() and may not be allowed to
write the volume: before $Volume is loaded, with a read-only opened
bdev, or on a hibernated volume, which we must not write to at all.
The same applies to the ntfs_attr_lookup() failure paths and the mft
record writeback paths, which hold a caller's mrec_lock and would
self-deadlock the helper on the $Volume inode.  The helper also returns
success without doing anything if vol_ino is still NULL during mount, a
state no runtime caller can observe.

Converting the runtime metadata-corruption call sites in mft.c,
lcnalloc.c, bitmap.c and inode.c to use the helper is done in the
next patch.

Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/ntfs.h  |  1 +
 fs/ntfs/super.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
index df5a75d506f6..63d7900b6dba 100644
--- a/fs/ntfs/ntfs.h
+++ b/fs/ntfs/ntfs.h
@@ -222,6 +222,7 @@ struct option_t {
 extern const struct option_t on_errors_arr[];
 int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags);
 int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags);
+int ntfs_mark_volume_dirty_with_error(struct ntfs_volume *vol);
 int ntfs_write_volume_label(struct ntfs_volume *vol, char *label);
 
 /* From fs/ntfs/mst.c */
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index a7977b95b967..fcf327ac98e5 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -467,6 +467,44 @@ static int ntfs_clear_volume_dirty_if_no_errors(struct ntfs_volume *vol)
 	return ntfs_write_volume_flags(vol, 0, VOLUME_IS_DIRTY, true);
 }
 
+/*
+ * ntfs_mark_volume_dirty_with_error - record an error and mark volume dirty
+ * @vol:	ntfs volume on which an error has been recorded
+ *
+ * To be called when runtime metadata corruption is detected so that chkdsk
+ * runs on the next mount.  NVolSetErrors() is called before the dirty bit
+ * is written, and the mutex acquire/release in ntfs_write_volume_flags()
+ * provides the ordering: a concurrent ntfs_clear_volume_dirty_if_no_errors()
+ * can only run under the lock after the error flag is set and will
+ * therefore leave the dirty bit alone.
+ *
+ * Only for runtime error paths that can run concurrently with sync and
+ * hold no mrec_lock.  Do not call while holding the mrec_lock of the
+ * $Volume inode itself (the ntfs_attr_lookup() failure paths and the mft
+ * record writeback paths, which may hold it).  Mount and remount paths
+ * are serialized by sb->s_umount and cannot race sync; error paths that
+ * run before $Volume is loaded, that may run with a read-only opened
+ * bdev, or on a hibernated volume, which we must not write to at all,
+ * keep calling NVolSetErrors() directly.
+ *
+ * Return 0 on success and -errno on error.
+ */
+int ntfs_mark_volume_dirty_with_error(struct ntfs_volume *vol)
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
 int ntfs_write_volume_label(struct ntfs_volume *vol, char *label)
 {
 	struct ntfs_inode *vol_ni = NTFS_I(vol->vol_ino);
-- 
2.25.1

