Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461484;
	b=WqUMY5nZUWte7vO4vOfq34lcwXrGuT2mNw0sVzvYr3e7Fz/+O/IbxzXt10J0EQy2yML4
	 EmcdCyIdVOLJE/PZAU8Cjyy1c8fIyZbdt4o/g1ij7v2Y0NfJInyIpguTgxqfxiPMA7Xnv
	 D6I7x2aYErarIk2b1b5W4K4fupGkc+qNVutTS9ZGmFLkFKN5YV++Ml13tDTr7ViNCWB1f
	 vDIg3Di3NH+xA2MdwRtB53eP1zJX9rns61GiDLnu3tgGpe6+nlFr50j7vXqe5uElYFz1w
	 5Ryb/Qp/ZAi0NFEvobUrBcC/KyFLnDdEKrH3HDLyx3txqK9DQPeM4aIo7tM0UawY7xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461484;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=aBzMS+ka1Rq8hvj4d1OdFgsS5C7iWSpuf0TYXqoFseE=;
	b=YzW4qwA/3lI2oIRvXeswsjiv7IC62iHQmJRmQqYFPHuXiQ8neH/MPvE1V2zZhckdxzN0
	 nVn2M2bqGLWNnjVvjnMhxXU+zPZeqYh34qFFDujn7K6e+IrWoeL8JV7vVemA6npO9LorU
	 0MoF17YkDG3oDrsPKWVvF3T/BCpADW66i+ompQ6Tm8wHk8ZeZ5UIlXql0pFjtxC8D/Cvb
	 6k3qDg+bI0g3Tg5KiWrI06SbUo2ZKvQHq+BG3oS13ifeWNLomwblGzdJYTa3C8iW4fWiJ
	 ZMhpxc2DQrelvtjvmBrvgg4HCmPb40VS9ziWSM/wYC16pgRifrR2sZm1KOPqkO3y9Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dEx5oerY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BEA606A31A;
	Mon, 23 Nov 2026 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dEx5oerY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3F11F000C0;
	Mon, 23 Nov 2026 19:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461484;
	bh=aBzMS+ka1Rq8hvj4d1OdFgsS5C7iWSpuf0TYXqoFseE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dEx5oerYnkgvth4XaUxvHfJCr+yBhfWrtAQl+6s1TLfLiBGyJvkQfmy5WBsmjxKPP
	 mPuk3rKlmNYTw3+gqb41G4h9FeQH3fMKk+bPfnQduWwlNwnQcQZ2pNXL/TbXvDakpM
	 OlcpkNBxWM1QOnuIPtaNoIyWcVBbcDBk14b2XhKIfIpyU4FAuAtJrGUog9I+buOk8r
	 jerMq54zREA+RU0TixiYnQ5AnKC/S1p+xTAkQ7a9w3P0k4wTsnb7Qv+7qm2V+XbAJe
	 8KnImr9WaNbq4hhibBvUDKhm5ejcqjLfUPPzWe2XUZOaYwR9AI5fcL8EenAePLmJyx
	 S88xI0lxr9CgQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 06/13] mmc: renesas_sdhi: Guard host->cmd access in internal DMAC issue work
Date: Mon, 23 Nov 2026 19:15:50 +0000
Message-ID: <20261123191703.179283-7-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123191703.179283-1-lee@kernel.org>
References: <20261123191703.179283-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

renesas_sdhi_internal_dmac_issue_work_fn() unmasks TMIO_STAT_DATAEND and
dereferences host->cmd without holding host->lock or checking that
host->cmd is still non-NULL.  If tmio_mmc_reset_work() times out and
clears host->cmd under host->lock after tmio_mmc_cmd_irq() queues
host->dma_issue, or if unmasking TMIO_STAT_DATAEND allows a concurrent
data-end error completion to clear host->cmd via
tmio_mmc_finish_request(), evaluating host->cmd->error triggers a NULL
pointer dereference.  Unmasking TMIO_STAT_DATAEND outside host->lock
also races with concurrent updates to host->sdcard_irq_mask.

Acquire host->lock across renesas_sdhi_internal_dmac_issue_work_fn() and
bail out if host->cmd has already been cleared, matching the sibling
system DMAC implementation.

Fixes: c330601c9c93 ("mmc: renesas_sdhi: take DMA end interrupts into account")
Closes: https://sashiko.dev/#/bug/linux-57271e16-2f7e-4151-a686-57ab2474fe6f
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 0c3967f758c2..6831fc34cd22 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -450,6 +450,13 @@ static void renesas_sdhi_internal_dmac_issue_work_fn(struct work_struct *work)
 {
 	struct tmio_mmc_host *host = from_work(host, work, dma_issue);
 	struct renesas_sdhi *priv = host_to_priv(host);
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	if (!host->cmd) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		return;
+	}
 
 	tmio_mmc_enable_mmc_irqs(host, TMIO_STAT_DATAEND);
 
@@ -462,6 +469,7 @@ static void renesas_sdhi_internal_dmac_issue_work_fn(struct work_struct *work)
 		if (test_bit(SDHI_DMA_END_FLAG_ACCESS, &priv->dma_priv.end_flags))
 			queue_work(system_bh_wq, &priv->dma_priv.dma_complete);
 	}
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static bool renesas_sdhi_internal_dmac_complete(struct tmio_mmc_host *host)
-- 
2.56.1.750.gf70dc682cf-goog

