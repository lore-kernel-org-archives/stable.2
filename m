Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDB141A776;
	Tue, 21 Jul 2026 06:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616495; cv=none; b=As9s2wAWZSNqWbv6vhqECCWpwb0z7WP5b8ozjne6uNiQjnjifbpxCxiCOM0RArr8vw/AWi09zbhSl4fckpTmWKYOhEWbEhrUgFU4S64u+Gw/CEKIFRhlrItCyBJaQY8kb/5bYgTSJNIfrIoJDusLk7GZ1siNzKB0N0D1gAK5q14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616495; c=relaxed/simple;
	bh=ge+TWb4icNanYC4RtWtGqHS2iaK9/amQnITQLQSQKDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwaLe8RWE2tk6wR/wZd8PRNyBwz5e7wSo1+juRENP+NLNXw5jhJRosUCRh1KQHKDWDh7uxlilwmt7JOFzPpd+hhwtUKsWmZ8ClgmkpbrBqCShLJUrjEALsoS4grHQOrnPEn8CszdgFsZhI5VFwhitnI2LFXUW9/k0QwUBeOttN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2266606a84d011f1aa26b74ffac11d73-20260721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:69d927d5-af34-4c5b-a9c0-d4640c077d08,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:3e7a4f355dedc4bf6a97cc7a7de41efa,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2266606a84d011f1aa26b74ffac11d73-20260721
X-User: pengcan@kylinos.cn
Received: from lenovo [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1501765214; Tue, 21 Jul 2026 14:48:09 +0800
From: Can Peng <pengcan@kylinos.cn>
To: vkoul@kernel.org,
	neil.armstrong@linaro.org,
	bmasney@redhat.com
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/4] phy: freescale: fsl-samsung-hdmi: Resume device on remove
Date: Tue, 21 Jul 2026 14:47:50 +0800
Message-ID: <20260721064752.153338-3-pengcan@kylinos.cn>
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

The APB clock is acquired with devm_clk_get_enabled(), so devres will
disable and unprepare it when the driver is unbound.

Runtime suspend also disables the APB clock. If the device is runtime
suspended when the driver is removed, devres will disable the already
disabled clock and the clock enable count can underflow.

Resume the device in the remove callback before devres runs so the final
devres disable is balanced. Drop the runtime PM reference with noidle so
the device is not suspended again before devres cleanup.

Fixes: 6ad082bee902 ("phy: freescale: add Samsung HDMI PHY")
Cc: stable@vger.kernel.org
Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index e7af4f9c7b20..5f41890bd134 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -690,7 +690,16 @@ static int fsl_samsung_hdmi_phy_probe(struct platform_device *pdev)
 
 static void fsl_samsung_hdmi_phy_remove(struct platform_device *pdev)
 {
+	int ret;
+
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0)
+		dev_warn(&pdev->dev, "failed to resume on remove: %d\n", ret);
+
 	of_clk_del_provider(pdev->dev.of_node);
+
+	if (!ret)
+		pm_runtime_put_noidle(&pdev->dev);
 }
 
 static int __maybe_unused fsl_samsung_hdmi_phy_suspend(struct device *dev)
-- 
2.53.0

