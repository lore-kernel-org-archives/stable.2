Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D3658FD17
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963983; cv=none; b=j9SHKyhsP+JASRkFBHV/wOtQ9WTAxZlbOmnnfk9jujeYWo9RP5UscgwGS/VlqxeaQhGfO8fiGLopV1egHzSWGfJRXo1Hv/bsvoKMxD0A2xDdHySaPGiO7ZqFyr2RTe9rEAbcMzdIWlwJoWVSUxlX3rDlbT495XRUctPoyZAB5Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963983; c=relaxed/simple;
	bh=rDiZzPzTEi+xvNL2lF0+Ihxha7ksMe3Aseuv9jedk0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFVrRNHB3tOCuo3oyOoil5WhjIly6E9/FGNoCuz6iTV7iC8/j5qouctCCnHHNK4WVxqqf+qqkrdX6IG9WS7VowPO/vQGt+muLtpYVGhfY1Xdo91Y86VyN1LJbaM+H96RcWsdQkdZ4vQlvODbyim3vRNjvqPaKgditP28wMdxiTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3Mb6WfT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3Mb6WfT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2E91F00A3A;
	Wed,  9 Sep 2026 14:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963981;
	bh=9490pqy/JORTzRT/A8HCaw0GfM9kN2hfTIKY5AcmZQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J3Mb6WfTN92DifTlSra9HBwcOuzZUSKhdslV7aAAXbo/7L7+7u/jtvLW+I3Ck3kpn
	 YUw5o+RwGOo6VnTqzBPTDuukAe/VyGC/4v43uqNFKEDf/cIlj7b07GHGvMgZ9J1o/c
	 H0bQLNIw/r81xWDmX3nQHYb5Al0JASsQFLrAxPBv8v1ma3dE4l89ELOsscen6PnXWV
	 D5lVHh31rxzNDwzb9NgdbOTQtWkvVZCnEaau0E4uXVY3bcYhZzFQye2j7xwzAmoRAP
	 3cHBdsxXu7e24BsjbFmIK9YezNvuN/v7rBfmQICcrndNWgiCOjDTndtTn5f6GJ0yAB
	 sD8fI0HOMMr7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mmc: via-sdmmc: cancel card-detect work on remove
Date: Wed,  9 Sep 2026 10:26:19 -0400
Message-ID: <20260909142619.2468186-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090308-pants-heritage-91be@gregkh>
References: <2026090308-pants-heritage-91be@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit 57e5d877f898d5e5c9d672a77bb6bdd24f0d9bf5 ]

Disabling the device interrupt and freeing the IRQ prevents new card-detect
work from being queued, but carddet_work already queued by the handler can
still run after via_sd_remove() returns. via_sdc_card_detect() recovers the
host through container_of() and dereferences its MMIO base; once remove()
returns the host can be freed, so that work would touch freed memory.

Cancel carddet_work after freeing the IRQ and before cancelling
finish_bh_work, which the card-detect handler can also queue. carddet_work
can re-enable the interrupt through via_reset_pcictrl(); mask it again
afterwards.

This issue was found by an in-house static analysis tool and confirmed by
manual code review.

Fixes: f0bf7f61b840 ("mmc: Add new via-sdmmc host controller driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
[ adjusted context to retain del_timer_sync() instead of timer_delete_sync(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/via-sdmmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index a2b0d9461665b..2e367e8d8411c 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1202,6 +1202,10 @@ static void via_sd_remove(struct pci_dev *pcidev)
 
 	free_irq(pcidev->irq, sdhost);
 
+	cancel_work_sync(&sdhost->carddet_work);
+	/* carddet_work may re-enable the interrupt via via_reset_pcictrl(). */
+	writeb(0x0, sdhost->pcictrl_mmiobase + VIA_CRDR_PCIINTCTRL);
+
 	del_timer_sync(&sdhost->timer);
 
 	tasklet_kill(&sdhost->finish_tasklet);
-- 
2.53.0

