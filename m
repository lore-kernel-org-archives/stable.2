Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E976D497B74;
	Wed, 30 Sep 2026 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768284; cv=none; b=Ma10PiTSoh+E7qVWecSq1b/kooVaulaqusR0XhbnPDHfIzC0WiMRsqQnknQNyb0p/lBi6KSJ5YPMrF/91tLkifEtgL8lxoUNkyYbQhvlrSIV2vJpkYmMF1ue3R4p3Pu5iGM1kvmFeQhTfLasncpUWU0kbPlNK3w1XATbWjHTpm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768284; c=relaxed/simple;
	bh=9x4qz8SQWWXpLdxEcF1F+Sad7bmg0v/7RIHIFx8G5dw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jw3R+HU0hfcQ5bbdzGTG04e/SCB8SD3JMKi9fad5Uu2MbQty+IlAX0TRziu2i20sMNO2UnvKoRECvzoLGehsFaQt3cqzkshjo7nno7JiRQViUU251DZfX8u5AU7jlhf/layBuPvQO3sQDAv+JZ3i69vTN1TtJjSprNS0chQNEBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5df1cad6bcc311f19a56ed5b684f684d-20260930
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d7ae2b3a-2e8c-4682-b202-cb33043ec94b,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:5cac8d0b79f4a1459abfefed66604c0e,BulkI
	D:nil,BulkQuantity:0,SF:102|123|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5df1cad6bcc311f19a56ed5b684f684d-20260930
X-User: fengchenguang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fengchenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 473731221; Wed, 30 Sep 2026 19:37:50 +0800
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
Subject: [PATCH] media: exynos4-is: Fix control handler leak in fimc-isp
Date: Wed, 30 Sep 2026 19:37:46 +0800
Message-Id: <20260930113746.278395-1-fengchenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chenguang Feng <fengchenguang@kylinos.cn>

fimc_isp_subdev_create() initializes the control handler and adds
controls before checking handler->error.  On the error path only the
media entity is cleaned up and the handler memory is never freed;
the caller in fimc_is_probe() returns directly, so nothing else
releases it either.

Call v4l2_ctrl_handler_free() in the error path, mirroring
fimc_isp_subdev_destroy().

Fixes: 9a761e436843f ("[media] exynos4-is: Add Exynos4x12 FIMC-IS driver")
Cc: stable@vger.kernel.org
Signed-off-by: Chenguang Feng <fengchenguang@kylinos.cn>
---
 drivers/media/platform/samsung/exynos4-is/fimc-isp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-isp.c b/drivers/media/platform/samsung/exynos4-is/fimc-isp.c
index 3c5d7bee2655..896a1b0952ad 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-isp.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-isp.c
@@ -760,6 +760,7 @@ int fimc_isp_subdev_create(struct fimc_isp *isp)
 
 	if (handler->error) {
 		media_entity_cleanup(&sd->entity);
+		v4l2_ctrl_handler_free(handler);
 		return handler->error;
 	}
 
-- 
2.25.1

