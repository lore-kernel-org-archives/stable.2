Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5394C2FFF8B;
	Wed, 12 Aug 2026 03:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786504046; cv=none; b=JxG1NrFuSxl1yChGHgz2TL6P5aIz5CruH6KbTJonNCaVlBd4MGdkVk3qHaW9coTDIaA/r4BXeilE70fBKjqvc2JjH6FbI7Jcm6ahsc+crubtfjpxO9pOC2JohZWbNVBxhP6sD9A3CHR+gqECHrpQTarWTk4Lk6CDy/GwvPgVpCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786504046; c=relaxed/simple;
	bh=+1uVDN2u7yEIXLVuOem+mIJPeDld3zKkUx9ZtpUKYsI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q4ycQmnYLswFzvuhQdL2Uh9/1MzuPJ4DhZRj1TmlIBu4rpj2liTsILwHU2IO0i68yWUj204o1kvNI6TAhfgLSwcIkgDVjcHVbfZqlQMj7cP6ntKvDh2cZ1zD+xcyN+to9yZ5i8H39B0P5QyFiQJfdxPK/2g5JbpfQoDNqKU0Roo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: eb7925ec95fa11f1aa26b74ffac11d73-20260812
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7c8e65db-44e9-447e-a9e7-d16adb0551e7,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:6353e8e742baf08e15818909926fe79a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: eb7925ec95fa11f1aa26b74ffac11d73-20260812
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1043525765; Wed, 12 Aug 2026 11:07:15 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: yannick.fertre@foss.st.com,
	raphael.gallais-pou@foss.st.com,
	philippe.cornu@foss.st.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	benjamin.gaignard@linaro.org,
	yannick.fertre@st.com
Cc: dri-devel@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/stm/ltdc: Fix clock cleanup error handling
Date: Wed, 12 Aug 2026 11:07:10 +0800
Message-Id: <20260812030710.549621-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When clk_prepare_enable() fails for bus_clk or lvds_clk, the previously
prepared clocks are not cleaned up, leading to resource leaks.

In ltdc_resume():
- If bus_clk preparation fails, pixel_clk remains prepared
- If lvds_clk preparation fails, both pixel_clk and bus_clk remain prepared

In ltdc_load():
- If bus_clk preparation fails, pixel_clk remains prepared

Fix this by adding proper error handling to ensure all prepared clocks
are disabled and unprepared when a subsequent clock preparation fails.

Fixes: df61c776657f ("drm/stm: add sleep power management")
Fixes: d80667642b0f ("drm/stm: ltdc: support new hardware version for STM32MP25 SoC")
Fixes: b7243862f82a ("drm/stm: ltdc: handle lvds pixel clock")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
Changes in v2:
- Use separate error labels in ltdc_load() so a failed bus clock is not
  passed to clk_disable_unprepare().
- Keep cleanup limited to clocks that were successfully prepared.
---
 drivers/gpu/drm/stm/ltdc.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 8818dcf98da7..ac1c2f27563e 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -1908,16 +1908,25 @@ int ltdc_resume(struct drm_device *ddev)
 		ret = clk_prepare_enable(ldev->bus_clk);
 		if (ret) {
 			drm_err(ddev, "failed to enable bus clock (%d)\n", ret);
-			return ret;
+			goto err_pixel;
 		}
 	}
 
 	if (ldev->lvds_clk) {
 		ret = clk_prepare_enable(ldev->lvds_clk);
-		if (ret)
+		if (ret) {
 			drm_err(ddev, "failed to prepare lvds clock\n");
+			goto err_bus;
+		}
 	}
 
+	return 0;
+
+err_bus:
+	if (ldev->bus_clk)
+		clk_disable_unprepare(ldev->bus_clk);
+err_pixel:
+	clk_disable_unprepare(ldev->pixel_clk);
 	return ret;
 }
 
@@ -1963,7 +1972,7 @@ int ltdc_load(struct drm_device *ddev)
 		ret = clk_prepare_enable(ldev->bus_clk);
 		if (ret) {
 			drm_err(ddev, "Unable to prepare bus clock\n");
-			return ret;
+			goto err_pixel;
 		}
 	}
 
@@ -2093,11 +2102,10 @@ int ltdc_load(struct drm_device *ddev)
 
 	return 0;
 err:
-	clk_disable_unprepare(ldev->pixel_clk);
-
 	if (ldev->bus_clk)
 		clk_disable_unprepare(ldev->bus_clk);
-
+err_pixel:
+	clk_disable_unprepare(ldev->pixel_clk);
 	return ret;
 }
 
-- 
2.25.1

