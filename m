Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533055;
	b=qE7JO2GzFvAMlQ7WNJQZPvkVHEut2u92a0aVqAj1rz6tIPg/jSOlR74Hh12VctATq98U
	 0xJMMvoCjDTUu9Ht/zCXRlt1cOllis2bqqEAagHPTchQ1zA79kb1+5L1SRZcBfAR3rUDa
	 NtcwHUNDstzjkcdVJSdNz+lHVXnhKDwQMAC1N0RLlNAKmyEO+hy+FZk3NVf0dcuIZcB3z
	 wuC3uyvetcc+wspK1+BI09rKw+IhLynJYpuIXgTd14hWVtJUhJL1I4pyHz2kyN8fSCrqX
	 3zr8kJ/EQ6RHfgDOxYRD1nrBQP9H8UAq5r+VzE1QoU/D3AOOXBg3pxLgYWeuoZkABRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533055;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9Ss7BXi4WSEmDpeMvPKsqBRjWVYsV7DXDjmIYdPfJ+8=;
	b=2XxCYwWL9fMjhbmBCI1Vd7J7Hp8Tcz5ps4lCO/FVzW8rH6WR9V6rKIzQ/g5FWQfnuo9M
	 4tB9fWGkAs0oqy03wKekOxkAxcOg9w9ovSvHXfurj6ZIf8qzMFbkScEFj+ZZwedlJVQdt
	 1gyqCWXqt/n5iD6J/kWPC5I16H4zyBPkzw2qZr3juTMyu/DoHSLw5voORBCt6cxfEloOg
	 icrLRcf1HtwZYKdjkW+6LmGC21JbgBlOIwxDyFcLnFPJbBjPi4vqvCxtYqLn62k+cg+x0
	 pdC9TtF/KndIoCnt/o+FhVB7VPAVSf61a7bcnuXfKsDvqDlAWdjcBX6366Vw9MnmKJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CrlSUQhG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81986606A329
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CrlSUQhG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40A11F000C6;
	Tue, 24 Nov 2026 15:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795533055;
	bh=9Ss7BXi4WSEmDpeMvPKsqBRjWVYsV7DXDjmIYdPfJ+8=;
	h=Subject:To:Cc:From:Date;
	b=CrlSUQhGshb1smc7Dw+u3qQan48NsvabnjshX7kSipKURWeDQ25qBD8u0/EULLV1M
	 L7IBwBpkQ18tgYBR3JakS8t3msRU0UXqwynHSb1zWR+1GnGADekuhMrlDAJ7pnWIUV
	 IkhyEv2UCo2xc3/cpd/1yjC5pN4Ko8+awXiM7JOc=
Subject: FAILED: patch "[PATCH] mmc: sunxi: fix clock and runtime PM leaks on probe failure" failed to apply to 5.15-stable tree
To: anferneemelokc5@gmail.com,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:11:00 +0100
Message-ID: <2026112400-cope-retiree-6c55@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e35e360bd66898a977c296ab71fe4bae17ddceb7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112400-cope-retiree-6c55@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e35e360bd66898a977c296ab71fe4bae17ddceb7 Mon Sep 17 00:00:00 2001
From: Anfernee Cao <anferneemelokc5@gmail.com>
Date: Tue, 20 Oct 2026 23:36:47 +0800
Subject: [PATCH] mmc: sunxi: fix clock and runtime PM leaks on probe failure

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

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index fe4c0f6d73f3..437fdadb5950 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1354,8 +1354,13 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
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
@@ -1385,9 +1390,11 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
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
@@ -1467,7 +1474,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
 	ret = mmc_add_host(mmc);
 	if (ret)
-		goto error_free_dma;
+		goto error_disable_rpm;
 
 	dev_info(&pdev->dev, "initialized, max. request size: %u KB%s\n",
 		 mmc->max_req_size >> 10,
@@ -1475,8 +1482,13 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
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
 

