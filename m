Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7708397347
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664437; cv=none; b=nh0XH4uDxH2ayAW4dbZPUqpJ79hmdaMQJdSRwZGPxEEhowVI7vPTclyxuI5j4h/436eS3HK2eF8ZfkSjxRqbgX4OXW1SkM9S2jUXvyvwhVqep50C4k+QGAmaiZenqgwKnQg3+mtKk9w2UCvQBLBbALS0jt/GBJEyJ7sX/r9xXjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664437; c=relaxed/simple;
	bh=B69LDSmtknt4aUkNNH2rE6JCZQE5iBdfylYO2nslGcY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YxU2GqRN8f+T4UulyzrtLkXZLHCSgQwgKPuHP0C760JG5rs8/q7dVSTkcLTOvHeTB1gasGWDflslKbHIYRJTDg8cTamtw8+DOJyM3Jgw+Cb68wLmF81tDc8xl9GTncKf5einRP1DVgfZevCQuvR6i//G9DB2LFO5VLv/005GnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qz3te7FO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qz3te7FO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CCA1F000FF;
	Tue, 29 Sep 2026 06:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790664435;
	bh=ddJCa08bLMS1PeK/HQQnRSJh+sdWGOTXFDdNLRbge0o=;
	h=Subject:To:Cc:From:Date;
	b=Qz3te7FOnJ7HMiX5evVpVKHgLGqej4c02gCWUFVG34x1+08r4is7P1SKcBuo7TgKH
	 710Gj6HmooJ6vriBmjDbmqJ6hzCnWuw81u0qGuCadfLGRIxggTX12GXdrGiSJVcyjs
	 cjc8MgMefzNlk51hM//hgEZJrDs3pBj0tSCJQBJg=
Subject: FAILED: patch "[PATCH] i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL" failed to apply to 6.12-stable tree
To: viken.dadhaniya@oss.qualcomm.com,andi.shyti@kernel.org,mukesh.savaliya@oss.qualcomm.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 08:47:07 +0200
Message-ID: <2026092907-manger-seldom-b2ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x cb97bf3d4f91453b881acaf8e9f0cc47bb40b604
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092907-manger-seldom-b2ad@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cb97bf3d4f91453b881acaf8e9f0cc47bb40b604 Mon Sep 17 00:00:00 2001
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 17:17:01 +0530
Subject: [PATCH] i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL

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

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index e9e41a174c20..6a39e21d5ed4 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -82,6 +82,9 @@ enum geni_i2c_err_code {
 #define XFER_TIMEOUT		HZ
 #define RST_TIMEOUT		HZ
 
+#define GENI_SE_CLK_32MHZ	(32 * HZ_PER_MHZ)
+#define GENI_SE_CLK_19P2MHZ	19200000UL
+
 struct geni_i2c_desc {
 	bool no_dma_support;
 	unsigned int tx_fifo_depth;
@@ -127,6 +130,7 @@ struct geni_i2c_dev {
 	spinlock_t lock;
 	u32 clk_freq_out;
 	const struct geni_i2c_clk_fld *clk_fld;
+	u32 clk_idx;
 	void *dma_buf;
 	size_t xfer_len;
 	dma_addr_t dma_addr;
@@ -197,19 +201,44 @@ static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
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
 
@@ -219,7 +248,7 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
 	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
 	u32 val;
 
-	writel_relaxed(0, gi2c->se.base + SE_GENI_CLK_SEL);
+	writel_relaxed(gi2c->clk_idx, gi2c->se.base + SE_GENI_CLK_SEL);
 
 	val = (itr->clk_div << CLK_DIV_SHFT) | SER_CLK_EN;
 	writel_relaxed(val, gi2c->se.base + GENI_SER_M_CLK_CFG);
@@ -1111,8 +1140,7 @@ static int geni_i2c_resources_init(struct geni_se *se)
 
 	ret = geni_i2c_clk_map_idx(gi2c);
 	if (ret)
-		return dev_err_probe(gi2c->se.dev, ret, "Invalid clk frequency %d Hz\n",
-				     gi2c->clk_freq_out);
+		return ret;
 
 	return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
 				  Bps_to_icc(gi2c->clk_freq_out));

