Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1134DD6FD
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647374; cv=none; b=TmB/NxQFT5zKHLD1bfoXdagvJZAAxdU1ViuCpB8sC5T5q44zuqMSy5sY44AfLaKYZPqYXcNMRdfr3jYmkCLk7J1y7M1fQirRJS5xTebtizORU24kPmKQV2OxVWdnLT2Cg868o2UD22QS7R8dgko/aucZ5dX0wo/D4UZlgf8GtdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647374; c=relaxed/simple;
	bh=vymvzdq6k/6TlyDR7YkwC0qyXhOrNERQdYig/qlY66I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gxGC3lm8DxNNA0ThbH4Xdr0MR0f+reA+gTqTjfuxCVspXxBOPQft7lRUz4l3DAIucvm6KpMmJylhxr3QTLzSsZ8zLXi6Y6u7dYdYa8FREkASQL0X8af4NT0DV/BbR7y44HZd2XNh8j717Ezqym54gSS8JzHTd92sOwQA0WKLLCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwUzUAge; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwUzUAge"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38deea72eebso9511418a91.1
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784647372; x=1785252172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9eXHmL2FrSSPACEJW/ZdN2+RZSdHtJBbjO91JeCFP0A=;
        b=TwUzUAgevKGXxz6jo86T8Cm5ePzayIHClVUrAkEQnLrTEE6t2QpFUigyy9zARqtfA9
         L97vknLXEnlDFOZjn2xcA498vqZ2FYI8IE5V+b/VGo/8HN4K5dmywc0cJVJ2XV9ef8t/
         Ug4oZAV+inktHs/bOnJneYpiVKadPxcsVRqQSGaJt0y9YFUVD2MGlckPRc6tLpsWu3pt
         qiAyOOZovtpC9bTCXhTqVXTSQ7i5zxLr+KXAUcYym4QXRRJ/S9T7LZQ9i5F1DZ7mczgg
         jpnEQ9qe6LbFzlzO96xrYQs2CqwJq+SN+6jO8f0vuY3p8PkdtNF81dlRFQ37Gpe3Fc5e
         DSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784647372; x=1785252172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9eXHmL2FrSSPACEJW/ZdN2+RZSdHtJBbjO91JeCFP0A=;
        b=kOHvXwsxDV/Q8kuqQRZkKT3D+oiR+Hm2fghqaMx2p3cv0HbQZYRSw35TybHOsc8yu+
         2XyjbyiVH5jdmPfufb+zx4mx52NYQgOTi/izTusq4M3loXbUNcGhGuJwCG7FMRPg35HW
         Hm9WoU0qQrpPcIbLpKySwUXAJUviepEhB++xj85liF6qxyx4VgWYYjlbWg5jH6wjlN0u
         t3FIFnLkhV+z9lOtziEnJxr+h3Cct7qXy8B8yQ9vkWurH3rexy2cuwn8odDxVfA6y0MP
         gKjo/PwObrKXiJe3Yp7hDlQhCQaDGlU01MvWGITN4nZ+rcL/Tsiq7tf2WOHt8f4DwS7y
         iCow==
X-Forwarded-Encrypted: i=1; AHgh+RrqkQS6VfxsQQeGiFUON4ni9Z0qoRuYTbDoUNHSxgZR4lnv7aMdZYuNTsURK15nUy32c3Av4kI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmZguzbWvXkxe7ukpRhTtxU0C85Uub4lbklsKr+iO5eA5qFlX3
	onqUdtVaduP2o791Jq+hObHwe0J1l8mXxUaxvYqfqou5ToNxkL4Ze/0=
X-Gm-Gg: AR+sD119tq+G5TmxI9KaokZXSvHPYydUPa/yBvT9NbwjsIkzcTUq267xOvMCf+I0v7z
	hlBxWuD5EQRnh0kTA4I8RbRb+C6kYup6VMPzRuC//HcRN4Lq5WfMNnZiZDacgBhpbSmS4WRkgr3
	x3XqsUGye+IGhpRHEwrWPoJNej2WzzlnzuQeL4WzWAWASmrktSNH6t0XRocQratsuA+tJ25SC/8
	AnmcsdLWcCJSeSSJCIBSBCvft8071hpkuLCGfzkLWav6D8eL+4DNZHdQPPgARI4w6CvKqmfGkPb
	pAXdeCb0oahDQjj85kEHJ9xi2xOXyHIRG+cBB+0ktpSyZd+JWU8sE4niqYjGaMsHMAxl/al71kH
	uRz/O/cLdBpSMGHB7jPiVpxojYILNy8Em10flgfjufs7Kz6XrugFpo5jlePgA8PgKSCEIqb5Yzm
	6Jfh64nYzofFo3Q/Zi75SB1omztu/4/kdQMtCb5b+2pl4UmQUIQhRXgEXHUWqPpI6XidvUm1t88
	Guprsu324eRHnUFSCTKZrkBib4cz4RqjuO9IGwi
X-Received: by 2002:a17:90b:1c02:b0:38e:2aa8:60d0 with SMTP id 98e67ed59e1d1-38e4b586067mr20371153a91.37.1784647371935;
        Tue, 21 Jul 2026 08:22:51 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e60cc2ad5sm1402904a91.4.2026.07.21.08.22.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jul 2026 08:22:51 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/mediatek: ovl_adaptor: balance component registrations
Date: Wed, 22 Jul 2026 00:22:42 +0900
Message-Id: <20260721152242.47138-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OVL adaptor registers both an aggregate driver for its child devices
and a component for the main DRM aggregate. Probe currently ignores an
error from registering the child aggregate and leaves that aggregate
registered if registering the DRM component fails. The remove callback
also leaves the DRM component registered.

These imbalances can leave component framework entries referring to a
device whose probe failed or whose driver has been detached. The aggregate
unbind callback also fails to undo component_bind_all(), leaving its child
components marked as bound when the aggregate is removed.

Check the aggregate registration result, unwind it when the component
registration fails, and unregister the component before the aggregate on
remove. Keep runtime PM enabled until both framework registrations have
been removed, and unbind all child components from the aggregate unbind
callback.

Fixes: 453c3364632a ("drm/mediatek: Add ovl_adaptor support for MT8195")
Cc: stable@vger.kernel.org # 6.4+
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index c0af3e3b5..6a259872b 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -625,6 +625,7 @@ static void mtk_disp_ovl_adaptor_master_unbind(struct device *dev)
 	struct mtk_disp_ovl_adaptor *priv = dev_get_drvdata(dev);
 
 	priv->children_bound = false;
+	component_unbind_all(dev, priv->mmsys_dev);
 }
 
 static const struct component_master_ops mtk_disp_ovl_adaptor_master_ops = {
@@ -651,12 +652,15 @@ static int mtk_disp_ovl_adaptor_probe(struct platform_device *pdev)
 
 	priv->mmsys_dev = pdev->dev.platform_data;
 
-	component_master_add_with_match(dev, &mtk_disp_ovl_adaptor_master_ops, match);
+	ret = component_master_add_with_match(dev, &mtk_disp_ovl_adaptor_master_ops, match);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add component master\n");
 
 	pm_runtime_enable(dev);
 
 	ret = component_add(dev, &mtk_disp_ovl_adaptor_comp_ops);
 	if (ret != 0) {
+		component_master_del(dev, &mtk_disp_ovl_adaptor_master_ops);
 		pm_runtime_disable(dev);
 		return dev_err_probe(dev, ret, "Failed to add component\n");
 	}
@@ -666,6 +670,7 @@ static int mtk_disp_ovl_adaptor_probe(struct platform_device *pdev)
 
 static void mtk_disp_ovl_adaptor_remove(struct platform_device *pdev)
 {
+	component_del(&pdev->dev, &mtk_disp_ovl_adaptor_comp_ops);
 	component_master_del(&pdev->dev, &mtk_disp_ovl_adaptor_master_ops);
 	pm_runtime_disable(&pdev->dev);
 }
-- 
2.51.0
