Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8C381AE7;
	Thu, 27 Aug 2026 03:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787800622; cv=none; b=l/tgH9EdrQUOHRdFs2pltGeFkN97EIuLAtz49xXgsu+GMVT0ShCfHlmGelxYu5nPyobSGi8fyjharkPdJIp8/ZoNrA/yTzkXCN2OYFzp7P6llgaXrAHYhJYUhXn6SzgCICp9Bkn4wnFMvayp0pZeAf/2OtWIVqZuqH2NBfRl4W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787800622; c=relaxed/simple;
	bh=1wGgYx6t9NA/s8wHsgVerN0LkkIJ/pt7uFDcTjQBdp8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GDzRUH0dulBbi/f8ffMpnQIve292GWgrotlJw+anpP9LpEAnMpkrxYmabj9SYTEGBDXrwJpWeJnFETgWyDdcXuqrY9MUeBobNe8UDZLVOw/1ll+cZweQLaMUQOHf3u7sTeqyExZqdPikSUQmg9hz6uvMwV2pr5D5zRJGcR7hEB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bf442b3aa1c511f19a56ed5b684f684d-20260827
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:fafcaca3-d535-4338-8078-579238d04a9d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:20a794283dbf81c279d112d6142dbe5d,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bf442b3aa1c511f19a56ed5b684f684d-20260827
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 745407325; Thu, 27 Aug 2026 11:16:51 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v2] ntfs: fix race between fallocate and mmap reads
Date: Thu, 27 Aug 2026 11:16:46 +0800
Message-Id: <20260827031647.1605970-1-zenghongling@kylinos.cn>
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
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
---
Change in v2:
 -Remove now-unnecessary map_locked variable.
---
 fs/ntfs/file.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 88747217ba61..779baafa0319 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1153,11 +1153,8 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 	}
 
 	inode_dio_wait(vi);
-	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
-		    FALLOC_FL_INSERT_RANGE)) {
-		filemap_invalidate_lock(vi->i_mapping);
-		map_locked = true;
-	}
+	/* Take invalidate_lock for all fallocate operations to prevent races */
+	filemap_invalidate_lock(vi->i_mapping);
 
 	switch (mode & FALLOC_FL_MODE_MASK) {
 	case FALLOC_FL_ALLOCATE_RANGE:
-- 
2.25.1

