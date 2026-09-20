Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB5A3C4168;
	Sun, 20 Sep 2026 02:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871973; cv=none; b=NbPHpl/vP2/4eihwmHdx9gYLat6BeotPMRX6/mXvceM0MdFbw8VGlU2uKjKKRFhFM/I3SSBYv5/NejmnNOwB8MFEIKv6jlK6Bjt0BmLswcL2KITlkekXedL81cYeJ1D3nMuNTpClpLsVHZB3FzLsnSnKZzxRbgScTfiQhQv2LfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871973; c=relaxed/simple;
	bh=GCsAjX7R52Y2q8IvLXpU3GYW2cvTKh7EKXfmh1yWEPk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cO61a0TMBr5ErqsMA9gJRSszbJSJxrA0jGiJ2emLrIwGuJWG5tjV6ngz/PdetfnOh9r5M6SheXsC7c1QjswBakLRkmdjSde9YNQhhBv1vxj993+cbHDB4d/V2wSy29ZcDYgXZtfrwwcHrui3g/qlrWaT4PTm5Lib19ICihUXl3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7b50f8e2b49c11f19a56ed5b684f684d-20260920
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:3ee9096d-b447-4d39-a64a-9a7b0de0730e,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:520877f7efa71a7e04ec182b30ba4bc6,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7b50f8e2b49c11f19a56ed5b684f684d-20260920
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1947193105; Sun, 20 Sep 2026 10:39:20 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v4] ntfs: mount hibernated volumes read-only regardless of errors=
Date: Sun, 20 Sep 2026 10:39:14 +0800
Message-Id: <20260920023914.21881-1-zenghongling@kylinos.cn>
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
before SB_RDONLY is set, and ntfs_lookup_inode_by_name() and
ntfs_iget() call ntfs_error() internally on corruption or I/O errors,
which under errors=panic would panic the machine before the read-only
fallback has made its decision.  Run the check with the super block
temporarily marked read-only, which makes ntfs_handle_error() ignore
any ntfs_error() issued on this path; the super block is not
published yet at this point, so the temporary flag is not visible
elsewhere.

Restore read-write access only if the check succeeded and no errors
were recorded earlier during the mount, e.g. when loading the LogFile,
so that a volume with recorded errors stays read-only, matching what
ntfs_reconfigure() enforces for remounts, and a message is logged for
that case.

Fixes: 6251f0b0de7d ("ntfs: update super block operations")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
Change in v4:
 -Rework the errors=panic handling per review feedback.
---
 fs/ntfs/super.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index f4a73e45773d..473c76d2962f 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1398,6 +1398,7 @@ static bool load_system_files(struct ntfs_volume *vol)
 	struct ntfs_attr_search_ctx *ctx;
 	struct restart_page_header *rp;
 	int err;
+	bool temporary_ro = false;
 
 	ntfs_debug("Entering.");
 	/* Get mft mirror inode compare the contents of $MFT and $MFTMirr. */
@@ -1572,8 +1573,20 @@ static bool load_system_files(struct ntfs_volume *vol)
 	 * NVolErrors() without setting the dirty volume flag and mount
 	 * read-only.  This will prevent read-write remounting and it will also
 	 * prevent all writes.
+	 *
+	 * The check runs with the super block temporarily marked read-only, so
+	 * that ntfs_error() calls issued internally by ntfs_lookup_inode_by_name()
+	 * and ntfs_iget() cannot trigger errors=panic before the read-only
+	 * fallback has run.  The super block is not published yet, so the flag
+	 * is not visible elsewhere.
 	 */
+	if (!sb_rdonly(sb)) {
+		sb->s_flags |= SB_RDONLY;
+		temporary_ro = true;
+	}
 	err = check_windows_hibernation_status(vol);
+	if (temporary_ro && !err && !NVolErrors(vol))
+		sb->s_flags &= ~SB_RDONLY;
 	if (unlikely(err)) {
 		static const char *es1a = "Failed to determine if Windows is hibernated";
 		static const char *es1b = "Windows is hibernated";
@@ -1581,12 +1594,27 @@ static bool load_system_files(struct ntfs_volume *vol)
 		const char *es1;
 
 		es1 = err < 0 ? es1a : es1b;
-		/* If a read-write mount, convert it to a read-only mount. */
-		if (!sb_rdonly(sb) && vol->on_errors == ON_ERRORS_REMOUNT_RO) {
+		/*
+		 * A Windows hibernation image is not a filesystem error, so
+		 * this is a safety interlock rather than something the
+		 * errors= policy may downgrade: always convert a read-write
+		 * mount to read-only.
+		 */
+		if (!sb_rdonly(sb))
 			sb->s_flags |= SB_RDONLY;
-			ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
-		}
+
+		ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
 		NVolSetErrors(vol);
+	} else if (unlikely(temporary_ro && sb_rdonly(sb))) {
+		static const char *es1 = "Errors were recorded during mount";
+		static const char *es2 = ".  Run chkdsk.";
+
+		/*
+		 * Errors were recorded during the check or earlier, e.g. when
+		 * loading the LogFile.  Stay read-only, like ntfs_reconfigure()
+		 * does for volumes with recorded errors.
+		 */
+		ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
 	}
 
 	/* If (still) a read-write mount, empty the logfile. */
-- 
2.25.1

