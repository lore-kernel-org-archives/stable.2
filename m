Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC01833EB06
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787508169; cv=none; b=VnjFTKAQSCMEATyQF85PNCIFbwIxGcI0sSberNkwYDZ7nfAEGIAnxpemRLbxEkBbEGDVmFas9ChGiCU1Sdc2y6aaxwDdy5HoJR6tVe7zSNM762uEow4yMUHsARSg7/wJqADatLszU4IQfuU/vVHsA82m/8qYGPpxQsmaPLMp7k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787508169; c=relaxed/simple;
	bh=dOMwaohSHnAAtGC1ZW8t69cim3MhBUcAjVJ8j/OHqoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSXVdCQDaFDzCAFveS+d5FrVzMr0Sh3xyOF4Lu4EoKOb74TfDWYH7bMrOCD0skIbhHpUQYXKFpCNp0SnwXso9Kh4GoPcf+QylhjCQNI817r1ulR8FfKv0DihKlgCgjVkcYFniWGpI8JqFL0+LGYnmBogZDhyu2KTu3ceKJ6lOWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPLbzCKi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPLbzCKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AC71F000E9;
	Sun, 23 Aug 2026 18:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787508167;
	bh=Idzq+NXL9zwU8RqDpcW0WArOK5Ip7YJrVJU21jL3fRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lPLbzCKiCNEMdQWkRA01C4ZspVYnTwG579p7+FouEhamrOkZDTdVRQ4ZfZJdObKjT
	 Dh1f4NoyvwaM4feRJKQ2Z+JMjU14q3esoIeRqBLjoYwnrWR94dXKM/RMs3fCYPVDcf
	 HHfXImtdyUL143sCrZnJ22kpZR2SdQt0C7rMseUVzfNq69Y/Dz185X6LdM5X4REYE+
	 VFEtkBa4j5qtjLsqv7d4pkf/x4rdd2DGjkatuY1rWrYfiIjM1SCjC6/AbXZA029ltl
	 DRqvI2UYgNLaxWdV9U1MfujenipDxpi31jpgS+fV9hCQ7CV1eAQ36DduUV5awq0MuA
	 VzQdAkbuZogoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mmc: atmel-mci: Fix use-after-free in atmci_remove due to race condition
Date: Sun, 23 Aug 2026 14:02:44 -0400
Message-ID: <20260823180244.1406308-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082147-enable-juggling-0745@gregkh>
References: <2026082147-enable-juggling-0745@gregkh>
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
index 914c0e84b5cce..ae02c717c3a96 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2628,6 +2628,8 @@ static int atmci_remove(struct platform_device *pdev)
 
 	free_irq(platform_get_irq(pdev, 0), host);
 
+	cancel_work_sync(&host->bh_work);
+
 	clk_disable_unprepare(host->mck);
 
 	pm_runtime_disable(&pdev->dev);
-- 
2.53.0

