Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541868;
	b=q5cT1CFbkPl38HdnJ8jKkAnoVT0w5NXjG4CqowAE7ZUExtoIECZyhru6eHeUzcp2sGdR
	 GXVzSdWumctcJipzF5nHxQUqLERoesfTf09miBX1X9pFbOYaIq6L8sBL8UQpts8+X/LUq
	 CCVFYu01qFPYgsRaA4pEn9b5akaaaYnGfm7AcAqZjVjk5BpyIQQZWYtXqreOnPc8ZAVJH
	 OR58VP7aWhAkLEYtXpgIl9d+VHTtEQQVH33YtS9IC6f4VURvjd6NfylcLXYcKTL7yZ5FI
	 b6y/Lgm18gdMPku6CSXk0X36wj8ZEanDOIuNqOj8i6HtgCRZYevb6xlQkjP/qIdNJFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541868;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8Ru3F+1AhaGJKmQnbOij53xiM6aZ93gudvcU501r+wA=;
	b=4v9hVSb3XwYg6Ho46zelKLRLrS0J7Ra6boVYkhqWVqHI3npuQR2Np3sqjUH8fHF9u/86
	 Hg9HUUhrH0LEDfY8S7F/BVu1SOzhwcWNIHaRT4FYixXFEIiLjED8EJgoEGMfpZmvz06Z3
	 uMLi78C3/6PL0zrEr6aR0Dzc/jr8eEjTYuhHqqVlVRNH70ikNcY3qx12bYKaxdAG9d8NB
	 vkxufF1S8v/7s8d4K9SfuusBQFI/xa/NxybjTvxCD1QCnn4Av1h2+dzSZV76eKpa1ayvE
	 ALPDsqGv5S6WadjQhF290Bw7NpjXGV2HT71SCYyF1TiJf5l4o3OGS0IR/nE713GutPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Xo/v3riw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CE7606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xo/v3riw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D1C1F000C4;
	Tue, 24 Nov 2026 17:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795541868;
	bh=8Ru3F+1AhaGJKmQnbOij53xiM6aZ93gudvcU501r+wA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xo/v3riwSJn3SP3Q4R6C1pLxDXu44o6oDMYAbvuxaJ9QUuAxZEnw8480UTBFvd9xW
	 trTX2mKy5rC1W20l8raWBdmw2jrNcp4hqXboaNEk/V6/LMwUgMpnDeQbRNuMjN2Awl
	 rHRyPBLVupZKhTamxqTH+riM5IwUqRWHvUlnNoHwcZ3qj0VkSvGuTKU48k0xtY1bU/
	 1n3tlnRMOEavZ4tUhzloJy5yEPwckDhVHiBPsct+67hisFRpQWCFjHYbDpe9DMMvm2
	 fcJyentmNlrrrhBTybRVKHTd2nXJ/sPr8TdmF1QodmJZO9mspJgDvNNwURoBTRpzqI
	 4H+Xa0yGb588A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anfernee Cao <anferneemelokc5@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] mmc: sunxi: fix clock and runtime PM leaks on probe failure
Date: Tue, 24 Nov 2026 12:37:44 -0500
Message-ID: <20261124173733.2004923-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124173733.2004923-1-sashal@kernel.org>
References: <2026112459-diameter-aroma-1a35@gregkh>
 <20261124173733.2004923-1-sashal@kernel.org>
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
index cc7c8594a6cac..785899eb9f868 100644
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
@@ -1386,9 +1391,11 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
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
@@ -1468,7 +1475,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
 	ret = mmc_add_host(mmc);
 	if (ret)
-		goto error_free_dma;
+		goto error_disable_rpm;
 
 	dev_info(&pdev->dev, "initialized, max. request size: %u KB%s\n",
 		 mmc->max_req_size >> 10,
@@ -1476,8 +1483,13 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
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

