Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF22915B135;
	Wed, 19 Aug 2026 06:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787122620; cv=none; b=uFgmKHeH6cTEeqvVdjklNvKBzaIHVzwGnPhQ17OExoBapuZEmSfhrysCd/bXzjHc9PrX7YpeoI8IMOmGO09u7hdsgGyBe/8YYi3HbKBtUCU3UVNV7vYHPEOmuS3KqRujv0V7akafSlWWW8aMbStVrPag6ySqtrF//xpZa4JdgRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787122620; c=relaxed/simple;
	bh=DG6poT1c/oAenm4Es+vS+AaqQ8Aqj+wXCG+He7Eo+8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MQZxgR/xVJUcKlsl9K5Qed0mzf+LgGvzq8EzYaJErABLgDeRTDAQVreKZ7uoybNmeXjTrKkqcnrRlP+KXKO3aDL0KgSLgUGtKhMCdGJUhVcE4/f+VbCl7u1LZHDMB61587XJIl+V7im4OC/gBlip80KDTfB8SC37OTYu9f5IAKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 258fe27a9b9b11f19a56ed5b684f684d-20260819
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_UNTRUSTED, SA_LOWREP, SA_EXISTED, SN_UNTRUSTED
	SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:14351af9-7b94-451e-b8b2-97d7ef248d47,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.19,REQID:14351af9-7b94-451e-b8b2-97d7ef248d47,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:7db8b62,CLOUDID:bf9deac3ab9311691c320776cfe18c39,BulkI
	D:260819145651KAPDYLPA,BulkQuantity:0,SF:19|38|66|72|78|102|127|850|865|89
	8,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 258fe27a9b9b11f19a56ed5b684f684d-20260819
X-User: lihaojie@kylinos.cn
Received: from localhost.localdomain [(223.104.132.130)] by mailgw.kylinos.cn
	(envelope-from <lihaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 405249312; Wed, 19 Aug 2026 14:56:47 +0800
From: Haojie Li <lihaojie@kylinos.cn>
To: chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Haojie Li <lihaojie@kylinos.cn>
Subject: [PATCH] drm/mediatek: Add missing IS_ERR check for ovl_adaptor platform device
Date: Wed, 19 Aug 2026 14:56:42 +0800
Message-Id: <20260819065642.136222-1-lihaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

platform_device_register_data() can fail and return an ERR_PTR, but the
return value is used without checking, leading to an invalid pointer
being stored in ddp_comp[].dev and passed to component_match_add() and
mtk_ddp_comp_init(), which could result in a kernel crash.

Add an IS_ERR() check to jump to the error handling path on failure.

Fixes: 0d9eee9118b7 ("drm/mediatek: Add drm ovl_adaptor sub driver for MT8195")
Cc: stable@vger.kernel.org
Signed-off-by: Haojie Li <lihaojie@kylinos.cn>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index c86a3f54f35b..667d7fdbfbac 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -1112,6 +1112,10 @@ static int mtk_drm_probe(struct platform_device *pdev)
 							    PLATFORM_DEVID_AUTO,
 							    (void *)private->mmsys_dev,
 							    sizeof(*private->mmsys_dev));
+		if (IS_ERR(ovl_adaptor)) {
+			ret = PTR_ERR(ovl_adaptor);
+			goto err_node;
+		}
 		private->ddp_comp[DDP_COMPONENT_DRM_OVL_ADAPTOR].dev = &ovl_adaptor->dev;
 		mtk_ddp_comp_init(dev, NULL, &private->ddp_comp[DDP_COMPONENT_DRM_OVL_ADAPTOR],
 				  DDP_COMPONENT_DRM_OVL_ADAPTOR);
-- 
2.25.1

