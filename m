Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF963290D1
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787495303; cv=none; b=RZf0N3y8UBQ2OtkAmBGKejd/QmOhjL0HCcxWP6KsDHZrHW5pmP9LlnW6pTBgb7rJ+rGpaVzHfVKAbhxoXyS5hQfjqi2SCI1WreQokBMVo0FG3yJpHPEG3CQAb+GA3HyYRds9tsIXBGNGyZvgKOmQCA+xC2KX6CbLD2caknA8fvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787495303; c=relaxed/simple;
	bh=sQK7a0EkywNDUUA/8AIGkL39kG5mjKH3o5ND0hmDFG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tr+EejxX4eyX1xaY/0xmouPjWm0eqs99Hbe8j/CFQaI/Uog/NX4m5UOo21nKaCMmUrBK6nfFr0c+MLL0Xjz1HJwBxSHhXEp0OqcvFad9aKf2vPpSKovxMufN/k8FGeTsh0r59ezMsAYwHxN7sgOATuxXrA9ROBVb38FlpCRrgDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vx2lq+fG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vx2lq+fG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34771F000E9;
	Sun, 23 Aug 2026 14:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787495302;
	bh=w4A9tCT7/mdwqUweApY5JgOYG/yxcnO/0OKP1BZZndo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vx2lq+fGINFUOTwZuOcB0UkgFaA2v57mQNCf5wkjDQI5LfDpCUp8oOOwg10yICwwv
	 fxAzR/rUBMjKW5asmzZJaja85h5SO0ZbNjlanZfQxEv1G5Z6cHUqmOzAAdBrrzG0Hy
	 6XZbnSKRcfYRgJIvp2Ar2hleBaSvevuoku/WLnwzAWWOsQ/2RgmH6lpnDUkXyIxRJk
	 tLmEXfnUBkd0sLgMb3kKa37fgxmtqvzzO/KMW3063HAui+zF/SyCKs/orJksS4sphj
	 Cvuj2Go99db8QQJqY8u8hnM4Czj2XUNCHWAl5Nk2MWXUiu704Mx/uLt5LnYHv66qGr
	 cQxM3fsTmvpMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mmc: atmel-mci: Fix use-after-free in atmci_remove due to race condition
Date: Sun, 23 Aug 2026 10:28:20 -0400
Message-ID: <20260823142820.2437217-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082143-ranting-roamer-c99d@gregkh>
References: <2026082143-ranting-roamer-c99d@gregkh>
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
index 45cda1248816c..8953244a4aea6 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2658,6 +2658,8 @@ static void atmci_remove(struct platform_device *pdev)
 
 	free_irq(platform_get_irq(pdev, 0), host);
 
+	cancel_work_sync(&host->bh_work);
+
 	clk_disable_unprepare(host->mck);
 
 	pm_runtime_disable(&pdev->dev);
-- 
2.53.0

