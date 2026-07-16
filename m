Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4841E0B9C;
	Thu, 16 Jul 2026 06:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184771; cv=none; b=rgqfHgKWIpJZpLTZjlrrnO0MRFp8nN/pF5P762gga82fLBY9vcxzp0WgMTMhIsYJKMzBmVBLz8ooYWklI4T27lvI6N6GIv83SR1gAD8F0FirYwWpoegFCVvTecUmy6MWI5cwUkpetRzpz3+SBo/cDudHBOrO+IGHOGKTqZXlWKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184771; c=relaxed/simple;
	bh=PI4Pw1JdNE2yGPDler11rAGo5jXk9osC7hMgOAM0zrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lVpHGa0E6u/PeFhyUshk68/KS4XLRwWd54KSUHql72WM+T8aJZq/ZcEhwWMwpfP9TWD4DL6lQXjnjGuPI5yxUmOIiwax7QFkXWxw6ApobiGH0fFcyhlt9eHfIi1fLM1XDOJGyV/v2uxphUG7CS7vjvhKijC0jUfkgpniSFlnVww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f16629a080e211f1aa26b74ffac11d73-20260716
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b851bdb5-e949-4d71-8483-07a832b03d0c,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:b851bdb5-e949-4d71-8483-07a832b03d0c,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:8535b07d34f1815adba18499d605d937,BulkI
	D:260716145245NEMXN3OL,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|123|127
	|136|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bul
	k:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f16629a080e211f1aa26b74ffac11d73-20260716
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 586882134; Thu, 16 Jul 2026 14:52:42 +0800
From: zhaoguohan@kylinos.cn
To: "Rob Herring (Arm)" <robh@kernel.org>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	dri-devel@lists.freedesktop.org
Cc: Oded Gabbay <ogabbay@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] accel/ethosu: check MMIO mapping errors in probe
Date: Thu, 16 Jul 2026 14:52:19 +0800
Message-ID: <20260716065219.931088-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

devm_platform_ioremap_resource() returns an error pointer when the register
resource cannot be mapped. ethosu_probe() stores it and continues until
initialization dereferences it through MMIO accessors.

Return the mapping error before initializing the device.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 drivers/accel/ethosu/ethosu_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index ed9c748a54ad..b2901eb8a7a0 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -342,6 +342,8 @@ static int ethosu_probe(struct platform_device *pdev)
 	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
 
 	ethosudev->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ethosudev->regs))
+		return PTR_ERR(ethosudev->regs);
 
 	ethosudev->num_clks = devm_clk_bulk_get_all(&pdev->dev, &ethosudev->clks);
 	if (ethosudev->num_clks < 0)
-- 
2.43.0

