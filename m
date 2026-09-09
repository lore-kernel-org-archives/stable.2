Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF6D58FD26
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964460; cv=none; b=Ze3GYfljkYrdQItht6JJKKDxPIWzX4w+/sXMUQzCnZmfBkBwBxDBYxD7Fdkg50nqIS8/67mEobuLHZfQolSxnFDTe75DdBeDcPTN2H4YlvLEngmNxbvW9cOkH/dZdoUUnqQEKC5qT46V5VRgWkOTVaHYb8aUz6h0f7Mudbcocjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964460; c=relaxed/simple;
	bh=aRUsT3b+1e8Es2P98l11DBdDCDro9vxTnvEsZRV+hzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7yHLMY86h2vsC54aATLMgz8bv/vmd1ZBtZLpIR0iXeoQBAnmwQgK7FESUejAkOS8RU0fmxx2++B5KIs31vHRjpkZw0zklyl/x17G76xvLg73oP8CcX/ivRylVVC6TtTGzuRI3P12xWG6XXsNULsA+A4fvRKRdtd5ecaqt94EsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQmQI/7m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQmQI/7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89441F00A3E;
	Wed,  9 Sep 2026 14:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788964458;
	bh=Y2Yc0pfZKYvfQWDm9kg246nevpfMBgYLgoRaxQDuEfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mQmQI/7mF+y6sVihFK+2DJwZAOjb6ZS1g3jwhSk0xn4cRIwOBqY/vGYabN+RIX2iE
	 FaPzsI5V9YnDej3m6G8T/Czu0EGHN032I4CBsNC5tHtPQcq3r3PoIqtPvyw9aKGE5Y
	 K4ekB57CodYo81nY9uKgqi0jDpldWts2uIzQ3jSFo0knoCAzXyhuwDf4c1GqUMQCXV
	 R9ZYUIq4nHs5xgHKwsivOo74EButZf1Gk1dj50feufwIWsoeNVPy6kO/bIRn040SsP
	 GoEYyFGutRPKU714e4E0GiG2ofkm7mIUa8gWGBPz1mTt1jLAtyn09tpNQ8JiWML1Tf
	 dhUhEJTazHP1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mmc: via-sdmmc: cancel card-detect work on remove
Date: Wed,  9 Sep 2026 10:34:16 -0400
Message-ID: <20260909143416.2509945-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090309-gerbil-rickety-e7f6@gregkh>
References: <2026090309-gerbil-rickety-e7f6@gregkh>
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
index f6b525fb5c0ed..b75bd01422038 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1205,6 +1205,10 @@ static void via_sd_remove(struct pci_dev *pcidev)
 
 	free_irq(pcidev->irq, sdhost);
 
+	cancel_work_sync(&sdhost->carddet_work);
+	/* carddet_work may re-enable the interrupt via via_reset_pcictrl(). */
+	writeb(0x0, sdhost->pcictrl_mmiobase + VIA_CRDR_PCIINTCTRL);
+
 	del_timer_sync(&sdhost->timer);
 
 	tasklet_kill(&sdhost->finish_tasklet);
-- 
2.53.0

