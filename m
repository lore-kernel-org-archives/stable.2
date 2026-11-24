Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533046;
	b=gumo+TslD1C+glRETo650EuOAb0NycZ7zGQZs2OfJXTqptKqcAQtFeJkNx1w1fMkprc6
	 Uy03aFj+gr26JLLYbF3UDToeXDdvfXlncFqqLGwkc/IvFY/LRGZ2BmJK1fSWzVuOrIRj8
	 fVtohGeXd3OpYE1VbHix6mIW8iR7Fsq0gMvmQwxO7kSMfXWF+S7LqY7JBYMIeov+mEepm
	 HDMv5k0DmBsOkykQVyr7Fxl8XtKl0Ws32Zl3cpv4NTJZwJNAwWqO9m6YU8BouUPQLnNTp
	 OlBQIHwqt8TPUCqPBfkRpQv0+Hxq+YQb8qkUxX3Rg55XZMxd/LcAYGyx6jrS9E0G6yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533046;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=svLTVAxMQf7zY9HfFCNO764RrCit9p3yioxWLpfB5dU=;
	b=UCEVTZLc+GRNDE1k8Vuvi2UfZww3yA8kUX3BVojBmIo1rIUdCZzWj3wbMNyAM0F9/3tb
	 s6GE3q9VwCqzmNZTCeFg6ipS+eeDXElykHeX0gm6l1Ayg6jtt7+VQnOq2ik7UL5v/IeKG
	 MA9vdqZpt60vc4Pd5/euTEEuJuoHdZvQE2PckIdR4ZN2ajyj7fo3Tqy+0sL5ZVLOln1AW
	 oHF3lE6HJOQUXXNUf44s9KwWpWpnUWZHik1Gx11pf5phX0w0t9pTLqefo5PcNQs4Ta8Mb
	 x7EzdKFJoG/cceF7vLU3wQzKGo79cZjrJDMK8fQYtLWgs/RGWKDUHo0rTLO6xgefzKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="OA/OKsL5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9F1606A323
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OA/OKsL5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B821F1F000C0;
	Tue, 24 Nov 2026 15:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795533046;
	bh=svLTVAxMQf7zY9HfFCNO764RrCit9p3yioxWLpfB5dU=;
	h=Subject:To:Cc:From:Date;
	b=OA/OKsL55VeWnMSUCZCiYQ26EtGDYF3KeVLRAjmY/lvZG8mCprqOF2nhQ7RhhO26a
	 xurWjUjj5qvkkrgZD0BdUe45NGk6dNc/GfrpXDLncnlKcOF6M/6hnlGeQPeEEhPTmj
	 2TjjetDMUPRM0WCtQ3JJD/jU9z5pH6U+jVA3aw5w=
Subject: FAILED: patch "[PATCH] mmc: sunxi: fix clock and runtime PM leaks on probe failure" failed to apply to 6.6-stable tree
To: anferneemelokc5@gmail.com,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:10:59 +0100
Message-ID: <2026112459-diameter-aroma-1a35@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e35e360bd66898a977c296ab71fe4bae17ddceb7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112459-diameter-aroma-1a35@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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
 

