Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CF93B3C03;
	Mon, 24 Aug 2026 05:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787550094; cv=none; b=abk00ubdYDwCZqAVJS7hQmj2fmWLeEH8bJIjAoXUS0cwOP0kjY0buNLeincau65udsKvkQ51uN4LaKpPM4lb1YpqaGW1iVnNnO7McUb8cPqn5wJY8dlGrk2TiWhHihRLX6jTdtmhXon2Zs9yMpxYQa6XdFXnZAfnakYl4QRVYQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787550094; c=relaxed/simple;
	bh=NF7lboaT/MIAPrhN6G2JKcH23qalZr1XjvTBs/htLac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s0GRaOnzuE07pujkw8k4VAAuLXkYirDGPsx7GrDReb5FHC0XpLS4LmmNAb7zk+TJzov210F8FFx1q/3wLKlT4vNoDebNa4WDNqGg36D6Bpw7AR9alX/FNl56KjevWYFbVG90SD905K0c+SI/uJm7gd8TPnbxyJaGkASQNeSQois=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6f8a207a9f7e11f19a56ed5b684f684d-20260824
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:c1dc5e5e-7a8d-405f-8d24-c71256597c07,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:40aa8729b74a1a0fb2292b485c72c83a,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6f8a207a9f7e11f19a56ed5b684f684d-20260824
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 627349228; Mon, 24 Aug 2026 13:41:21 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: fix incorrect MFT record pointer passed to ntfs_attr_record_resize
Date: Mon, 24 Aug 2026 13:41:15 +0800
Message-Id: <20260824054115.114298-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_new_attr_flags() passes the wrong MFT record to ntfs_attr_record_resize().
When the attribute is in an extent record, ctx->mrec points to the extent
but the function receives the base record pointer m, causing incorrect
size calculations in memmove.

Fix by passing ctx->mrec (the actual MFT record containing the attribute)
instead of m (the base MFT record) to ntfs_attr_record_resize().

Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/ea.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
index 44252f2c2ca6..534f7efaf128 100644
--- a/fs/ntfs/ea.c
+++ b/fs/ntfs/ea.c
@@ -740,7 +740,7 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni, __le32 fattr)
 			memmove((u8 *)a + mp_ofs, (u8 *)a + old_mp_ofs, mp_size);
 	}
 
-	err = ntfs_attr_record_resize(m, a, arec_size);
+	err = ntfs_attr_record_resize(ctx->mrec, a, arec_size);
 	if (unlikely(err))
 		goto err_out;
 
-- 
2.25.1

