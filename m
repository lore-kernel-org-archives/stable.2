Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE3342883D;
	Tue, 21 Jul 2026 06:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616502; cv=none; b=Seu1nWUltz4kUwDsXwXl/cFX5bW+8lAosLpuUL03GPjgn7Ie1UzWeXCXi6wdNlQCWqne2E7Op9PomdEYuVwzl/fq0ZDi5sNvtK4Ap2yxgrxb7TO1nmybrEdLgcpPyE7T7bWc49BRiqMNm6jE6nSKjZVhARiT9X5j7gluuQxfu3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616502; c=relaxed/simple;
	bh=8qtYWFIyqNitdneNzuzz0atY0ca9fmAexYaRFaSFixM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFe7yZNC/fphtcmRT3pn3zTmC8x4xZ6GwrObqudb9OURC07wJu00PlzTobGwa3U9t5GitXVOf8VJ6bYI1S7OCz2z93kIghXeiEHLGcQufSDvIYoIozFZ5i/imiZ1WXhlvvYP5MdqseXHF0DpEkAFn+3d5oJ9ZYtEiGn2ca+edwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 246fc4aa84d011f1aa26b74ffac11d73-20260721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:79d72310-165d-4435-98d6-59e84d751874,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:3049064dc9f762a36daa46b2ce985449,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 246fc4aa84d011f1aa26b74ffac11d73-20260721
X-User: pengcan@kylinos.cn
Received: from lenovo [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2031218206; Tue, 21 Jul 2026 14:48:12 +0800
From: Can Peng <pengcan@kylinos.cn>
To: vkoul@kernel.org,
	neil.armstrong@linaro.org,
	bmasney@redhat.com
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] phy: freescale: fsl-samsung-hdmi: Only gate APB clock in runtime PM
Date: Tue, 21 Jul 2026 14:47:51 +0800
Message-ID: <20260721064752.153338-4-pengcan@kylinos.cn>
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

The APB clock is acquired with devm_clk_get_enabled(), so it remains
prepared until devres cleanup and runtime PM only needs to gate or ungate
it.

Using clk_prepare_enable() from runtime resume is also problematic when
the common clock framework runtime-resumes the provider device before
calling the PHY clock rate callbacks, because clk_set_rate() is executed
while holding the clock prepare lock.

Use clk_enable() and clk_disable() in the runtime PM callbacks so the APB
clock remains prepared for the lifetime of the device and runtime resume
does not re-enter the prepare path.

Fixes: 6ad082bee902 ("phy: freescale: add Samsung HDMI PHY")
Cc: stable@vger.kernel.org
Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 5f41890bd134..455d03220b72 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -706,7 +706,7 @@ static int __maybe_unused fsl_samsung_hdmi_phy_suspend(struct device *dev)
 {
 	struct fsl_samsung_hdmi_phy *phy = dev_get_drvdata(dev);
 
-	clk_disable_unprepare(phy->apbclk);
+	clk_disable(phy->apbclk);
 
 	return 0;
 }
@@ -716,7 +716,7 @@ static int __maybe_unused fsl_samsung_hdmi_phy_resume(struct device *dev)
 	struct fsl_samsung_hdmi_phy *phy = dev_get_drvdata(dev);
 	int ret = 0;
 
-	ret = clk_prepare_enable(phy->apbclk);
+	ret = clk_enable(phy->apbclk);
 	if (ret) {
 		dev_err(phy->dev, "failed to enable apbclk\n");
 		return ret;
-- 
2.53.0

