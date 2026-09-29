Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6268C313293
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790690583; cv=none; b=dIsN1FTWnuVm3P/SwLngd4o9AG6JwVE793qmA5TVTYAyBqvMRCn0pAXNSCN47BtQLzIQrmjh+rdDS0jt4QkI1aCPTBKnIxSdkzLQT/sSZ5meWJMsJBRLT/UmEcxTrUvRFBhiihk3PUSZrog/ST1xhJUdX6RSnyXugxyX3wNGIYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790690583; c=relaxed/simple;
	bh=zx2C/md+EOiVl2VpEyu4waz5Bv1Di5dOWFIpbweZ9QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okjTy5E8UUfZdj6Gavgw/dy1FzbtfFaBcym2uSclKV7nkiAsvhYiqYGKOSaJW7fuIyrolLpOmcz0sVze0+w+SwBSdXFrKzZt4oPlvAwEjA77JN0pjhMedn0MtnOMFsB+ohdNxbVqCPphbj9qdP7ZXw0LQ8WT/qoer545BCDf24M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWpLEFfP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWpLEFfP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562C31F000FF;
	Tue, 29 Sep 2026 14:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790690581;
	bh=FXKaX137d+FKHs5jzntpbrzaC2sReLO69+T9TP1Au7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZWpLEFfPq2CXmD/5YehtJmu8lXzEIDsmB52fu2ZcFb/H3IaRd0bALEx1f9n112UkR
	 aDHyuZMIo1dbl7zaUAiIRs6GfLH56ahHLHiaVHOZVn96wilGwakIX+6XXbhnBpDnRG
	 OzO8IEWblpzkNFcZfY9Prg+SwajGPTBYMFqpj1MtgyNa/KCA6LUe59Lb56eXTLjwwh
	 UNuYZSJ8UTmBG/ifR3LsYk6dYyMkt9oqjzmKM1ME4etEFtDjnX0E7TU+h0i6eOi28w
	 pvuEFKSa76AwFCi6qumBJ4thXC34gKwXeE3D8PlCZRuUcKZUO/jeg3bBD65dB9PJF+
	 eanurRYjtDPfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL
Date: Tue, 29 Sep 2026 10:02:59 -0400
Message-ID: <20260929140259.3526507-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092906-critter-preamble-da49@gregkh>
References: <2026092906-critter-preamble-da49@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
[ Applied initialization error handling in geni_i2c_probe() because geni_i2c_resources_init() is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 38 ++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 6b2caaaa9437e..307e2e4030af9 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -77,6 +77,9 @@ enum geni_i2c_err_code {
 #define XFER_TIMEOUT		HZ
 #define RST_TIMEOUT		HZ
 
+#define GENI_SE_CLK_32MHZ	(32 * HZ_PER_MHZ)
+#define GENI_SE_CLK_19P2MHZ	19200000UL
+
 struct geni_i2c_dev {
 	struct geni_se se;
 	u32 tx_wm;
@@ -91,6 +94,7 @@ struct geni_i2c_dev {
 	struct clk *core_clk;
 	u32 clk_freq_out;
 	const struct geni_i2c_clk_fld *clk_fld;
+	u32 clk_idx;
 	int suspended;
 	void *dma_buf;
 	size_t xfer_len;
@@ -165,19 +169,44 @@ static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
 static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 {
 	const struct geni_i2c_clk_fld *itr;
+	unsigned long res_freq;
 
-	if (clk_get_rate(gi2c->se.clk) == 32 * HZ_PER_MHZ)
+	/*
+	 * Frequency counter tables are calibrated for a specific source
+	 * clock frequency and are not valid for any multiple of it
+	 * (e.g. 64 MHz, 128 MHz).
+	 * Use exact=true and verify res_freq matches req_freq literally
+	 * to reject harmonics: a 64 MHz clock that divides evenly to
+	 * 32 MHz would pass exact matching but produce double the intended
+	 * I2C frequency with these counter values.
+	 */
+	if (!geni_se_clk_freq_match(&gi2c->se, GENI_SE_CLK_32MHZ,
+				    &gi2c->clk_idx, &res_freq, true) &&
+	    res_freq == GENI_SE_CLK_32MHZ) {
 		itr = geni_i2c_clk_map_32mhz;
-	else
+	} else if (!geni_se_clk_freq_match(&gi2c->se, GENI_SE_CLK_19P2MHZ,
+					   &gi2c->clk_idx, &res_freq, true) &&
+		   res_freq == GENI_SE_CLK_19P2MHZ) {
 		itr = geni_i2c_clk_map_19p2mhz;
+	} else {
+		dev_err(gi2c->se.dev,
+			"Unsupported SE source clock: must be exactly 32 MHz or 19.2 MHz\n");
+		return -EINVAL;
+	}
 
 	while (itr->clk_freq_out != 0) {
 		if (itr->clk_freq_out == gi2c->clk_freq_out) {
 			gi2c->clk_fld = itr;
+			dev_dbg(gi2c->se.dev,
+				"I2C clk selected: freq: %u Hz, clk_idx: %u\n",
+				gi2c->clk_freq_out, gi2c->clk_idx);
 			return 0;
 		}
 		itr++;
 	}
+
+	dev_err(gi2c->se.dev, "Unsupported I2C output frequency %u Hz\n", gi2c->clk_freq_out);
+
 	return -EINVAL;
 }
 
@@ -186,7 +215,7 @@ static void qcom_geni_i2c_conf(struct geni_i2c_dev *gi2c)
 	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
 	u32 val;
 
-	writel_relaxed(0, gi2c->se.base + SE_GENI_CLK_SEL);
+	writel_relaxed(gi2c->clk_idx, gi2c->se.base + SE_GENI_CLK_SEL);
 
 	val = (itr->clk_div << CLK_DIV_SHFT) | SER_CLK_EN;
 	writel_relaxed(val, gi2c->se.base + GENI_SER_M_CLK_CFG);
@@ -823,8 +852,7 @@ static int geni_i2c_probe(struct platform_device *pdev)
 
 	ret = geni_i2c_clk_map_idx(gi2c);
 	if (ret)
-		return dev_err_probe(dev, ret, "Invalid clk frequency %d Hz\n",
-				     gi2c->clk_freq_out);
+		return ret;
 
 	gi2c->adap.algo = &geni_i2c_algo;
 	init_completion(&gi2c->done);
-- 
2.53.0

