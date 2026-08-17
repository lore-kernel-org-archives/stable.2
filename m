Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA7942CB0D;
	Mon, 17 Aug 2026 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979623; cv=none; b=bpp/8ddEbFqTHODp2dn5vfIocD7J/INr4D/feh99znb5dJt9OqIP72p8IFqZt7OPxZSgNuugFZ5vnHkNqgqWs4HR+CTWVEma3lAeR30zlQQ6+6TGIIZ/vB2ml8gxOmMu0uc1Usm4jj94Z1Ylq96j3QXwlXcXKNk/WRGBpje/deM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979623; c=relaxed/simple;
	bh=UK919ur0Crj2WKAHkdqqE7j2Wn/t+VvslJgIQXR+SUU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XoE7zzVNBJxxhLOjar+fffu6Sy5R2SKRbn3Bkucr4JP8NrahMBvivkgQ0f2OBWxqo0zOWlkW0XkfPAJ/MBtcOa0vhnQoztdVvmstPytUoxXVyhEN7z9/u1Y02HgzB1a1la0XWuljrQn4xmy8YwLcFXlfiBdYn+BZi145NLZ7Wbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 35ff55269a4e11f19a56ed5b684f684d-20260817
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, UD_TRUSTED
	CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:9b1c82c8-673e-4abf-bf35-5398e5da9fa0,IP:10,
	URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.19,REQID:9b1c82c8-673e-4abf-bf35-5398e5da9fa0,IP:10,UR
	L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:7db8b62,CLOUDID:ec3bcec95b7a91d83ef71b9eea5389b7,BulkI
	D:260817231335EZOKGL7X,BulkQuantity:0,SF:10|38|66|78|102|127|850|865|898,T
	C:nil,Content:0|15|50,EDM:-3,IP:-2,URL:93|82|11|1,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 35ff55269a4e11f19a56ed5b684f684d-20260817
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(120.227.38.248)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2076017799; Mon, 17 Aug 2026 23:13:32 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: skalluru@marvell.com,
	manishc@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: vadim.fedorenko@linux.dev,
	dmitry@broadcom.com,
	eilong@broadcom.com,
	ariele@broadcom.com,
	yuvalmin@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] bnx2x: fix NULL pointer dereference in bnx2x_free_mem_bp()
Date: Mon, 17 Aug 2026 23:13:26 +0800
Message-Id: <20260817151326.765824-1-yijiangshan@kylinos.cn>
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

Move the bp->fp_array_size assignment to after bp->fp is set so that
the loop in bnx2x_free_mem_bp() naturally becomes a no-op when bp->fp
is NULL, since bp is zero-initialized and fp_array_size remains 0.

Fixes: c3146eb676e7c ("bnx2x: Correct memory preparation and release")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260815122149.951215-1-yijiangshan@kylinos.cn
Suggested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>

---
Changes in v2:
- Remove the defensive NULL guard in bnx2x_free_mem_bp() as suggested
  by Vadim Fedorenko, since the assignment-order fix alone is sufficient
  to prevent the NULL pointer dereference (bp is zero-initialized so
  fp_array_size remains 0 when allocation fails).

 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 5b2640bd31c3..926ffe3e2c43 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -4742,13 +4742,13 @@ int bnx2x_alloc_mem_bp(struct bnx2x *bp)
 
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

