Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A09824679C;
	Mon, 17 Aug 2026 03:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786937625; cv=none; b=IW3lR03aKuLZ+G9sgHszQq2Vwg6Z0mDGJMNwmpQQVBV4jeFyQTJKaE4AKM9civAq7dL7GYIMuLE2EmmGALkEza+viY2Tl08QOu+JCZ7+aKPgev3AyLmDCQvYXOnyaAiLB4vf7FROTHjEiku93+6cn51Ak3YnviE54Cxu//NoQxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786937625; c=relaxed/simple;
	bh=o4ZFtDjMp/xQTvXLSlcRkS0TLvSITxguNOADS/k5KIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lTVNVLYbRffCWr0ZbjJaEtSTTm2Ovsvw3h5O3ch+qM5gOKWJEMAlq9zVtytwq3aaFAGR4ekXIh4bU2gK/jXjGey0ItvaH7U9U+TRMUd088piPnij4YD57T5Sqh3E9wR/ccELoaKxb+0mY/rGzKVfTwxkzRh3HAVUF/3chXGuNl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6e7c6e8299ec11f19a56ed5b684f684d-20260817
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:de35896f-8470-4671-864b-f10df55b0c65,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:7469fe3d93d45aa39f713045c90f7334,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:93|82|11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6e7c6e8299ec11f19a56ed5b684f684d-20260817
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 251126176; Mon, 17 Aug 2026 11:33:37 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: skalluru@marvell.com,
	manishc@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: yuvalmin@broadcom.com,
	dmitry@broadcom.com,
	ariele@broadcom.com,
	eilong@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] bnx2x: fix NULL pointer dereference in bnx2x_free_mem_bp()
Date: Mon, 17 Aug 2026 11:33:32 +0800
Message-Id: <20260817033332.175665-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnx2x_alloc_mem_bp() sets bp->fp_array_size before allocating bp->fp.
If the fp allocation fails, the error path calls bnx2x_free_mem_bp(),
which dereferences bp->fp in a loop bounded by the non-zero
bp->fp_array_size, causing a NULL pointer dereference.

Move the bp->fp_array_size assignment to after bp->fp is set, and
add a NULL guard in bnx2x_free_mem_bp().

Fixes: c3146eb676e7c ("bnx2x: Correct memory preparation and release")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260815122149.951215-1-yijiangshan%40kylinos.cn
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 5b2640bd31c3..d84d1845a096 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -4712,8 +4712,10 @@ void bnx2x_free_mem_bp(struct bnx2x *bp)
 {
 	int i;
 
-	for (i = 0; i < bp->fp_array_size; i++)
-		kfree(bp->fp[i].tpa_info);
+	if (bp->fp) {
+		for (i = 0; i < bp->fp_array_size; i++)
+			kfree(bp->fp[i].tpa_info);
+	}
 	kfree(bp->fp);
 	kfree(bp->sp_objs);
 	kfree(bp->fp_stats);
@@ -4742,13 +4744,13 @@ int bnx2x_alloc_mem_bp(struct bnx2x *bp)
 
 	/* fp array: RSS plus CNIC related L2 queues */
 	fp_array_size = BNX2X_MAX_RSS_COUNT(bp) + CNIC_SUPPORT(bp);
-	bp->fp_array_size = fp_array_size;
-	BNX2X_DEV_INFO("fp_array_size %d\n", bp->fp_array_size);
+	BNX2X_DEV_INFO("fp_array_size %d\n", fp_array_size);
 
-	fp = kzalloc_objs(*fp, bp->fp_array_size);
+	fp = kzalloc_objs(*fp, fp_array_size);
 	if (!fp)
 		goto alloc_err;
 	bp->fp = fp;
+	bp->fp_array_size = fp_array_size;
 	for (i = 0; i < bp->fp_array_size; i++) {
 		fp[i].tpa_info =
 			kzalloc_objs(struct bnx2x_agg_info,
-- 
2.25.1

