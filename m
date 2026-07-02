Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F824779B2;
	Thu,  2 Jul 2026 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983203; cv=none; b=ExG2PSQ+z6Pj2J81jaEDSGCiMK+QwSmIcTxv7xmWhPGRRohtyqTmkCe/AvRGudm2tDGRXZnODB8YLsMJv79vM4pldTJzx8kAmXsrBfViwI1mzHLADTdtFPMQUQ0enqQ/0YweO8nGlR98MMrUVwjwizSZgZWHwngkC1oDktyzS1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983203; c=relaxed/simple;
	bh=paeJ6N/zOIWf2OTu4MP/lvXFHnBVyM5L4zFs3D6HYTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cO1TxyVHb5EVopjC9LM5XwXw4BQksnrurPgmeFgmmk7GSUlgHV/UCvpzHDI7cIaNsmEw//y+E0c9+nVPI0cbYzjmMoR16yZElkRgCD1HgFsmSmXiSJb21eGw7vyquRje1j6IZTJLZtdS/+9Q+mRlLDSKm4zQdwno27B2r98bI4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 50f5ec6e75f511f1aa26b74ffac11d73-20260702
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:14ab24ed-4009-4406-a230-de37b1edb84e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:26963ad976ddc72858b1aebe1f905030,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 50f5ec6e75f511f1aa26b74ffac11d73-20260702
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1340896409; Thu, 02 Jul 2026 17:06:31 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com,
	charsyam@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] ntfs: prevent write access to $MFT inode
Date: Thu,  2 Jul 2026 17:06:27 +0800
Message-Id: <20260702090627.137915-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Malicious NTFS images can expose $MFT to userspace and allow write
operations, leading to potential kernel NULL pointer dereference
since ntfs_mft_aops lacks write_begin support.

The vulnerability affects both write_iter and mmap-based write paths:
1. write_iter path: ntfs_file_write_iter()
2. mmap write path: ntfs_filemap_page_mkwrite()

Without protecting both paths, attackers can bypass single-path
protection by using the alternative write method.

Fix by adding write protection in ntfs_file_write_iter() to prevent
any write operations to FILE_MFT.

Fixes: 1e9ea7e04472d ("Revert \"fs: Remove NTFS classic\"")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

---
Change in v2:
 - Fix format string for u64 mft_no in system file protection
---
 fs/ntfs/file.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 6a7b638e523d..d637d4a587d5 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -550,6 +550,12 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (NVolShutdown(vol))
 		return -EIO;
 
+	if (ni->mft_no < FILE_first_user) {
+		ntfs_error(vi->i_sb, "Attempt to write to $MFT denied (mft_no: 0x%llx)",
+				ni->mft_no);
+		return -EACCES;
+	}
+
 	if (NInoEncrypted(ni)) {
 		ntfs_error(vi->i_sb, "Writing for %s files is not supported yet",
 			   NInoCompressed(ni) ? "Compressed" : "Encrypted");
@@ -618,8 +624,15 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 static vm_fault_t ntfs_filemap_page_mkwrite(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct ntfs_inode *ni = NTFS_I(inode);
 	vm_fault_t ret;
 
+	if (ni->mft_no < FILE_first_user) {
+		ntfs_error(inode->i_sb, "Attempt to write to $MFT via mmap denied (mft_no: 0x%llx)",
+				ni->mft_no);
+		return VM_FAULT_SIGBUS;
+	}
+
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vmf->vma->vm_file);
 
-- 
2.25.1

