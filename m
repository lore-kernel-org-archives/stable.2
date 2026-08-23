Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61481891A9
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787508581; cv=none; b=dILRoo6BcTQjhLGGlBjGOajTdy92XVtpOPFi3/KIphYtnOSBn6n9dj2GAOdsBykXazD0kYhzI6E4m/E/b7Rf3N+qPLBDbXaHesX1l2hzmEg22cRKmWqcgCQPy1DHSaU+dbYXUSG1xj+6b4ihzA6aZSKCBJt5CAwS+TsoPw7I2TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787508581; c=relaxed/simple;
	bh=g9wj4safJA+Fx5vbejfX0CMLjrJpb/ufGXhgL1mQEnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qfk+8KUeyqi/xTFRldidkTpLzOXsN6VQGujIMYhpKHp6MO8AY7epSP1BsGBLN6+b5k1oEpICIZhLqTbLgHF4yf8GDlhDQm+j4R6pEdnKSPDBGHhwWiDM8bKjo/za5ujD+QFKDZmU/jaQYFn7bvBTw5xT+MDBCHwAPgNAsmoaaYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yw32pteu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yw32pteu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29751F000E9;
	Sun, 23 Aug 2026 18:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787508580;
	bh=oH4saoQByDvZPdK7qpERHtjVAKRaOYEi9DYOBzBJBAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yw32pteuSU0KAcYbLgX3Csf8DdcrSv0EOJ2niOmDwLNbYKChS38qP5OEmCH3Pa9qe
	 mO1KmJqy0u921PBjurxycWZi20mDOaWIxDiuqmABjR3cHc2dNzWOenjL9MVR6lSEni
	 jAJfC4VPpYsfdheAtjeRIjU2n/8ghB/ZsO1ptZUJfV0kkFvJBakB4wiMYXkngEvaB4
	 Y4TWdiKr0IMXoBQ0qZA9ZUsoo7ocSrfGlJjJVkIGiIdVl/sGAj2zIdFGGwbeYlhirY
	 aRcDE0wzNZcZA5o8u8rW63FcrpM6+tf+YmPc5y00pg0pgQRs1NreKtHeUBgH4/lWo1
	 JXD6ht7wA3u4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mmc: atmel-mci: Fix use-after-free in atmci_remove due to race condition
Date: Sun, 23 Aug 2026 14:09:38 -0400
Message-ID: <20260823180938.1462390-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082103-dominoes-petal-0463@gregkh>
References: <2026082103-dominoes-petal-0463@gregkh>
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
index 7c9eddf08f7b9..0c7ab605f6412 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2629,6 +2629,8 @@ static int atmci_remove(struct platform_device *pdev)
 
 	free_irq(platform_get_irq(pdev, 0), host);
 
+	cancel_work_sync(&host->bh_work);
+
 	clk_disable_unprepare(host->mck);
 
 	pm_runtime_disable(&pdev->dev);
-- 
2.53.0

