Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545475;
	b=YxWAkeXmP2biLKSOSjbMR4zR1W5v6ZLv5Qti8T2c1zs6Dedqzh22MvAGOiSVrXi27EGC
	 DViIfdPleEn+znEC8Izg+K7WkaCQTukw0DjHU03GtyRPVkWDH/moMnquX2UPqqvvwUMzz
	 C68nyPi2t47uKAq0UXklq2iSg7EK9UjJg8uGXZPkbBCccV26u0OGyJtNmANxMjH0u+hcX
	 93puDFxxvvkbZh6G6QODR342sL24/6Bo+R59hSLRQ/ay+79dBzrvzfAcD1jhx9HhPu5fK
	 BHvmgpzhE44UDQZTiLBbSKIEcr/7HsVVupqI380m0YaYoPTmhr24qWxS3BGIN9uSxZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545475;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WJJZeBOhofHvkf2rAGKIGxWkTEaW5R4jEFxuszy60lY=;
	b=zJpJq3D5lVpSTzF7pfrSutbzyhIL6+uox2PWX3p37uNBDzD2trDwLRfWfoxog0yVK5O7
	 eZ1O4swiiz0PjlXgRUASEL3QfHxr0TrpgiXp+Un0ydp6QvisBDIuvaOZO/YUZTCjGuDbi
	 dUphitgPYaSSV+X0oqoYhIZkmmH8z70SpsmGRXz8GRA8zmy+M3uum6GPqZp9M5mC7Z7X5
	 maueN2ZXnNZK0Xmm4DBRkqZ4kzM86fJT4YCjUJhagKUMucr5FcZcBQ7CeB2blwef/r8pV
	 o87IizxQxZ5pC60neVVt88pTJcB+iCgdIihMcZf/QOZr1eKMbG2YyPbs2r5Pezj3sog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5Ux9kic;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FA8606A323
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5Ux9kic
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC1E1F000C6;
	Tue, 24 Nov 2026 18:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795545474;
	bh=WJJZeBOhofHvkf2rAGKIGxWkTEaW5R4jEFxuszy60lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G5Ux9kic6ad4Cd1/KytHJynKiZsI/tXsKzsEJL2ob8QoEeIQHHs06WNIO/CTByJV8
	 xec5Haq2CCMh4Jj7S1cqfSVFhk6Vr1CuSmclXUoydzzQAGEX0zxiXST36C05r8omBf
	 miuImZkJJRYlneLFR1liRTt/5m5ON3zFiozDG611CudIZDtjJhYvIbQatIyB9fOHQL
	 OMSaMJEK5zX1UGUAEbAVI0KFTlWU9QWsUaM9+q/fwCM95qntSskqHMB+3/ZxhmQCMa
	 iknpNT5K067UkTLpgX6zQwkhRZAK4c3TgNiz8XK1o1iU5a+ETrw5QC/moxMutesOIQ
	 0JjS//nYoiCyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anfernee Cao <anferneemelokc5@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] mmc: sunxi: fix clock and runtime PM leaks on probe failure
Date: Tue, 24 Nov 2026 13:37:49 -0500
Message-ID: <20261124183704.2394957-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124183704.2394957-1-sashal@kernel.org>
References: <2026112400-clumsy-mobile-79f3@gregkh>
 <20261124183704.2394957-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sunxi-mmc.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 9f8d20be1926b..8a65d538d115d 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1322,8 +1322,13 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
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
@@ -1353,9 +1358,11 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
 	host->sg_cpu = dma_alloc_coherent(&pdev->dev, PAGE_SIZE,
 					  &host->sg_dma, GFP_KERNEL);
-	if (!host->sg_cpu)
-		return dev_err_probe(&pdev->dev, -ENOMEM,
-				     "Failed to allocate DMA descriptor mem\n");
+	if (!host->sg_cpu) {
+		ret = dev_err_probe(&pdev->dev, -ENOMEM,
+				    "Failed to allocate DMA descriptor mem\n");
+		goto error_disable_mmc;
+	}
 
 	if (host->cfg->ccu_has_timings_switch) {
 		/*
@@ -1435,7 +1442,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
 	ret = mmc_add_host(mmc);
 	if (ret)
-		goto error_free_dma;
+		goto error_disable_rpm;
 
 	dev_info(&pdev->dev, "initialized, max. request size: %u KB%s\n",
 		 mmc->max_req_size >> 10,
@@ -1443,8 +1450,13 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
 	return 0;
 
+error_disable_rpm:
+	pm_runtime_disable(&pdev->dev);
 error_free_dma:
 	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
+error_disable_mmc:
+	disable_irq(host->irq);
+	sunxi_mmc_disable(host);
 	return ret;
 }
 
-- 
2.53.0

