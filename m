Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1A34195DA;
	Tue, 21 Jul 2026 06:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616501; cv=none; b=KHztTokURhu5Yd+2z0BGumb3ZVU7/JFeX9dJ8z2RR3qFP+e3daTM8BMSwzyJBaNH5mRNX2swss3lwSewg3QxUhZNubO6nQDBaEiXVLB/4qgN7kMLoyvRoTlxmu8KOrXKTgtcqKYHKuD5bZ4vCqhk0RmQ2i8c3EPodrHXbHz/01w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616501; c=relaxed/simple;
	bh=EVm5nGLtaQ9F8VmMiOVvm3h/eHTfiwrZ95TDWNVJrWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DX0sGm66ExrNicL7MKz/qSm4m9Vfk/2gK83fTImqo1Otxm58U+fNxsYWR5oSXFu8UxijhHgWZgdw8aYRLRAjZPsREOLkuRfVAZT4yT0ra9a2uEMoVDMyL3Pt3eGzsJLeP7/14fLzGG+3VyhaQc9hB6uZH+6qmtXVAT7z0vydnow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2622954884d011f1aa26b74ffac11d73-20260721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0266ae76-5ceb-416f-83ef-0ac66190f1b9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:430a820fc86c611bc906720702d2c2ae,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2622954884d011f1aa26b74ffac11d73-20260721
X-User: pengcan@kylinos.cn
Received: from lenovo [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 973892165; Tue, 21 Jul 2026 14:48:15 +0800
From: Can Peng <pengcan@kylinos.cn>
To: vkoul@kernel.org,
	neil.armstrong@linaro.org,
	bmasney@redhat.com
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] phy: freescale: fsl-samsung-hdmi: Disable APB clock on resume failure
Date: Tue, 21 Jul 2026 14:47:52 +0800
Message-ID: <20260721064752.153338-5-pengcan@kylinos.cn>
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

fsl_samsung_hdmi_phy_resume() enables apbclk and then reprograms the PHY
when a previous clock configuration is available. If the hardware
configuration fails, the function returns the error with apbclk still
enabled.

Disable apbclk on the failure path so the clock enable count remains
balanced.

Fixes: 6ad082bee902 ("phy: freescale: add Samsung HDMI PHY")
Cc: stable@vger.kernel.org
Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 455d03220b72..bb1aa1977065 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -722,8 +722,11 @@ static int __maybe_unused fsl_samsung_hdmi_phy_resume(struct device *dev)
 		return ret;
 	}
 
-	if (phy->cur_cfg)
+	if (phy->cur_cfg) {
 		ret = fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
+		if (ret)
+			clk_disable(phy->apbclk);
+	}
 
 	return ret;
 
-- 
2.53.0

