Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A314B3B14A5
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694944; cv=none; b=ZZ3cyMVMfoLluPMVml3uJssAb1k+2WJq9HSfztPXVK9Go46Zl3Z7jCW/gp9+w/k5gd/q2kMHuVsHmU813S9MNLCNvtlBd6I8VZKwYQsmX2W4QWjLPHjA5DsmhpPGk5r2+tUFR9GGXOCUx1NeQgGPvgvJZATz3M9hwPADQQVd+ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694944; c=relaxed/simple;
	bh=Nkg7LA50YC+fWvofIC541k9i9DM1HH9sNL6bun6o73I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaZWQD0wnoWul6fXnSZlOK4sndz+b2m52u8PATap4pxuNWxahwCPtmyqk9t0ZWXLc9Z1PxItcRpl7Y74LAztrSEzwMEOUdHdkb2RkyS7gVQ0vDAA//tbAu8f9PvMwVaCG/+TEavSZBf4ofgcD61C+yhU4M4zkYeIu5PALMS3+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YE2ERkuC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YE2ERkuC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D5F1F000FF;
	Tue, 29 Sep 2026 15:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790694927;
	bh=wOUrPRCAffyYHL6+dTis/conJMptjNd+uEl1dqLEUMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YE2ERkuCm0bqyStoMyKEDtvD1AHQgeuK2/+x8ANEHh8FCYFZHVLeP/pK6D3SJnxEg
	 aY2+GnSvZ2WITPIfDRJU9nq6+0n5XiFXqC33/YfepnuqtTszynKANt5/sBjmPNcVqJ
	 bMTqsDih5pRW61qDl6qOjsLHMRZ+cD/Muf+UxL+jeRHwIYcAt0N1Lm5AlsRTi83sBP
	 i9DXS+1JREmpN3T+CLG4HMHLNnmbVJkghClZudsb3jG1uhF0ybTAb/kaCeDlaKFq+8
	 Cg7pV6e3l004qG7hRQYkz12GWjJmQaTsCVxVHzNLXtRaTicSymKPvEPwvhD1J4BoUg
	 GKRxkB6ZEPw2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL
Date: Tue, 29 Sep 2026 11:15:24 -0400
Message-ID: <20260929151525.3864716-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092910-other-decal-cd9e@gregkh>
References: <2026092910-other-decal-cd9e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

[ Upstream commit cb97bf3d4f91453b881acaf8e9f0cc47bb40b604 ]

qcom_geni_i2c_conf() writes a hardcoded 0 to SE_GENI_CLK_SEL, which
selects an index from the hardware clock performance table. This always
picks the first table entry regardless of the actual source clock
configuration. On platforms where the matching entry is not at index 0,
the wrong source clock divider is active and the I2C bus runs at an
incorrect frequency.

Use geni_se_clk_freq_match() in geni_i2c_clk_map_idx() to find the
performance table index for the source clock (32 MHz or 19.2 MHz). Store
the resolved index in a new clk_idx field in geni_i2c_dev and write it
to SE_GENI_CLK_SEL instead of the hardcoded 0.

Fixes: 37692de5d523 ("i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C controller")
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: <stable@vger.kernel.org> # v4.19+
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://patch.msgid.link/20260921-i2c-fix-se-clk-conf-v2-1-8b5537ceff2d@oss.qualcomm.com
[ adapted clock initialization to the older driver’s 19.2 MHz-only table and existing probe path. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 33 +++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 8758983a3ce19..84c74ee7ac857 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -72,6 +72,8 @@ enum geni_i2c_err_code {
 #define XFER_TIMEOUT		HZ
 #define RST_TIMEOUT		HZ
 
+#define GENI_SE_CLK_19P2MHZ	19200000UL
+
 struct geni_i2c_dev {
 	struct geni_se se;
 	u32 tx_wm;
@@ -85,6 +87,7 @@ struct geni_i2c_dev {
 	spinlock_t lock;
 	u32 clk_freq_out;
 	const struct geni_i2c_clk_fld *clk_fld;
+	u32 clk_idx;
 	int suspended;
 	void *dma_buf;
 	size_t xfer_len;
@@ -139,13 +142,36 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 {
 	int i;
 	const struct geni_i2c_clk_fld *itr = geni_i2c_clk_map;
+	unsigned long res_freq;
+
+	/*
+	 * Frequency counters are calibrated for a 19.2 MHz source clock
+	 * and are not valid for any multiple of it (e.g. 38.4 MHz).
+	 * Use exact=true and verify res_freq matches req_freq literally
+	 * to reject harmonics that would produce an incorrect I2C frequency.
+	 * ACPI systems have firmware-managed clocks and retain the default index.
+	 */
+	if (!has_acpi_companion(gi2c->se.dev) &&
+	    (geni_se_clk_freq_match(&gi2c->se, GENI_SE_CLK_19P2MHZ,
+				    &gi2c->clk_idx, &res_freq, true) ||
+	     res_freq != GENI_SE_CLK_19P2MHZ)) {
+		dev_err(gi2c->se.dev,
+			"Unsupported SE source clock: must be exactly 19.2 MHz\n");
+		return -EINVAL;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(geni_i2c_clk_map); i++, itr++) {
 		if (itr->clk_freq_out == gi2c->clk_freq_out) {
 			gi2c->clk_fld = itr;
+			dev_dbg(gi2c->se.dev,
+				"I2C clk selected: freq: %u Hz, clk_idx: %u\n",
+				gi2c->clk_freq_out, gi2c->clk_idx);
 			return 0;
 		}
 	}
+
+	dev_err(gi2c->se.dev, "Unsupported I2C output frequency %u Hz\n", gi2c->clk_freq_out);
+
 	return -EINVAL;
 }
 
@@ -154,7 +180,7 @@ static void qcom_geni_i2c_conf(struct geni_i2c_dev *gi2c)
 	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
 	u32 val;
 
-	writel_relaxed(0, gi2c->se.base + SE_GENI_CLK_SEL);
+	writel_relaxed(gi2c->clk_idx, gi2c->se.base + SE_GENI_CLK_SEL);
 
 	val = (itr->clk_div << CLK_DIV_SHFT) | SER_CLK_EN;
 	writel_relaxed(val, gi2c->se.base + GENI_SER_M_CLK_CFG);
@@ -559,11 +585,8 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		return gi2c->irq;
 
 	ret = geni_i2c_clk_map_idx(gi2c);
-	if (ret) {
-		dev_err(dev, "Invalid clk frequency %d Hz: %d\n",
-			gi2c->clk_freq_out, ret);
+	if (ret)
 		return ret;
-	}
 
 	gi2c->adap.algo = &geni_i2c_algo;
 	init_completion(&gi2c->done);
-- 
2.53.0

