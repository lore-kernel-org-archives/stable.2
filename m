Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6BA577E33;
	Tue,  8 Sep 2026 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882868; cv=none; b=cQxFwKmctJAISodCeK1BHx1dLpz0qK7ez2zPGzLxJppdJlAM7VWxQ66ayIP7lEmixRgKiyK7hdBXTOsMG3OxV2EXLUNJyJ9ZkFovCvjtZRgdtFfFNsZkopeOBhMxd7GYW30y3skqcQXLFCK4YUiypFN/YQlaow8hnSWdUj4sBrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882868; c=relaxed/simple;
	bh=544WQVZJeLYU7v3G3MGtP5wW/6wUd4jsHuoiTAyywkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agkCoeARINLU3p9iaKNDV9KtcFmRLM6ZeEqfNPD42cnWQI7pgp/EERgcKziTXa358v7WzbHM6XeB8R8ElnK3XijU3w4JH88/AsVrpkyfe30kIDS1IAIzN/hBVL9HFEg48ZPDehEExXrUmi0HaBgXGqwR+P43NGvfr9EhRQWyOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=aIw64BHE; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=Xg8CIWyR; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="aIw64BHE";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="Xg8CIWyR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882860; bh=544WQVZJeLYU7v3G3MGtP5wW/6wUd4jsHuoiTAyywkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aIw64BHEoFwpTyNfvqzK2TRt2nOMS7w6u/EZi4Y0ZZyFRNfImD86dTTMfsVtLjKml
	 yWGXMmouPlN0KuPd3YYEex0NK9ZjCNDSPGHMeZ6/aibgNzomTHD2/MUm4KrCLOUgsv
	 FXwR32grs7S99MvkTQ8+XXrZ9XCQugmWeJCX4KaY1aGH8+WUXG5nY1z8PW/sp62ncu
	 vIK1bp39OgPYxCzgZR0XKwXfs523gKPaFOM8w0u2WcsAvA4I1XdPlhIBwKJ/5tUAbS
	 w591iMlosBxqvLLr06kapvOG+bdDGYUxRON7BdtBM9aTGjpFJVi0M+Fk1bEe9XkEz7
	 U54wvp9RxjTsg==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 74DE041451; Tue, 08 Sep 2026 16:54:20 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882859; bh=544WQVZJeLYU7v3G3MGtP5wW/6wUd4jsHuoiTAyywkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xg8CIWyRctIvMnvVyP9XewMQybVqg7b0YVC9pBXSJDIIXjbCJM57nZV6iaz+upguk
	 YNWyb1p62KeV1qLiCNAOaChsiNQs3xICig85+PgOlWRKuJfp5NN9EOqtV3pmHbt2Eq
	 S0ohvTyhnl9tftVoH/ksQ8FoYY5jp/dHHlHX5nKslIxjffz56vzT2KI4Juniw8UN6Q
	 JdA+183T5aKi/XOpf2SNaboyUIZYorzzfux1cwHpb3A8v6KMqHBpep2Ig1+4Hz7SDs
	 irF3+nAxs/ccSIYQ4TumXsjc/bkariwqAHjTBcTl7TxtrZrAfsi/EY/UTnf1LJ5PKe
	 Mw9rvycksrMgw==
Received: from maru.home (host86-150-50-53.range86-150.btcentralplus.com [86.150.50.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 0EAE141448;
	Tue, 08 Sep 2026 16:54:19 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 19/19] media: meson-ir-tx: Validate carrier and duty_cycle
Date: Tue,  8 Sep 2026 16:52:07 +0100
Message-ID: <528055c59611d6711e15b05c5ab150d4d3d338af.1788882189.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788882189.git.sean@mess.org>
References: <cover.1788882189.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible to set a combination of carrier and duty cycle that do
not produce a correct signal. In addition, setting a carrier larger
than USEC_PER_SEC will result in a divide by zero in
meson_irtx_prepare_pulse() during transmit.

Fixes: 49be1c78d575 ("media: rc: introduce Meson IR TX driver")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/meson-ir-tx.c | 54 +++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/media/rc/meson-ir-tx.c b/drivers/media/rc/meson-ir-tx.c
index 1ab898069e67..a410464ede22 100644
--- a/drivers/media/rc/meson-ir-tx.c
+++ b/drivers/media/rc/meson-ir-tx.c
@@ -76,11 +76,24 @@ struct meson_irtx {
 	unsigned long clk_rate;
 };
 
-static void meson_irtx_set_mod(struct meson_irtx *ir)
+static bool meson_irtx_calc_mod(unsigned long clk_rate, u32 carrier,
+				u32 duty_cycle, unsigned int *pulse_cnt,
+				unsigned int *space_cnt)
 {
-	unsigned int cnt = DIV_ROUND_CLOSEST(ir->clk_rate, ir->carrier);
-	unsigned int pulse_cnt = DIV_ROUND_CLOSEST(cnt * ir->duty_cycle, 100);
-	unsigned int space_cnt = cnt - pulse_cnt;
+	unsigned int cnt;
+
+	cnt = DIV_ROUND_CLOSEST(clk_rate, carrier);
+	*pulse_cnt = DIV_ROUND_CLOSEST(cnt * duty_cycle, 100);
+	*space_cnt = cnt - *pulse_cnt;
+
+	return *pulse_cnt >= 1 && *pulse_cnt <= 65536 &&
+	       *space_cnt >= 1 && *space_cnt <= 65536;
+}
+
+static void meson_irtx_write_mod(struct meson_irtx *ir, unsigned int pulse_cnt,
+				 unsigned int space_cnt)
+{
+	unsigned int cnt = pulse_cnt + space_cnt;
 
 	dev_dbg(ir->dev, "F_mod = %uHz, T_mod = %luns, duty_cycle = %u%%\n",
 		ir->carrier, NSEC_PER_SEC / ir->clk_rate * cnt,
@@ -90,8 +103,10 @@ static void meson_irtx_set_mod(struct meson_irtx *ir)
 	       ir->reg_base + IRB_ADDR1);
 }
 
-static void meson_irtx_setup(struct meson_irtx *ir, unsigned int clk_nr)
+static int meson_irtx_setup(struct meson_irtx *ir, unsigned int clk_nr)
 {
+	unsigned int pulse_cnt, space_cnt;
+
 	/*
 	 * Disable the TX, set modulator clock tick and set initialize
 	 * output to be high. Set up carrier frequency and duty cycle. Then
@@ -100,13 +115,18 @@ static void meson_irtx_setup(struct meson_irtx *ir, unsigned int clk_nr)
 	 */
 	writel(~IRB_ENABLE & (IRB_MOD_CLK(clk_nr) | IRB_INIT_HIGH),
 	       ir->reg_base + IRB_ADDR0);
-	meson_irtx_set_mod(ir);
+	if (!meson_irtx_calc_mod(ir->clk_rate, ir->carrier, ir->duty_cycle,
+				 &pulse_cnt, &space_cnt))
+		return -EINVAL;
+	meson_irtx_write_mod(ir, pulse_cnt, space_cnt);
 	writel(readl(ir->reg_base + IRB_ADDR0) & ~IRB_INIT_HIGH,
 	       ir->reg_base + IRB_ADDR0);
 	writel(IRB_FIFO_IRQ_ENABLE | MIRTX_FIFO_THD,
 	       ir->reg_base + IRB_ADDR3);
 	writel(readl(ir->reg_base + IRB_ADDR0) | IRB_ENABLE,
 	       ir->reg_base + IRB_ADDR0);
+
+	return 0;
 }
 
 static u32 meson_irtx_prepare_pulse(struct meson_irtx *ir, unsigned int time)
@@ -215,12 +235,17 @@ static irqreturn_t meson_irtx_irqhandler(int irq, void *data)
 static int meson_irtx_set_carrier(struct rc_dev *rc, u32 carrier)
 {
 	struct meson_irtx *ir = rc->priv;
+	unsigned int pulse_cnt, space_cnt;
+
+	if (!carrier)
+		return -EINVAL;
 
-	if (carrier == 0)
+	if (!meson_irtx_calc_mod(ir->clk_rate, carrier, ir->duty_cycle,
+				 &pulse_cnt, &space_cnt))
 		return -EINVAL;
 
 	ir->carrier = carrier;
-	meson_irtx_set_mod(ir);
+	meson_irtx_write_mod(ir, pulse_cnt, space_cnt);
 
 	return 0;
 }
@@ -228,9 +253,14 @@ static int meson_irtx_set_carrier(struct rc_dev *rc, u32 carrier)
 static int meson_irtx_set_duty_cycle(struct rc_dev *rc, u32 duty_cycle)
 {
 	struct meson_irtx *ir = rc->priv;
+	unsigned int pulse_cnt, space_cnt;
+
+	if (!meson_irtx_calc_mod(ir->clk_rate, ir->carrier, duty_cycle,
+				 &pulse_cnt, &space_cnt))
+		return -EINVAL;
 
 	ir->duty_cycle = duty_cycle;
-	meson_irtx_set_mod(ir);
+	meson_irtx_write_mod(ir, pulse_cnt, space_cnt);
 
 	return 0;
 }
@@ -337,7 +367,11 @@ static int meson_irtx_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "modulator clock setup failed\n");
 
-	meson_irtx_setup(ir, clk_nr);
+	ret = meson_irtx_setup(ir, clk_nr);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "carrier %u, duty_cycle %u%% not supported at clk_rate %luHz\n",
+				     ir->carrier, ir->duty_cycle, ir->clk_rate);
 
 	ret = devm_request_irq(dev, irq,
 			       meson_irtx_irqhandler,
-- 
2.55.0

