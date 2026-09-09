Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E50658E2AE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963523; cv=none; b=RX8HEHlQtoXG05N6amFWj5vUdx1geRhZ25rghpJcd1zqDV7m+aC8ArYCg+y87fROZn4hP4CbgEbff08+zrsw4edvcWhEbDXxBUFHubC6A0BWEpssUq4QpL6AkCNOrtc0Z+0ZOw8FNnn91XC0FjRez1MGwKeB9XnAqBcB+l/1Wxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963523; c=relaxed/simple;
	bh=VmvwiFSfBkcjbCA/Tt4eu7VAkimEo3fx/G38I5iQmmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6AyZEuopC9r6iTXi6iHDOHfTGC84HMCtsMBLiIlqL/LaB8BkQIc3/gSpqcI0DpyWzY0Igu3ZDbT33o9nV3kBhpSEqGPnz23Igas4tGC/AvqFll+irZ6CLZ78WsFFAo4XdgU/esie7IZQR6AWTdkU1OzCBn9kdFfrlSmb/lldZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJ9qN9Xu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJ9qN9Xu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54551F00A3D;
	Wed,  9 Sep 2026 14:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963521;
	bh=W2gZtNGLmg/jVsOoZ2RGwLH5d7avrz59X5NW0DNtaFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fJ9qN9XuSyZs3w4tQhWUrDuj3DoKcp2zZh57eEPFe0uPKSIWEjf+goA/F8Msimr9N
	 Xdd3q8y0jg4T5/qiNL+HG/xo2VjgUctWkwpz674rJiFw6aTOLVMwYN1X+1Ps3Tnx1a
	 c7V3E3hEOmwndvDXps2Qg6REjeHKnO5Z0Oo4X2Hf+qR31ladDhVNlJ7bFe9pt9l3kZ
	 fB2efPPd1OYy2Yx8VFr9QUZ+K5H4MHNClSpgbYCzVTLKwijGbYwY4392ZGzoWXVt6G
	 ZpU/5CvcHqzhMk8FeudgX69GQoIF09IdHO3Jq1Ri62wFFli1Dcuvjl/T0ZWDumVuov
	 A69yXqS/oMdqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mmc: via-sdmmc: cancel card-detect work on remove
Date: Wed,  9 Sep 2026 10:18:39 -0400
Message-ID: <20260909141839.2421623-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090308-drainage-dandruff-6985@gregkh>
References: <2026090308-drainage-dandruff-6985@gregkh>
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
index ba6044b16e07a..cef9f42c26d4d 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1201,6 +1201,10 @@ static void via_sd_remove(struct pci_dev *pcidev)
 
 	free_irq(pcidev->irq, sdhost);
 
+	cancel_work_sync(&sdhost->carddet_work);
+	/* carddet_work may re-enable the interrupt via via_reset_pcictrl(). */
+	writeb(0x0, sdhost->pcictrl_mmiobase + VIA_CRDR_PCIINTCTRL);
+
 	del_timer_sync(&sdhost->timer);
 
 	tasklet_kill(&sdhost->finish_tasklet);
-- 
2.53.0

