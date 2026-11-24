Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795544341;
	b=AG9o7FIKk43CX3rVLNwEnxGM3yKo4owxlHYhXcpItGWSpAMsRm8j0TfEcNiP3V4A7JT8
	 z5gz4HR3DjkE4n2bbTryicvLBU/COEX/Nn1MbKLVR4CBlnJV6vPJqh9auGYicfXvQATNl
	 g67fqr59EcShdMwZ3a4u54mIGqe6CQr62KPE9wKpRIX9nWhsFFhmXPiHYj8YCcP4oguRO
	 n/Z1R3N0x4/YpnnDd3E00WvY+MpeCqpqqWtL6NTaAjarGu4r9bdqHkhFyonVebw1KNq3m
	 Qsp6qVuw9C/30NrHEGHzNSgsJicc4371hgA+PLfbARXe1jzbogsUzGz0kei9DefcGPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544341;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bNO9YIUJ//sKhPtWveWkupKCWT4jJeib/STXIYwEYzc=;
	b=Ign+qPHuv6wXOBl4DsX+mKGow1exVk/dTdJYA6Ac/ky7H4C8Oa2M+yumNzMiT67rQS/E
	 l5ZJJ2ZM/8Ez+xCpGd8s+X+21RwU27W4NOsj+nn30fNQWWWkNLked9FdHCKs+LetquSMd
	 rhnaHa6QZxoeXgRNYv+6SV7RWqmxqeRBCjkSFZtfdfeyv/lImnazvvF7ZEauMr9O6IPNE
	 1og7jvVqu2dR/sqh12OaD5iVpKq3aTIKmV5ZC16V3atehnMaLEaENZAj6FcFmFbCGZvoS
	 UF85BpOlUKo+SUC+XauQMx61IUzZZs9BNadDdlWdys8lVcklKGYQKvg+oXUUCD0pvoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dETGIIIn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC586606A337
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dETGIIIn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091151F000D0;
	Tue, 24 Nov 2026 18:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795544341;
	bh=bNO9YIUJ//sKhPtWveWkupKCWT4jJeib/STXIYwEYzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dETGIIInQo+LL1pYynwXOVRWRwRbMQfFIK1CKlG7yiwPIYfo3GUX+pfZFpcKP8oB0
	 vPWBQqw39VzzO8ApIafLaKqnyAcXArVb7Awy8q+F5XquA6SAWuVhBKFCtOfZgwgz3w
	 UOlGZ8G1dsk87m2NTfeBvWZiFOabuugK3hxJf1Fp5Vetd4t06AbYemXJ+o+MwBCRI/
	 wPMX19D3RPe7a0lsxeRi7uBIXuU6rSCVIxjJPcgTtsWq9jFtQqZNb3jhcq2vAiiyxw
	 p8dzCccuIVlhRBXXd+lp4pWBgnt4JYfmxF7ljzalJIyJx19w2mnQZoH/osVglTkw0Y
	 HepgTmaNZBC7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anfernee Cao <anferneemelokc5@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mmc: sunxi: fix clock and runtime PM leaks on probe failure
Date: Tue, 24 Nov 2026 13:18:59 -0500
Message-ID: <20261124181817.2362922-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112400-cope-retiree-6c55@gregkh>
References: <2026112400-cope-retiree-6c55@gregkh>
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
[ sashal: Adapted the DMA allocation failure path to the older dev_err()/ret = -ENOMEM form, redirecting its goto from error_free_host to error_disable_mmc. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sunxi-mmc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 1b6e41d55b622..cc4fddd68430a 100644
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

