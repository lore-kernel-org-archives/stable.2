Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A12233941;
	Mon,  7 Sep 2026 03:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788753457; cv=none; b=Llk2J8KOHOk/ckuvUVEf4LzT7KlL+Z59yNV1m6KW5RjIOTFXU9ZsA2cZ0qfua9Nsgq4A/Oil0UYOiSIoOrwBO3T7nAeQeplOg6/HO+qQuSAm+2OeVRG29wsPIv0LBOl64AEQfVS5BMABcGOpMPXBh8rPQvpVzIlrLO67hG6vTcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788753457; c=relaxed/simple;
	bh=kma4mUAUDJmF+5dZ2LHY4giyuPzc4s8G1E3+nVIDEEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sF7X4e97xCJV7SeP6iHurgxaGZh6AAq1vN8fH8BjM+FlbHDYwR2f8Jw0jyqjgBOs1x2zhPF01bWDzBKHalnyyJfRmV+LM0NE6svteLJSAL0WQiI0LwvARWiGwBs6nVZS4Lz7IDkpOvHz5lEXBIG7PXwoIia2Eel87gNecPSrPvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3fb16b22aa7011f19a56ed5b684f684d-20260907
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:028ed24d-e7ae-4af2-bbec-f663971b1293,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:ffde442494582dbbf79986379ca5ccd3,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:-3,I
	P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3fb16b22aa7011f19a56ed5b684f684d-20260907
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 326362453; Mon, 07 Sep 2026 11:57:30 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: use fatal_signal_pending() for fallocate interruption checks
Date: Mon,  7 Sep 2026 11:57:26 +0800
Message-Id: <20260907035726.37123-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fallocate implementation uses signal checks to let a long allocation
loop abort early.  However, signal_pending() also returns true for
TIF_NOTIFY_SIGNAL, which io_uring uses to deliver task_work completions
to the submitting task.

generic/616 is an io_uring fsx soak test that issues fsx-style
read/write requests through io_uring and calls fallocate() directly in
between.  A pending io_uring task_work notification can therefore make
signal_pending() true inside ntfs_attr_fallocate() even though no real
signal was delivered.

That caused the previous signal-interruption patch to return -EINTR for
an io_uring notification, which fsx treats as a fatal failure.  Switch
both checks to fatal_signal_pending() so only fatal signals interrupt
the allocation loop.  A real fatal signal still returns -EINTR, and any
other error still takes precedence.

Fixes: 4dc8f4ee2d46 ("ntfs: handle signal interruption in fallocate")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/attrib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 848a0d338b89..5f761a3b29f4 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -5708,7 +5708,7 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 						goto out;
 				}
 
-				if (signal_pending(current))
+				if (fatal_signal_pending(current))
 					goto signal_out;
 
 				vcn += alloc_cnt;
@@ -5729,7 +5729,7 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 					    try_alloc_cnt, &balloc, false, false);
 		up_write(&ni->runlist.lock);
 		mutex_unlock(&ni->mrec_lock);
-		if (err || signal_pending(current))
+		if (err || fatal_signal_pending(current))
 			goto signal_out;
 
 		vcn += alloc_cnt;
-- 
2.25.1

