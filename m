Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB512DF142;
	Wed, 26 Aug 2026 05:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787722941; cv=none; b=Ir+QyTfQzEAYbu86U2mO5jS7RMHPPfsA9Xz3I4cNGr3fO7/pbtEr9AnZab1TT0uoON8B3XQfvnfDBMCa0WD7ChY3hoBA7+Ka1S7+2LYe3DhSimzA9SvSM0oGuS9xX4pB26otmfrW6mdFQeUul3MPu9VEEO5QZoE39RGxGOCIC4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787722941; c=relaxed/simple;
	bh=pDmQaGK+0Ostm0KUxDQDQx8yEujpOu+No0rZGKEeTt8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PpiWC014zYQvchZ9YgK++z15cEpbawuQ2r7IrfTmZzYP18mK2jqL33Qil+9co+NnjrJ35VsN8YRadpgY2Mn25wIH4cWR67Iv1wurJjJFPjwruwM4xWbwlvKXuI8AeELSZ3fSSRBi3G2/EGfe3jzfODdrmWlnZVBHA2+646I51Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e10db5fca11011f19a56ed5b684f684d-20260826
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:f8a2c4fd-12f2-4073-ab85-deef77a6957f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:3a95710aee9e9994cffdb857aa69e56a,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e10db5fca11011f19a56ed5b684f684d-20260826
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 556608147; Wed, 26 Aug 2026 13:42:09 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: fix race between fallocate and mmap reads
Date: Wed, 26 Aug 2026 13:42:04 +0800
Message-Id: <20260826054204.1364589-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fallocate implementation only takes invalidate_lock for punch hole,
collapse range, and insert range operations. For standard allocation modes
(mode == 0, FALLOC_FL_KEEP_SIZE), the lock is not held.

During ntfs_attr_fallocate(), new clusters are mapped to the runlist via
ntfs_attr_map_cluster() before being zeroed by ntfs_dio_zero_range(). This
creates a window where concurrent mmap page faults can read uninitialized
disk data.

Since mmap uses filemap_fault() which takes invalidate_lock in shared mode,
it can fault in pages during this window and expose old disk contents to
userspace. This is an information leak and data integrity issue.

Fix by taking invalidate_lock for all fallocate operations, not just for
punch/collapse/insert modes. This prevents concurrent page faults from
accessing unzeroed clusters during the allocation window.

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/file.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 88747217ba61..6958a1469fb0 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1153,11 +1153,9 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 	}
 
 	inode_dio_wait(vi);
-	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
-		    FALLOC_FL_INSERT_RANGE)) {
-		filemap_invalidate_lock(vi->i_mapping);
-		map_locked = true;
-	}
+	/* Take invalidate_lock for all fallocate operations to prevent races */
+	filemap_invalidate_lock(vi->i_mapping);
+	map_locked = true;
 
 	switch (mode & FALLOC_FL_MODE_MASK) {
 	case FALLOC_FL_ALLOCATE_RANGE:
-- 
2.25.1

