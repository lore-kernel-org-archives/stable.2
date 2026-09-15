Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900394BEE3C;
	Tue, 15 Sep 2026 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789435838; cv=none; b=UKM6qDdfvJ+R5ihWJDfzt6fWCidrc5wS7WRrByJvHboQoBuprcFxbKar+xeavqKMSYyj3NSNbBhh9UhxAoN82gWPS4PDWlJtzMWX3b2RacDZXnDVNjwgYHWsukcS00V6rCS23x2m95QKvoPaIpfOxCjsvjJhbgDN+wzMPI45TBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789435838; c=relaxed/simple;
	bh=/I50m7a4WKXHFAuWsniE8i9HRfMHSni30uWQ4dIoWCg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nDj4zTDGnhTi8nmat7Hd2gAZ3AXWnZdfq/mELyZBpDwNjj3sWlu0r8se7cmPALE4fLHZzULE9oQqfg40B1cwKjJcdxyPgIVOfXBmpCGOLSLTOtjz9kPw9sEUc2GNTDQGTVYSs/F3vowpXrmt1r9MZZXmhyzXz3c5eVo16bG10UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 08bb06d8b0a511f19a56ed5b684f684d-20260915
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ef20ea7d-ff72-4a5d-8c3c-1432955eebab,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:6e3aac37ac13965ee18af95cb41b4e8f,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 08bb06d8b0a511f19a56ed5b684f684d-20260915
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 62298538; Tue, 15 Sep 2026 09:30:28 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] ntfs: mount hibernated volumes read-only regardless of errors=
Date: Tue, 15 Sep 2026 09:30:25 +0800
Message-Id: <20260915013025.584481-1-zenghongling@kylinos.cn>
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

Also downgrade the ntfs_error() calls inside
check_windows_hibernation_status() to ntfs_debug(): they ran before
SB_RDONLY was set, so errors=panic could panic inside the helper
before the read-only conversion was reached.  The caller already
reports "Failed to determine if Windows is hibernated." for these
cases, so nothing is lost.

Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
Changes in v2:
 -Remove the internal ntfs_error() calls
---
 fs/ntfs/super.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 2d4132aa39d3..93a3679585c2 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1242,7 +1242,7 @@ static int check_windows_hibernation_status(struct ntfs_volume *vol)
 			return 0;
 		}
 		/* A real error occurred. */
-		ntfs_error(vol->sb, "Failed to find inode number for hiberfil.sys.");
+		ntfs_debug("Failed to find inode number for hiberfil.sys.");
 		return ret;
 	}
 	/* Get the inode. */
@@ -1250,7 +1250,7 @@ static int check_windows_hibernation_status(struct ntfs_volume *vol)
 	if (IS_ERR(vi)) {
 		if (!IS_ERR(vi))
 			iput(vi);
-		ntfs_error(vol->sb, "Failed to load hiberfil.sys.");
+		ntfs_debug("Failed to load hiberfil.sys.");
 		return IS_ERR(vi) ? PTR_ERR(vi) : -EIO;
 	}
 	if (unlikely(i_size_read(vi) < NTFS_HIBERFIL_HEADER_SIZE)) {
@@ -1261,7 +1261,7 @@ static int check_windows_hibernation_status(struct ntfs_volume *vol)
 
 	folio = read_mapping_folio(vi->i_mapping, 0, NULL);
 	if (IS_ERR(folio)) {
-		ntfs_error(vol->sb, "Failed to read from hiberfil.sys.");
+		ntfs_debug("Failed to read from hiberfil.sys.");
 		ret = PTR_ERR(folio);
 		goto iput_out;
 	}
@@ -1660,8 +1660,13 @@ static bool load_system_files(struct ntfs_volume *vol)
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
+		if (!sb_rdonly(sb)) {
 			sb->s_flags |= SB_RDONLY;
 			ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
 		}
-- 
2.25.1

