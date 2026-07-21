Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F4241A776;
	Tue, 21 Jul 2026 06:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616492; cv=none; b=Oz23wSyEbQCBfbHi6hgzp0+GHWlLAMSEEzvwJGliZUINhQ4Ikr458E4XCSQ4s4kP+vOI8p39iiD95kvtOhTC6ha54BNxhPya7NVHaki01PgiHMcqNmaC8PB/9rRBQ6067CZ8QH6T+5gGzcg+LtuJN3SG2sFJFHJ4bnH1RIs3y80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616492; c=relaxed/simple;
	bh=RA2oV+3c/CvsMB9fvFh/SIvyGMvtkJ06RvzSEbVj9cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGhf3ubbmSRulvTCeMM6TadLSkuOJLCuYvmqt72MZmTBJICVJgggSQ664xHRAXDm9Npr62vJBH2Z9US3ga/ITOcyGzXXsM8piQeWD39LvixguVDTKw9eybf5RykumrDcXNwmDF6QCUhruiO0CDbmr6FG4QDOthM6zDIi34vkA6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1e97771284d011f1aa26b74ffac11d73-20260721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:464eec67-f3a5-4af9-a821-b6825e563397,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:019d5c6ce7d0507cf04a6c64187fe719,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1e97771284d011f1aa26b74ffac11d73-20260721
X-User: pengcan@kylinos.cn
Received: from lenovo [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1705813608; Tue, 21 Jul 2026 14:48:02 +0800
From: Can Peng <pengcan@kylinos.cn>
To: vkoul@kernel.org,
	neil.armstrong@linaro.org,
	bmasney@redhat.com
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] phy: freescale: fsl-samsung-hdmi: Fix runtime PM cleanup
Date: Tue, 21 Jul 2026 14:47:49 +0800
Message-ID: <20260721064752.153338-2-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721064752.153338-1-pengcan@kylinos.cn>
References: <20260721064752.153338-1-pengcan@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fsl_samsung_hdmi_phy_probe() takes a runtime PM reference, marks the
device active and enables runtime PM before registering the PHY clock.
If phy_clk_register() fails, probe returns without dropping the runtime
PM reference or disabling runtime PM.

The remove callback only unregisters the clock provider, so runtime PM
is also left enabled after a successful probe followed by driver unbind.

Check pm_runtime_set_active(), use devm_pm_runtime_enable() so runtime
PM is disabled automatically, and drop the initial noresume reference
on PM setup and clock registration failures.

Fixes: 6ad082bee902 ("phy: freescale: add Samsung HDMI PHY")
Cc: stable@vger.kernel.org
Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index d010fec15671..e7af4f9c7b20 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -665,20 +665,26 @@ static int fsl_samsung_hdmi_phy_probe(struct platform_device *pdev)
 				     "failed to get ref clk\n");
 
 	pm_runtime_get_noresume(phy->dev);
-	pm_runtime_set_active(phy->dev);
-	pm_runtime_enable(phy->dev);
+	ret = pm_runtime_set_active(phy->dev);
+	if (ret)
+		goto pm_put_noidle;
+
+	ret = devm_pm_runtime_enable(phy->dev);
+	if (ret)
+		goto pm_put_noidle;
 
 	ret = phy_clk_register(phy);
 	if (ret) {
 		dev_err(&pdev->dev, "register clk failed\n");
-		goto register_clk_failed;
+		goto pm_put_noidle;
 	}
 
 	pm_runtime_put(phy->dev);
 
 	return 0;
 
-register_clk_failed:
+pm_put_noidle:
+	pm_runtime_put_noidle(phy->dev);
 	return ret;
 }
 
-- 
2.53.0

