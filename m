Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543848;
	b=35PKBrJIJPY1Unu5CwYNu+1vregSwhTPQdjInY5Q5NNs0b0BcynK7zVzkE8MdyyOJcn6
	 ej0qdxH8JzjRrEA/m5wpvGzledC6nbmhoEOfzq6JWK5bmsadRVCQ4X4C2dYV/A7OxhQ+M
	 rpHoc6HBev5+j4//V7KhzyyUmRtqOv7O5srXcwHLVQQ2TyYxIMbtjMq4aH0Dl2pLV5+dQ
	 WAOs84FtrSLP41xX767U/PfeY2c7sIcj7T6TJrC0yTftEnFrvHySChsq9eE1DrtwIOEeK
	 +evI7h9UGKNLEp9NfFr/vwu/MYiipdwi/ZXrvDn3RieEv8+xcpgKYkQdutf8KHAL7Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543848;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yCyR1BFeZEiqUjKYK7Si3/a6JwZIAnS+egeRC5eEgak=;
	b=EqT3vqlPR6+y/72cJuR/XbmJPe0QDeufYSRsOtva5kCgsE6Yf/V4dkmjRVPNZaxWXG0u
	 5BiGl7mc83tlBxEo3XnkJ6a9VzLmrwRxhBNJg5m8Bk8TjZ9JxDGim37r1rHVV1SYYSVV2
	 PfHVI+2JowGKUT3Agp9bSk4qNCV7sC6iQ5LHPKO2bCFWI1hulQ7ucN1dUFZ+iV6ITYNBK
	 CYdUghR/3A5jsHNOQB5U89wq81+d6pyEoX1oFdTJfoCcsRRLnnnkScpSSG3BXqpkx+wly
	 xmgMTcf08SJ0cQxgef+FZuGf914c2DTG89wG5v2EwBeWlYdaGNh+OhvN8GffJkRZ6Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PsfLn176;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8880D606A33A
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PsfLn176
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611651F000D4;
	Tue, 24 Nov 2026 18:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795543847;
	bh=yCyR1BFeZEiqUjKYK7Si3/a6JwZIAnS+egeRC5eEgak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PsfLn176igkcsgal9cw6vbAf0Cm5CZEkAzFJGMYy7lPKeC03Hu+x4DJpxOSI5WC/q
	 hxDSIpQ1M6yZOwVJcx0E3zdAE7nzXPF/FVw3Et9AZ997oKalj489P4QVbCbU8tCuPn
	 Hdaf1ZdF82GW/FxhRwlI9T37bk09nOZjTd+2weeVJZ2S/O9Ei+O09t4PFuuuOIFwXm
	 T36h5ZGBf57h98eTeWWwb1n88+Mw78vBQXflCJa0XFK2xiIGN/O0sO4+t7gxcfUz/q
	 nPoWu79HGHV/blLfVixVOGi8UjgkZgqzTA2hIG7jSO4lPKff4SV8BLXv5rOibtR9di
	 ZwYcwM2G8GO+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anfernee Cao <anferneemelokc5@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mmc: sunxi: fix clock and runtime PM leaks on probe failure
Date: Tue, 24 Nov 2026 13:10:46 -0500
Message-ID: <20261124181007.2201420-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112459-scariness-levitate-edc6@gregkh>
References: <2026112459-scariness-levitate-edc6@gregkh>
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

From: Anfernee Cao <anferneemelokc5@gmail.com>

[ Upstream commit e35e360bd66898a977c296ab71fe4bae17ddceb7 ]

sunxi_mmc_resource_request() enables the bus, card, output and sample
clocks before returning. Several failure paths later in
sunxi_mmc_probe() leave them running:

 - If devm_request_threaded_irq() fails, the clocks enabled by
   sunxi_mmc_enable() are never disabled.
 - If dma_alloc_coherent(), mmc_of_parse() or sunxi_mmc_init_host()
   fails, probe only frees the DMA buffer and the mmc_host.
 - If mmc_add_host() fails, runtime PM has already been enabled, but
   pm_runtime_disable() is never called.

Besides leaking the clocks, this leaves the clock enable counts
unbalanced, so a reprobe (for example after -EPROBE_DEFER) calls
clk_prepare_enable() on the same clocks again.

Disable the IRQ and the clocks in the probe error path, and disable
runtime PM on the mmc_add_host() failure path. Also handle a failure of
devm_request_threaded_irq() in sunxi_mmc_resource_request().

Tested with QEMU's orangepi-pc machine: with forced sunxi_mmc_init_host()
and mmc_add_host() failures the MMC clocks stay disabled in clk_summary,
and a normal probe with an emulated SD card still works.

This issue was found by manual code inspection.

Fixes: 3cbcb16095f9 ("mmc: sunxi: Add driver for SD/MMC hosts found on Allwinner sunxi SoCs")
Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
Cc: stable@vger.kernel.org # v4.18+
Signed-off-by: Anfernee Cao <anferneemelokc5@gmail.com>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
[ sashal: Changed the dma_alloc_coherent() failure goto to error_disable_mmc, keeping the older dev_err()/ret = -ENOMEM code instead of upstream's dev_err_probe() form. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sunxi-mmc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index e7f3240a53d87..0105654ec6c83 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1355,8 +1355,13 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 		goto error_disable_mmc;
 	}
 
-	return devm_request_threaded_irq(&pdev->dev, host->irq, sunxi_mmc_irq,
-			sunxi_mmc_handle_manual_stop, 0, "sunxi-mmc", host);
+	ret = devm_request_threaded_irq(&pdev->dev, host->irq, sunxi_mmc_irq,
+					sunxi_mmc_handle_manual_stop, 0,
+					"sunxi-mmc", host);
+	if (ret)
+		goto error_disable_mmc;
+
+	return 0;
 
 error_disable_mmc:
 	sunxi_mmc_disable(host);
@@ -1390,7 +1395,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	if (!host->sg_cpu) {
 		dev_err(&pdev->dev, "Failed to allocate DMA descriptor mem\n");
 		ret = -ENOMEM;
-		goto error_free_host;
+		goto error_disable_mmc;
 	}
 
 	if (host->cfg->ccu_has_timings_switch) {
@@ -1471,7 +1476,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
 	ret = mmc_add_host(mmc);
 	if (ret)
-		goto error_free_dma;
+		goto error_disable_rpm;
 
 	dev_info(&pdev->dev, "initialized, max. request size: %u KB%s\n",
 		 mmc->max_req_size >> 10,
@@ -1479,8 +1484,13 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
 	return 0;
 
+error_disable_rpm:
+	pm_runtime_disable(&pdev->dev);
 error_free_dma:
 	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
+error_disable_mmc:
+	disable_irq(host->irq);
+	sunxi_mmc_disable(host);
 error_free_host:
 	mmc_free_host(mmc);
 	return ret;
-- 
2.53.0

