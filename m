Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD9A4D2EE0;
	Tue, 22 Sep 2026 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071228; cv=none; b=Tnjoksc2pRbdlkNEE4M5BQ5Lz7G2wPiS8gCorq9JqGsh9X3tirzA0YrkHIbsRSG++1chn4SoxqANeSAPyo30gaAoVJtOTb/hs69NwTFc40cFjqTWicXKAcDlPbF+mSA5HVe9e2Gd6w0BVbk8OiraSL2hXvIp8wOVqboL/jIpLLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071228; c=relaxed/simple;
	bh=Ycpv2bOivDeW/2Kk61K1JlU9KPo/cytaxYgK6fO3Kuk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R1b+2tzeRhBN6m4418npZgjMTFluH/UTDV/vYX8BA3v1GVNX81h1fUg62hM3sD71/Un/4Ursr5Losl7+5NSOMUoPMrkf2hSnVgrZSDDhQYZfyG+H5z5lVHFGkKqIiQH79IHDOUPgQkfYiOPtYYCpqTOAG59brcAVxowBDCuk5qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 69a0ae86b66c11f19a56ed5b684f684d-20260922
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d7e4e3d0-6cb3-4b0c-a9de-08f21298f03b,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:a842b0a05358cccc4fcd3b6ffd05ac44,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 69a0ae86b66c11f19a56ed5b684f684d-20260922
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1983275394; Tue, 22 Sep 2026 18:00:17 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v8] ntfs: mount hibernated volumes read-only regardless of  errors=
Date: Tue, 22 Sep 2026 18:00:12 +0800
Message-Id: <20260922100012.2134955-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hibernation check in load_system_files() only converts the
superblock to read-only under errors=remount-ro.  With the default
errors=continue (and with errors=panic), a hibernated volume is
mounted read-write and the mount-time $LogFile emptying writes to it,
although a hibernated volume must not be written to at all.

Drop the on_errors term so that a hibernated volume, or a volume whose
hibernation state cannot be determined, always mounts read-only.
NVolErrors() is still recorded, so ntfs_reconfigure() keeps refusing
remounts to read-write, and the $LogFile emptying is skipped by its
!sb_rdonly() check.

The check itself must not apply the errors= policy either: it runs
before SB_RDONLY is set, and ntfs_lookup_inode_by_name() and ntfs_iget()
call ntfs_error() internally on corruption or I/O errors, which under
errors=panic would panic the machine before the read-only fallback has
made its decision.  Temporarily substitute errors=remount-ro for
errors=panic around the check: nested ntfs_error() calls then fall
back to read-only, and any read-only transition they trigger is
preserved even when the error is not propagated to the check's return
value or recorded in NVolErrors().  This is safe during initial mount,
before the super block is published.

If the check reports hibernation or fails, set SB_RDONLY and record
NVolErrors() unconditionally: hibernation safety takes precedence over
the errors= policy.  A volume with errors recorded during the check or
earlier in the mount, e.g. when loading the LogFile, also stays
read-only, matching what ntfs_reconfigure() enforces for remounts.

Fixes: 6251f0b0de7d ("ntfs: update super block operations")
Cc: stable@vger.kernel.org
Suggested-by: Baolin Liu <liubaolin@kylinos.cn>
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
Change in v8:
 -Resolve merge conflicts.
---
 fs/ntfs/super.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 82b5bf28b6ab..2a5694a5f098 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1503,6 +1503,7 @@ static bool load_system_files(struct ntfs_volume *vol)
 	struct ntfs_attr_search_ctx *ctx;
 	struct restart_page_header *rp;
 	int err;
+	u8 saved_on_errors;
 
 	ntfs_debug("Entering.");
 	/* Get mft mirror inode compare the contents of $MFT and $MFTMirr. */
@@ -1677,8 +1678,19 @@ static bool load_system_files(struct ntfs_volume *vol)
 	 * NVolErrors() without setting the dirty volume flag and mount
 	 * read-only.  This will prevent read-write remounting and it will also
 	 * prevent all writes.
+	 *
+	 * Nested lookup and inode-loading errors must not panic before the
+	 * read-only fallback has run.  Temporarily use errors=remount-ro
+	 * instead of errors=panic, preserving any read-only transition even
+	 * if an error is not propagated to the check's return value or
+	 * recorded in NVolErrors().  This is safe during initial mount,
+	 * before the super block is published.
 	 */
+	saved_on_errors = vol->on_errors;
+	if (saved_on_errors == ON_ERRORS_PANIC)
+		vol->on_errors = ON_ERRORS_REMOUNT_RO;
 	err = check_windows_hibernation_status(vol);
+	vol->on_errors = saved_on_errors;
 	if (unlikely(err)) {
 		static const char *es1a = "Failed to determine if Windows is hibernated";
 		static const char *es1b = "Windows is hibernated";
@@ -1686,17 +1698,21 @@ static bool load_system_files(struct ntfs_volume *vol)
 		const char *es1;
 
 		es1 = err < 0 ? es1a : es1b;
-		/* If a read-write mount, convert it to a read-only mount. */
-		if (!sb_rdonly(sb) && vol->on_errors == ON_ERRORS_REMOUNT_RO) {
-			sb->s_flags |= SB_RDONLY;
-			ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
-		}
+		/* Hibernation safety takes precedence over the errors= policy. */
+		sb->s_flags |= SB_RDONLY;
 		NVolSetErrors(vol);
-		/*
-		 * Remember it for the lifetime of the mount: see
-		 * ntfs_sync_volume_dirty_state().
-		 */
-		NVolSetHibernated(vol);
+		ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
+
+                /*
+                 * Remember it for the lifetime of the mount: see
+                 * ntfs_sync_volume_dirty_state().
+                 */
+                NVolSetHibernated(vol);
+	} else if (!sb_rdonly(sb) && NVolErrors(vol)) {
+		/* Match the read-write remount restriction for recorded errors. */
+		sb->s_flags |= SB_RDONLY;
+		ntfs_error(sb,
+			"Errors were recorded during mount.  Mounting read-only.  Run chkdsk.");
 	}
 
 	/* If (still) a read-write mount, empty the logfile. */
-- 
2.25.1

