Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7AD27456
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 00:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787530161; cv=none; b=MWhh2KqhYU/0OnBoYapgsi6DrUlSH627/GGiiFzJieBBvU4wO5v4tESAoB4bCKoUORVfHc/5BFQis5MSe3Y7da2Q4X00J3uhAo4LRWLN0mwCdeOQAQLN6N2SC9P5pxRLo3OId9022zBzuKSYCRab9Mcs/FKoNFTce2txQpSNpAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787530161; c=relaxed/simple;
	bh=E4CjhfDKl946NXoL7tPParD1KA+vi177j3DvqPJcnp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjwVkMlEQEH8Um9017xMqkQp8VGd1Tew6SHWNr/VLvKhYpY/y4IYQOx9xXAI6fz4UwNmzFlt6vxq/nOFJP07ucuwiiJ/tuadP9IsPAXN5ArrO/7he/e/JpQzj9fy0NccNZcBvH9LavF0VTgYb25dG/Ojeiwjfo/8MX/IWGgpaVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H//CIMrA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H//CIMrA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDE51F000E9;
	Mon, 24 Aug 2026 00:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787530159;
	bh=+pmwWcrEYHFSq+9/i7q8BzOZONy75OkW6cLypZasKzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H//CIMrAfCP8Wc91lCuXmkwya8xW4z+Bj0DZaOTXlO1EQXY7fJawuJP1BslqV3ixp
	 e9oAvGU0F8cP7zxFaIoVRZQiINiOHO/Xw09XLc5PuUPyb8sQJ0d57sQ3aYuOINPFKI
	 lyGEoiIWNOJYE9OWvfAxyCLmFmvDerOsalPnxvM0fP69OY3y51l2PSy4w+qSVNRq0p
	 6wsPlFj7F3+JYjjrSLAHdHW64+lYzhunA2E4u2C7Wm1TPL5S/IAlFA2Ce4aBRLH7YH
	 p/kGhHToeSJuD6nCk5PyQKIFee4AR517/JVwhWNz67H01bfzAZGl8ou2TiMlKT/QYt
	 wfsL7nXfSO1VQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mmc: atmel-mci: Fix use-after-free in atmci_remove due to race condition
Date: Sun, 23 Aug 2026 20:09:17 -0400
Message-ID: <20260824000917.2648691-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082118-populace-yelling-480d@gregkh>
References: <2026082118-populace-yelling-480d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

[ Upstream commit c125ee35a49a0518521b52b27631eef061b8719a ]

In atmci_probe, &host->bh_work is bound with atmci_work_func, and
atmci_interrupt, atmci_timeout_timer and atmci_dma_complete can all
queue this work on system_bh_wq.

If we remove the module, atmci_remove makes cleanup and the memory
allocated for host with devm_kzalloc() is released after the remove
callback returns, while the work mentioned above may still be pending
or running. The sequence of operations that may lead to a UAF bug is
as follows:

CPU0                                      CPU1

                                          | atmci_interrupt
                                          | queue_work(system_bh_wq,
                                          |            &host->bh_work)
atmci_remove                              |
atmci_cleanup_slot(...)                   |
atmci_writel(host, ATMCI_IDR, ~0UL)       |
timer_delete_sync(&host->timer)           |
dma_release_channel(host->dma.chan)       |
free_irq(platform_get_irq(pdev, 0), host) |
                                          | atmci_work_func
                                          | // use host
// devm resources released after          |
// remove returns, host is freed          |
                                          | // use host (use-after-free)

Fix it by canceling the work after all the sources that can schedule
it (IRQ handler, timeout timer and DMA completion callback) have been
stopped, and before proceeding with the remaining cleanup in
atmci_remove.

Fixes: 7d2be0749a59 ("atmel-mci: Driver for Atmel on-chip MMC controllers")
Assisted-by: Codex:deepseek-v4-flash
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/atmel-mci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index bd53d8b75dcac..b6bfb6746b906 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2629,6 +2629,8 @@ static int atmci_remove(struct platform_device *pdev)
 
 	free_irq(platform_get_irq(pdev, 0), host);
 
+	tasklet_kill(&host->tasklet);
+
 	clk_disable_unprepare(host->mck);
 
 	pm_runtime_disable(&pdev->dev);
-- 
2.53.0

