Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B141230BDB;
	Sat, 18 Jul 2026 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784359130; cv=none; b=uWV2pX1/9qXwzDF9e6+ClrwiuLha/nUvahBbkNkyqSzSloXAC761wbCAkqOVVcds8/bWL7lFT0lK9PImzpUMHRLjhzIZp99VkEAs3XUvS2a6EgZ3+doV0YDKMbhp8hvkGUrKnKlGaTjAl2DJ9sHY/ncXVDa9EBzk0REKY7GkTzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784359130; c=relaxed/simple;
	bh=RA2oV+3c/CvsMB9fvFh/SIvyGMvtkJ06RvzSEbVj9cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4O3gwDnNqhoFeMYmNt5Pmq5ERNxhhYd5VbNazVYyEaZAQ03c+4aQ848CgvrQRZ4THWjg2hWO7YiOXqjwy8XXxuJzl0YdzfbHKlUpbZ3qySR5YGm54yxfTHCj/ffhaT2TPXPNXaKiW59bf2LWilI8IHp1LdrlcCKBeXVlVBS7zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e7ddd986827811f1aa26b74ffac11d73-20260718
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:e9dd0467-be09-455a-b401-accefd39c1f1,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:e9dd0467-be09-455a-b401-accefd39c1f1,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:b86353c549001be137f299a4fa0a2f14,BulkI
	D:260718151843EJ8MIE03,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|865
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e7ddd986827811f1aa26b74ffac11d73-20260718
X-User: pengcan@kylinos.cn
Received: from lenovo [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 47783712; Sat, 18 Jul 2026 15:18:42 +0800
From: Can Peng <pengcan@kylinos.cn>
To: vkoul@kernel.org,
	neil.armstrong@linaro.org
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] phy: freescale: fsl-samsung-hdmi: Fix runtime PM cleanup
Date: Sat, 18 Jul 2026 15:18:16 +0800
Message-ID: <20260718071816.437047-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.53.0
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

