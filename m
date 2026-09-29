Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EE14F55BC
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685982; cv=none; b=q1rg3N4Gzjhg1cqfp2TU2HzWKMSf+sjda3Pfo93fH+yW1wkuH5Wu0Vd+1+gmsRAzD2ztVgzTXAWPJitNrVVbTZYrp4OoImQuVTZ1eQL2p0zirM5rtRiDBT7jYYy8Obuf/8XIDT9H5d0XXPQLzn5eEgh/J7YKLRZDyxXAjJWUVNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685982; c=relaxed/simple;
	bh=0BN++PD0Kzpa0ZcWRbkfb9zYX5b8GIWxutDdSmSm5K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3NX5vfBwnNO8Me3Kc7/XYZyaytpGUeX6DmQpsTUTn4CgH7Royn5l/asPvVxk4dUMn/ty6uGn12B/UfL/v3CEeFMlYAHH08d26NDbAkdrU1/Th7gowVXDnaT3uZSZUAlACILnAMb+AfPkhyOG7avX2b66X0Ong7E3w72b01U7XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aufXOZKM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aufXOZKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7AB1F0089A;
	Tue, 29 Sep 2026 12:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685980;
	bh=s97nNl29bP/UejqGBXwtIf6hKJXqgApjmpvas+ZiJOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aufXOZKM6pATLuiY7Ohqt2/+xju+UdnX+u/Me3TCTPnmaCK1+YQmdJxRU3qzpxap5
	 WNnZPF6mpWvdScREPFxiTOj30lV82nNdzzCUfl3FsBlISO0v+Ymjz5Q9mSHmcoruPA
	 p+E34zFaA7xIdfg05rkDV42zIFhtdLUjV/ZD+egs+HklA4ClbaPveD3//rai/a6sTn
	 XFCAHkfU+CgPWW7b9ol8FBAxFeoO5d8D/tkySkxqCYfCnORW3H8cfMLNUnzGPNuH01
	 7gAOPDEY8LRBt5UM9LrfyEg/dhstTxasn2XXrVmtAStzZ2tnfWyM+bmnedaES1yqa4
	 qNjCwYouF811A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Mattijs Korpershoek <mkorpershoek@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/4] i2c: qcom-geni: Move resource initialization to separate function
Date: Tue, 29 Sep 2026 08:46:15 -0400
Message-ID: <20260929124617.3453155-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929124617.3453155-1-sashal@kernel.org>
References: <2026092906-elude-repurpose-c794@gregkh>
 <20260929124617.3453155-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Praveen Talari <praveen.talari@oss.qualcomm.com>

[ Upstream commit ed4b34033db25a0f35bb84289377e1916ffe2329 ]

Refactor the resource initialization in geni_i2c_probe() by introducing
a new geni_i2c_resources_init() function and utilizing the common
geni_se_resources_init() framework and clock frequency mapping, making the
probe function cleaner.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260617-enable-i2c-on-sa8255p-v7-3-ad736dbeab57@oss.qualcomm.com
Stable-dep-of: cb97bf3d4f91 ("i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 64 +++++++++++-------------------
 1 file changed, 24 insertions(+), 40 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 94403eb707f7c..a02977a644edf 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -107,7 +107,6 @@ struct geni_i2c_dev {
 	int cur_wr;
 	int cur_rd;
 	spinlock_t lock;
-	struct clk *core_clk;
 	u32 clk_freq_out;
 	const struct geni_i2c_clk_fld *clk_fld;
 	void *dma_buf;
@@ -124,8 +123,6 @@ struct geni_i2c_dev {
 };
 
 struct geni_i2c_desc {
-	bool has_core_clk;
-	char *icc_ddr;
 	bool no_dma_support;
 	unsigned int tx_fifo_depth;
 };
@@ -1058,6 +1055,23 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 	return ret;
 }
 
+static int geni_i2c_resources_init(struct geni_i2c_dev *gi2c)
+{
+	int ret;
+
+	ret = geni_se_resources_init(&gi2c->se);
+	if (ret)
+		return ret;
+
+	ret = geni_i2c_clk_map_idx(gi2c);
+	if (ret)
+		return dev_err_probe(gi2c->se.dev, ret, "Invalid clk frequency %d Hz\n",
+				     gi2c->clk_freq_out);
+
+	return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
+				  Bps_to_icc(gi2c->clk_freq_out));
+}
+
 static int geni_i2c_probe(struct platform_device *pdev)
 {
 	struct geni_i2c_dev *gi2c;
@@ -1077,16 +1091,6 @@ static int geni_i2c_probe(struct platform_device *pdev)
 
 	desc = device_get_match_data(&pdev->dev);
 
-	if (desc && desc->has_core_clk) {
-		gi2c->core_clk = devm_clk_get(dev, "core");
-		if (IS_ERR(gi2c->core_clk))
-			return PTR_ERR(gi2c->core_clk);
-	}
-
-	gi2c->se.clk = devm_clk_get(dev, "se");
-	if (IS_ERR(gi2c->se.clk) && !has_acpi_companion(dev))
-		return PTR_ERR(gi2c->se.clk);
-
 	ret = device_property_read_u32(dev, "clock-frequency",
 				       &gi2c->clk_freq_out);
 	if (ret) {
@@ -1101,16 +1105,15 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	if (gi2c->irq < 0)
 		return gi2c->irq;
 
-	ret = geni_i2c_clk_map_idx(gi2c);
-	if (ret)
-		return dev_err_probe(dev, ret, "Invalid clk frequency %d Hz\n",
-				     gi2c->clk_freq_out);
-
 	gi2c->adap.algo = &geni_i2c_algo;
 	init_completion(&gi2c->done);
 	spin_lock_init(&gi2c->lock);
 	platform_set_drvdata(pdev, gi2c);
 
+	ret = geni_i2c_resources_init(gi2c);
+	if (ret)
+		return ret;
+
 	/* Keep interrupts disabled initially to allow for low-power modes */
 	ret = devm_request_irq(dev, gi2c->irq, geni_i2c_irq, IRQF_NO_AUTOEN,
 			       dev_name(dev), gi2c);
@@ -1123,23 +1126,6 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	gi2c->adap.dev.of_node = dev->of_node;
 	strscpy(gi2c->adap.name, "Geni-I2C", sizeof(gi2c->adap.name));
 
-	ret = geni_icc_get(&gi2c->se, desc ? desc->icc_ddr : "qup-memory");
-	if (ret)
-		return ret;
-	/*
-	 * Set the bus quota for core and cpu to a reasonable value for
-	 * register access.
-	 * Set quota for DDR based on bus speed.
-	 */
-	gi2c->se.icc_paths[GENI_TO_CORE].avg_bw = GENI_DEFAULT_BW;
-	gi2c->se.icc_paths[CPU_TO_GENI].avg_bw = GENI_DEFAULT_BW;
-	if (!desc || desc->icc_ddr)
-		gi2c->se.icc_paths[GENI_TO_DDR].avg_bw = Bps_to_icc(gi2c->clk_freq_out);
-
-	ret = geni_icc_set_bw(&gi2c->se);
-	if (ret)
-		return ret;
-
 	pm_runtime_set_suspended(gi2c->se.dev);
 	pm_runtime_set_autosuspend_delay(gi2c->se.dev, I2C_AUTO_SUSPEND_DELAY);
 	pm_runtime_use_autosuspend(gi2c->se.dev);
@@ -1192,7 +1178,7 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
 		return ret;
 	}
 
-	clk_disable_unprepare(gi2c->core_clk);
+	clk_disable_unprepare(gi2c->se.core_clk);
 
 	return geni_icc_disable(&gi2c->se);
 }
@@ -1206,7 +1192,7 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(gi2c->core_clk);
+	ret = clk_prepare_enable(gi2c->se.core_clk);
 	if (ret)
 		goto out_icc_disable;
 
@@ -1219,7 +1205,7 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 	return 0;
 
 out_clk_disable:
-	clk_disable_unprepare(gi2c->core_clk);
+	clk_disable_unprepare(gi2c->se.core_clk);
 out_icc_disable:
 	geni_icc_disable(&gi2c->se);
 
@@ -1260,8 +1246,6 @@ static const struct dev_pm_ops geni_i2c_pm_ops = {
 };
 
 static const struct geni_i2c_desc i2c_master_hub = {
-	.has_core_clk = true,
-	.icc_ddr = NULL,
 	.no_dma_support = true,
 	.tx_fifo_depth = 16,
 };
-- 
2.53.0

