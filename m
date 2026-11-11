Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416791;
	b=fv+S1ha+Vm6P+Lg4DPWHBLgbxwIKpV99cSi7VuqcMp9iwJx3AyYQPl4839D5Y3o9kCX4
	 zhYGkptbJVW4/xnjQFx38GSgZEH5XtGemNFbcQz+t+YLi0GDwpGPTvwKw2giK/tiETs5z
	 Jg5vqCLFvsRxpCHCai9Z8UYUq/2N/KHNKQd6ugEhkI5+G/fkF2q+LVSL/TLeBb7ewTYU0
	 FxeexguLvQ7ssoSKCZi/Um4a+u6LA8heIyHFgHGN01G/ceUMB5c4WFXgyAqMF1NNGRut4
	 xgDE4QPDx6Sze4llohhhqU660kjkN9/shW/EhHYvbR24l59jR6W9N+ev6uQ7G4aKF2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416791;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Qp8mSShXuyKtR1KzKIOI78p0nyVVyqD1GBkKFjfKGZM=;
	b=SzxAC+e+EuQoR2hOK/jGg/LjiOixri6AGse16YR29evTvcc57Qdjkiw3INDw7Feq6ZS/
	 01wvE+dSijiMBXDy4OijTjMekUszGOHeOSCKGAmD2Rdeq3+Syck4PPmhOqaEiHWbw47U9
	 38LFptY45puzvggNVeYlplJpD+pGFvzDbhqJf0UmoqTjT2h2z6cCffLqk7NejFzf0a8v8
	 d134Wujw2KTaJYz14+Dybdk4SXtOx43QQp3qqpHQ+2Dvgeefc2mLrZ0Oq3ijKGYNwD2J6
	 i6gd/9R60Q4o8vC5Ob51YNPKYw2xwqTOnhqPrc5wMoj/OcErYXWUY7J725tPnm3c1Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LVkIbu2c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E670D60A2608
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LVkIbu2c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1011F00A08;
	Wed, 11 Nov 2026 17:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416790;
	bh=Qp8mSShXuyKtR1KzKIOI78p0nyVVyqD1GBkKFjfKGZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LVkIbu2cNk0uOrYSEX7xo07bX9fqWxWZTSl9ZadQKsegF4wIgT7DOR+eX79X5PG05
	 obsBTo8+uJmh9T7uwAJ5a3tus/nRywgkw83pBSsvn1XRr5rGdBjpwiyB87IW3mZznA
	 GpfGtOic32x3y01GYe0+zN1LJqDYgeBSjNsWF2Uplf9kVCOKMbMPXACzun9z+u+4Ic
	 F6Y9YEjzXUf4LvorPNwUM+RKCAjw0E1sf0QKc/i33a2vAUBv1jQDC8CHY8V4DtFZzY
	 Vuisuehu6uGHTL1eBWfEsb5pArJtRdWPtPGoMmrXYZ6A+muS/fMwaTac4hfD50dP5E
	 EXC/So8BAxWbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/4] clk: nuvoton: ma35d1: Keep the clock count in the driver
Date: Wed, 11 Nov 2026 12:06:26 -0500
Message-ID: <20261111170618.3423248-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050550-failed-7.3-1dc3871ce7ec@kernel.org>
References: <20261107050550-failed-7.3-1dc3871ce7ec@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 26ec588063d9b6c70773b8729372e2bf6d3ea95a ]

The number of clocks is not a binding since this is a value that can
change. As such, in order to support the missing watchdog clocks and
allow the deprecation and removal of CLK_MAX_IDX from the bindings, we
need to switch to a local definition first.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://patch.msgid.link/20260930-perso-ma35d1-upstream-clk-v6-1-48937ee6c9bb@bootlin.com
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Brian Masney <bmasney@redhat.com>
Stable-dep-of: 1dc3871ce7ec ("clk: nuvoton: ma35d1: Add missing WDT/WWDT parent clocks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/nuvoton/clk-ma35d1.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
index 9f65d0623517a..6aa42a3e1be3b 100644
--- a/drivers/clk/nuvoton/clk-ma35d1.c
+++ b/drivers/clk/nuvoton/clk-ma35d1.c
@@ -17,6 +17,7 @@
 static DEFINE_SPINLOCK(ma35d1_lock);
 
 #define PLL_MAX_NUM		5
+#define	MA35D1_CLK_COUNT	236
 
 /* Clock Control Registers Offset */
 #define REG_CLK_PWRCTL		0x00
@@ -467,12 +468,12 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	int ret;
 
 	ma35d1_hw_data = devm_kzalloc(dev,
-				      struct_size(ma35d1_hw_data, hws, CLK_MAX_IDX),
+				      struct_size(ma35d1_hw_data, hws, MA35D1_CLK_COUNT),
 				      GFP_KERNEL);
 	if (!ma35d1_hw_data)
 		return -ENOMEM;
 
-	ma35d1_hw_data->num = CLK_MAX_IDX;
+	ma35d1_hw_data->num = MA35D1_CLK_COUNT;
 	hws = ma35d1_hw_data->hws;
 
 	clk_base = devm_platform_ioremap_resource(pdev, 0);
-- 
2.53.0

