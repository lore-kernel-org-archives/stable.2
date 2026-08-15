Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA1D3955CF;
	Sat, 15 Aug 2026 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786796528; cv=none; b=noWtZf+0Yljew7GrpkY+GxLF4l4XjzAmT25caePqANoPJ9I9mQYzOlQRaStgx0vVFNMyWCUPh6oF/b9VjxN1PML3siMVAsCLPQBqY6ZzcLRXEljKS3SycCs5x0jnqP+7IKkK3USY34NiuKGc3QSVG/3dRXSlhorNQwx1p015E5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786796528; c=relaxed/simple;
	bh=5l2zL5dw71luzsXSML5roIyPsJ8k4xPSOwMrGJC8PyA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CTnt/N76cwLrrHqYN2HXCLAfUlSj1D7kJSAhr4s9EB4mLpCJPP6+qKw67G0ECotj/set8KXTCBECGnA5Kz9gfQEE7kcDFxqud9ypGHAHnMEL5ObhqCq1sa6WcMlx7QQA7BDZCxu4g34UCICpes+ZPJ1DcRpC1ZJAtrDZTBUstv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e7578df498a311f19a56ed5b684f684d-20260815
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ca538dfc-363e-4297-bece-360936701f60,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:ca538dfc-363e-4297-bece-360936701f60,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:b57ee303c727c7c0c3cb942751e99da7,BulkI
	D:260815202157VZOPJS5V,BulkQuantity:0,SF:10|38|66|78|102|127|865|898,TC:ni
	l,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e7578df498a311f19a56ed5b684f684d-20260815
X-User: yijiangshan@kylinos.cn
Received: from lazy-pc.www.tendawifi.com [(118.251.48.97)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 932793120; Sat, 15 Aug 2026 20:21:55 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: skalluru@marvell.com,
	manishc@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: vladz@broadcom.com,
	eilong@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] bnx2x: fix double free in bnx2x_init_firmware() error path
Date: Sat, 15 Aug 2026 20:21:49 +0800
Message-Id: <20260815122149.951215-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnx2x_init_firmware() frees bp->init_ops, bp->init_data and
bp->init_ops_offsets in its error path without setting them to NULL.
The cleanup function bnx2x_release_firmware() frees the same three
pointers unconditionally, so if init_firmware fails and
release_firmware is later called (e.g. from __bnx2x_remove or through
the function state machine), all three are freed a second time.

Set each pointer to NULL after kfree() in the error path so that the
subsequent kfree(NULL) in bnx2x_release_firmware() is a safe no-op.

Fixes: 94a78b79cb5f ("bnx2x: Separated FW from the source.")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 208a894d6190..39eb6ab5f805 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -13473,10 +13473,13 @@ static int bnx2x_init_firmware(struct bnx2x *bp)
 
 iro_alloc_err:
 	kfree(bp->init_ops_offsets);
+	bp->init_ops_offsets = NULL;
 init_offsets_alloc_err:
 	kfree(bp->init_ops);
+	bp->init_ops = NULL;
 init_ops_alloc_err:
 	kfree(bp->init_data);
+	bp->init_data = NULL;
 request_firmware_exit:
 	release_firmware(bp->firmware);
 	bp->firmware = NULL;
-- 
2.25.1

