Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC471530DE5
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963282; cv=none; b=MaaSKKceTnf9x6xWDs5o/xVC5gbdXbeShVLwxxHwds7bpKklPr2JOhgrQlwFDbYkAIa8QHBS8l1uikD3APSvTPhjkizFtHMnK3j6c5oFwuyLRq+zfxVgey33kN3/9Y8GwI1EwogJkYV/2F1r+Rkpz/oKVpoL5fE3tQz5EIyLNQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963282; c=relaxed/simple;
	bh=g4MhVxw3pDl9D7N4Sz5287BTs1otJklNetJsKvK1PV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gH6fhFJFzsXBCm578IYYhp8xavN5h2Z/wXeX3K3I0mbXGtoeBBTN6PDttI7iHqBhn18/He5LhbFII01b9Bw3/rgSOmQzbjMaRSr6dpJbSz6QX7Mio3BVURivuPdb1Y+xlxZ/urLarW+JUe/s/Bueuk8WzHOh59ct4dRxZu/NzHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esnjcpWY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esnjcpWY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180601F00A3A;
	Wed,  9 Sep 2026 14:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963281;
	bh=g7COKPLzM8HhL9Bbx9XqRaUVVO1hG5GtTNV2VGqIi1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=esnjcpWYi7m5dZ+P4ArJGTaBHKtURuotdRshQAqeHerjvtW1qqAEat3nZ/jm2VWDa
	 CLy8Ysi4sRjBiwkduTXia3sQa06rCVnW9cLMVdiSG2bjAKupOdyZym/dr0Z7+0c0C9
	 FsIlF4/292wmU/Uoqytge8thHOar7MWesTvNd9jkdOmJ2Ez5ZBFKV4VgqeO89H7ZWf
	 aaoNMdZSXH0Cd91eARlzkS7SzXiiE2Lr6pSWARr/Bivh4YlbtRw3PEunV7kihtl2sL
	 NDurx7B406oFFabnK9E/cKYBpUN9ZjbnPezM+cgF5Z2Z45n01Ml4DSfjW8NV2e0Fp0
	 m4mxOOXOATsUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mmc: via-sdmmc: cancel card-detect work on remove
Date: Wed,  9 Sep 2026 10:14:39 -0400
Message-ID: <20260909141439.2391707-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090307-unvented-prologue-a046@gregkh>
References: <2026090307-unvented-prologue-a046@gregkh>
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
index db1feeff0faf7..5f7f2e087397a 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1208,6 +1208,10 @@ static void via_sd_remove(struct pci_dev *pcidev)
 
 	free_irq(pcidev->irq, sdhost);
 
+	cancel_work_sync(&sdhost->carddet_work);
+	/* carddet_work may re-enable the interrupt via via_reset_pcictrl(). */
+	writeb(0x0, sdhost->pcictrl_mmiobase + VIA_CRDR_PCIINTCTRL);
+
 	del_timer_sync(&sdhost->timer);
 
 	cancel_work_sync(&sdhost->finish_bh_work);
-- 
2.53.0

