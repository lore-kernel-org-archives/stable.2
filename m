Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA2538AC75;
	Wed, 26 Aug 2026 06:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787724006; cv=none; b=AHx63kfD7AFLmzht6s96/VkMmHyWsB2q7s76wGHr9bXU2DjdoB6UPRQWxGx2mstn79Y+1X3Cd8FxZP2TZn+Urs4KtfUSPPPlUOooWyzCV95LMBrX1uXalIanxbD2HBHeLy0XdCd88us+zKn9WcAWhTacmKla7Mh/sHN3BKQ046o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787724006; c=relaxed/simple;
	bh=dJ8zHLxh75koeGnAhUjt/ZtyAlrqxVcaqAAHLkZIpl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bbQu4u62EHQgTETfGB4+zVFHXDFgQtC7Fab55W+AUuWL8AnQDirfqA1iNUArsi9vqh7FmcgGuXRLGOp44Nf/3H27dWAOkoAbHCSDASRy7woK2yn/nzF0x5C64dhO0PYLa2yVcCeLzZowsGw4QiTIjaRCAd9f/lUMFYRSiutzRdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5e22f32aa11311f19a56ed5b684f684d-20260826
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a9f11fd1-1881-4dac-a326-ecbf187bef64,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:d615874be65cdd41e698268807d626b7,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5e22f32aa11311f19a56ed5b684f684d-20260826
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1797813150; Wed, 26 Aug 2026 13:59:58 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: handle signal interruption in fallocate
Date: Wed, 26 Aug 2026 13:59:53 +0800
Message-Id: <20260826055953.1372417-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ntfs_attr_fallocate() function checks for pending signals during
allocation loops and exits early via 'out' label. However, when a signal
interrupts the operation with err == 0, the function returns 0 (success)
instead of -EINTR.

The signal_pending() checks at the allocation loops jump to 'out' without
setting err = -EINTR, so the function returns success even when interrupted
by a signal.

Set err = -EINTR when jumping to the signal exit path, and only override
when no other error is pending. This ensures:

- Allocation interrupted by signal returns -EINTR
- Allocation that completed successfully before signal arrived returns 0
- Other errors are preserved and not overwritten by -EINTR

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/attrib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 60264833bb63..c898250f63a7 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -5709,7 +5709,7 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 				}
 
 				if (signal_pending(current))
-					goto out;
+					goto signal_out;
 
 				vcn += alloc_cnt;
 				try_alloc_cnt -= alloc_cnt;
@@ -5730,7 +5730,7 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 		up_write(&ni->runlist.lock);
 		mutex_unlock(&ni->mrec_lock);
 		if (err || signal_pending(current))
-			goto out;
+			goto signal_out;
 
 		vcn += alloc_cnt;
 		try_alloc_cnt -= alloc_cnt;
@@ -5756,4 +5756,8 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 	mutex_unlock(&ni->mrec_lock);
 out:
 	return err >= 0 ? 0 : err;
+signal_out:
+	if (!err)
+		err = -EINTR;
+	goto out;
 }
-- 
2.25.1

