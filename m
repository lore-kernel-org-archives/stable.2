Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F86B4C8C54;
	Wed, 30 Sep 2026 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768345; cv=none; b=sQspQDukF/Un4yyYJZfHykNqC7unybn5rJc6YDKXTMbo3frpGYgxusl6+6sn6ZXiKOBcvHg61K1HPl3FrALnRu2XUZceb/2zWP3+S8VX0D/GRe+JSc99qz4PA4/KH1gpdbsVjRSULI6WgBSww7cPdmChQ8zNdkGNXZ0osgT/FOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768345; c=relaxed/simple;
	bh=4Din0es4th5rhmV7FCjMKnTdoqh6ej4HAim9DGVgPnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E04/YOhv5jUcSukhdTWbPeqxQP8LBeOcm2DdWRGTf6kAxII2VsN+6o9nevELdAL2P3ewvFlzePX/sj7RtpkD4QtfJibQOQWUcwACade6SJ4e1rB3xFlzvFCJ7d7P9E3yX+zATvXfNJfCiJsEpTt8ToFbNWxqhu+2PI3oPzUxRPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 839f7742bcc311f19a56ed5b684f684d-20260930
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:280b0e8d-6cfc-47f6-afc8-4b5b180206af,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:c46ceab0234235c5706ee733755f32d0,BulkI
	D:nil,BulkQuantity:0,SF:102|123|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 839f7742bcc311f19a56ed5b684f684d-20260930
X-User: fengchenguang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fengchenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 126679322; Wed, 30 Sep 2026 19:38:53 +0800
From: fengchenguang@kylinos.cn
To: s.nawrocki@samsung.com,
	mchehab@kernel.org
Cc: krzk@kernel.org,
	peter.griffin@linaro.org,
	alim.akhtar@samsung.com,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chenguang Feng <fengchenguang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: exynos4-is: Fix runtime PM usage counter leak in fimc-isp
Date: Wed, 30 Sep 2026 19:38:49 +0800
Message-Id: <20260930113849.278562-1-fengchenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chenguang Feng <fengchenguang@kylinos.cn>

fimc_isp_subdev_s_power() increments the usage counter with
pm_runtime_resume_and_get() and releases it if fimc_is_start_firmware()
fails, but not when fimc_is_hw_initialize() fails further down: the
function then returns with the counter still held, and the device can
never runtime-suspend afterwards.

Call pm_runtime_put() on the fimc_is_hw_initialize() error path as
well, like the fimc_is_start_firmware() path already does.

Fixes: 9a761e436843f ("[media] exynos4-is: Add Exynos4x12 FIMC-IS driver")
Cc: stable@vger.kernel.org
Signed-off-by: Chenguang Feng <fengchenguang@kylinos.cn>
---
 drivers/media/platform/samsung/exynos4-is/fimc-isp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-isp.c b/drivers/media/platform/samsung/exynos4-is/fimc-isp.c
index 896a1b0952ad..8d4efb552424 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-isp.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-isp.c
@@ -322,6 +322,11 @@ static int fimc_isp_subdev_s_power(struct v4l2_subdev *sd, int on)
 		set_bit(IS_ST_PWR_SUBIP_ON, &is->state);
 
 		ret = fimc_is_hw_initialize(is);
+		if (ret < 0) {
+			v4l2_err(sd, "hardware initialization failed\n");
+			pm_runtime_put(&is->pdev->dev);
+			return ret;
+		}
 	} else {
 		/* Close sensor */
 		if (!test_bit(IS_ST_PWR_ON, &is->state)) {
-- 
2.25.1

