Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8B937DEB6;
	Tue, 22 Sep 2026 07:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062378; cv=none; b=So4nj7dBSusWYW1URX4+5HzhARceGY6VyKiPm+1JrKrS8PqUFKxPVcBv4v8JfPXnZGVOz1R8ro7B716Bty4VEQPX50yHQS/9Tq8fx6Wm51Y4T0MVTJ7+pzY8YIWzrO5U+WZ293RHDHkMGfw96WUT7Kcu4DZoX9pMuOmlQyNaC0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062378; c=relaxed/simple;
	bh=SBHYVWMF+PE4N/MoLDrNahH+o40iDuilrQ0sVL9XNEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=doyEdWf/QxhlITuwaMDn2/abMi1tQfo26yDOw/YB63xv7GD2MAU3doQjaiFs1+2EPITcERqB7ww/i4gN9tLXRBhlW6XaMQoBCJySqj8JCxJSSGR3e6FZ1iqYBcFxrjp2Fc7yJvNo6lxlsXgkG9jC0a99C2XNwvW/flW9zgfiKSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cbb139f2b65711f19a56ed5b684f684d-20260922
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:4f356aa1-fe19-4bbb-993d-b1cb8caa0823,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:a248d159bfc200344787337ea783c297,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cbb139f2b65711f19a56ed5b684f684d-20260922
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 306819291; Tue, 22 Sep 2026 15:32:42 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v7] ntfs: mount hibernated volumes read-only regardless of  errors=
Date: Tue, 22 Sep 2026 15:32:36 +0800
Message-Id: <20260922073236.2066735-1-zenghongling@kylinos.cn>
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
Change in v7:
 -Resolve merge conflicts.
---
 fs/ntfs/super.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 82b5bf28b6ab..877a9e1f4e32 100644
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
@@ -1686,12 +1698,15 @@ static bool load_system_files(struct ntfs_volume *vol)
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
+		ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
+	} else if (!sb_rdonly(sb) && NVolErrors(vol)) {
+		/* Match the read-write remount restriction for recorded errors. */
+		sb->s_flags |= SB_RDONLY;
+		ntfs_error(sb,
+			"Errors were recorded during mount.  Mounting read-only.  Run chkdsk.");
 		/*
 		 * Remember it for the lifetime of the mount: see
 		 * ntfs_sync_volume_dirty_state().
-- 
2.25.1

