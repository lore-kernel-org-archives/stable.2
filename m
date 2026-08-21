Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A44490C00
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787322028; cv=none; b=Brlg6eQ3PWVP3PLDRpRUU7HdsN2xjqJrxdiAlVhWULBD9hdb9Q90wFqbwGEYNjuNACiWg93FiVtD2CHeJi8ppHT/D3v1rwiviTRzBGsw2WeYbivs55sDN3hNGqvS1BI5v+cazvTgWYXZXlqiHJcdhE0wNazJ2IAqWYwh8EaqksE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787322028; c=relaxed/simple;
	bh=7N+cB+eVLGM40S/TKm2/JEFRCS1qwpFMCijIuEKdGLg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ph1oT6fuPGe7Pir4D2qEXZbgpLU294WNheWfo5NN6qCOg7Kivt2tTrvCbxZDPf1HvgQxI5xGSgcjttNCsvwcX8csNc7kb8xJACqcZj6hBX3abwo6wWjCt93t6iVpBnVC4c9v/cTxsKFFx3hxC8894SuXMRcpcrPbycBn/lJtpsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kEW37nSm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kEW37nSm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FC61F000E9;
	Fri, 21 Aug 2026 14:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787322023;
	bh=TZ4ttv+Seejg+NrCrDQ3YAgXH04aEscuIQR36ilwRC0=;
	h=Subject:To:Cc:From:Date;
	b=kEW37nSmY06ecq/nVcCiw/oSY+QjasoR1aMv9vYNK3nQQ3G2MSCEZDAj9MyAVuVlo
	 NZ5sJnOGIG9uiijjhJP0qvP0VKT9DKS57LqoJr3vqLGJxFC94+UyVLdSMqaIdJKvXT
	 H7/LoigZl6kSEUInq0h0wK+paK2sJd73Aqb/r3Ic=
Subject: FAILED: patch "[PATCH] mmc: atmel-mci: Fix use-after-free in atmci_remove due to" failed to apply to 6.6-stable tree
To: xiaopei01@kylinos.cn,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 21 Aug 2026 16:10:43 +0200
Message-ID: <2026082143-ranting-roamer-c99d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x c125ee35a49a0518521b52b27631eef061b8719a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082143-ranting-roamer-c99d@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

