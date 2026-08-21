Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D3E4BC005
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787322019; cv=none; b=nDIdL+NccptjtwOvVJnguXT4CFAYW8sJGKSeVMJO7HQkSEtxOlNflHCDt3LJue2mlT2c0myIxPBsLddshMwgzEM1Xi62BQLOmGPnAjnnJofgH8yHn98nokAPcc/n/V9bzgKtmP+pajIFG4f13JSRi00BkJGsz+50CBLuvhKkJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787322019; c=relaxed/simple;
	bh=BBXxh2UIzImKjSsHFM+YgUGNDLiL144pefAuXwCSHw0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TEkyPlmfSzg1i+BeEeSuv12V3q8inlukQ5YRJgpZfo16qjkLljty8kmbHhxZwSc8P389dTHUp1IU09BgjC1U3FiEm17KSNhhHdfr8QikBfrbZitlRntaFynGzWg8Fb/SlJKDEa4ilaeuAdVuwY2Z8fMX9fZoiDTf6DF9odk4Y3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K5c7zQF8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K5c7zQF8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840871F00A3D;
	Fri, 21 Aug 2026 14:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787322018;
	bh=MMTjFj/mdJVaOczmZ/uVa2Cg6mP+kzcCj+JGTBKiPuM=;
	h=Subject:To:Cc:From:Date;
	b=K5c7zQF81coifmJa52SUfZLYHHpZWX9hHu0Ry9Aa30rt9+IgxZX2kci4g2135uGGD
	 Fm1YjJa8nNyoBSuZp4zm8rJ7qbEz3gc2jVasmrDFdCi4q7P2b8C+E9aIw7j/PXdiNh
	 oruikzEJmdk26fJC0z+PKnOIpvxLramP8kHwU/Vs=
Subject: FAILED: patch "[PATCH] mmc: atmel-mci: Fix use-after-free in atmci_remove due to" failed to apply to 5.15-stable tree
To: xiaopei01@kylinos.cn,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 21 Aug 2026 16:10:03 +0200
Message-ID: <2026082103-dominoes-petal-0463@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x c125ee35a49a0518521b52b27631eef061b8719a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082103-dominoes-petal-0463@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c125ee35a49a0518521b52b27631eef061b8719a Mon Sep 17 00:00:00 2001
From: Pei Xiao <xiaopei01@kylinos.cn>
Date: Mon, 3 Aug 2026 17:48:21 +0800
Subject: [PATCH] mmc: atmel-mci: Fix use-after-free in atmci_remove due to
 race condition

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

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 3b4928f5b9b2..8f4df250a77a 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2610,6 +2610,8 @@ static void atmci_remove(struct platform_device *pdev)
 
 	free_irq(platform_get_irq(pdev, 0), host);
 
+	cancel_work_sync(&host->bh_work);
+
 	clk_disable_unprepare(host->mck);
 
 	pm_runtime_disable(dev);

