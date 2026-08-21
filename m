Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D956448CD67
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787322024; cv=none; b=sxyRI6I8juQifUf7EFz6ZKYLUtHAkvAVIPAhUgZcGH2Wby8kTkHSIAVYt1maRHT2XAGYyS/aBsg+RVcgl/sjtWg1U0/t4Cp1MPgeReVc2PwPk04y1bvHFQR4twzqIUTkwSSAbXlXnsfygnO5yD0ZVNEvT3TdOJROYidFjIPMyIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787322024; c=relaxed/simple;
	bh=Zx+i80+smu3ykuxOUQSpwdF+EME412neSJFKwTTHQV0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i2vsv6nvAMGk19YCkQ9vYePUTE+uvIXHkvlhnLIcxNe+OboXKQZhU9SFK/q+Yqo7B7rMURe7hOXU2Z8T18G32SoV/qS9QIvoMMPEgFVNjNWhJXOQ5S7hzc/ZV9LCHQxRf+adV2xP3d7Vi843wR44a7ivC4Im4htGp5vN0LpRHtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=efRp+TfM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="efRp+TfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC9F1F00A3A;
	Fri, 21 Aug 2026 14:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787322020;
	bh=QAMpFCiZvuxMIGlhmPU3HSdcFuql/khaVZGks/0s6c8=;
	h=Subject:To:Cc:From:Date;
	b=efRp+TfMoqzFvBwtLL5LE/InOA9iioSyxO83nBS+8Nw3zGVPvIu9JxdEmw+NNwp69
	 Rs5o0GT4qnuaykrL3hP8Vwj5horHfwn5V2lQ6JI5Alufm7hEd85IjJunJaZQp5Vj8X
	 X/Y0qNv58jYQqFxe51LlGXl3jPK+jGKAz09K7MbI=
Subject: FAILED: patch "[PATCH] mmc: atmel-mci: Fix use-after-free in atmci_remove due to" failed to apply to 5.10-stable tree
To: xiaopei01@kylinos.cn,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 21 Aug 2026 16:10:19 +0200
Message-ID: <2026082118-populace-yelling-480d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c125ee35a49a0518521b52b27631eef061b8719a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082118-populace-yelling-480d@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

