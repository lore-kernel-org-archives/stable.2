Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543033;
	b=YYvcJQq4tWdFSnHQs0gFgAA0O4c5TAjIIbcirFsUDfNi3KVasbjQXgM+00FJXZMvHY0v
	 ZGV6NdtsdESvIoL4ANZlINMfNgZevJ0qzyGJfu4vvyS4/mRHnS94GLRyr6hPJnQzkJnAH
	 30nH82/okV7uIy+wx937yvzYOqMPbgr+4SueROAxnVSt6Bf68dmmY9Ul+C+bYPwEFUJuO
	 jVlzyExjwR/2TdlWCixkkWlUoPCHo7IkIHu6syOYCTARwVrcB0g6nj0m+GlDe/u7amTc9
	 /0PkSlOsupTEwX91x8sWXjPqBpD7wJYX5FPMT5D0s7qsFrToRfnWDsZliXZFf+aWRTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543033;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vz7alcHmga0aMGzVKg2ElhQnwNXnlfwvdDBq9MZQLDI=;
	b=yBeAZ2srz7cjAq/dDOLm+g2pHVO4NDu+GQW/3xaup4VDsctkX37Mis3SADPuSE+sTqL4
	 5q2E6ln9Aj0WI9KSr+dHCbL86fYkfDR+cG6LPqD+1lX1bS+TdSdYWfONNpxwwUfkpuiw+
	 PR4dmEF3nBfDdAyj5htkuoWdnFCvGORhdUumkfBCg7g/CRIH/LNW3oCoH0R6Zvmo5b2zg
	 7t6bwrMSMPpgCsr31ca6Kbe4CzR9nEKKsHBY4j525U3AMlpW+3fumClicyBkyL/Y9T3h/
	 nhJMqZbp0DP1qWbHZdO5R9ZP5pODNpCz8Nn873NzVTnRLXJ6MbuLPm2Gu0Btm1hleug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1HA7aaG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FE7606A32C
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1HA7aaG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462B21F0089E;
	Tue, 24 Nov 2026 17:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795543032;
	bh=vz7alcHmga0aMGzVKg2ElhQnwNXnlfwvdDBq9MZQLDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h1HA7aaGbqEc1nm1w9wFVFrCOTsX9Kmy7VNRMX5vneH65VV3ZFbeZteW+sYZ56uVN
	 1l3DzbPLI1dx/0KOoozsHF+iRQwUO7GewRidF0QyvC6hgbXxx+ubqSZ1nGb4GtYqIX
	 5RPsGp4IS9UATUoNMngpd0lITJIfdI8EJ+2JqYPWA8fvR9ZyxOOxYYGHfXdxxAsW6j
	 bMfEkVNY2ASH0iBhitmxyYW0535LwA2dRfhlhv+ox51CO1Nwy79ErL6obSL1HJNHzF
	 3t5A8DbnE7kvN0AI5qNIByTKplfwgw1OC36EEciIlzxZ81YH9mbVskRk1BCu4aERCe
	 UJsupgZHW1lNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mmc: omap: synchronize clock timer before disabling fclk
Date: Tue, 24 Nov 2026 12:57:10 -0500
Message-ID: <20261124175620.2158079-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112429-laziness-outgoing-f869@gregkh>
References: <2026112429-laziness-outgoing-f869@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit c931c51681e33b24bc8d65c6df35b70e1827daa2 ]

mmc_omap_select_slot() removes clk_timer with timer_delete() before
switching slots and changing the functional clock state.  timer_delete()
only removes a pending timer and does not wait for a callback that is
already running.

If mmc_omap_clk_timer() is already running, it can therefore call
mmc_omap_fclk_enable() while the request or slot-switch path changes the
same clock state.  During host removal, the same window can overlap the
final clock shutdown.

Use timer_delete_sync() so the callback has completed before slot switching
or changing the functional clock state.  Keep the timer restartable for
normal request handling.

Fixes: 0807a9b5739a ("MMC: OMAP: Lazy clock shutdown")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
[ sashal: changed timer_delete()/timer_delete_sync() calls to the older del_timer()/del_timer_sync() API in mmc_omap_select_slot() and mmc_omap_release_slot() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/omap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index cc2213ea324f1..6386d6a8cb87d 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -210,7 +210,7 @@ static void mmc_omap_select_slot(struct mmc_omap_slot *slot, int claimed)
 	host->mmc = slot->mmc;
 	spin_unlock_irqrestore(&host->slot_lock, flags);
 no_claim:
-	del_timer(&host->clk_timer);
+	del_timer_sync(&host->clk_timer);
 	if (host->current_slot != slot || !claimed)
 		mmc_omap_fclk_offdelay(host->current_slot);
 
@@ -264,7 +264,7 @@ static void mmc_omap_release_slot(struct mmc_omap_slot *slot, int clk_enabled)
 		/* Keeps clock running for at least 8 cycles on valid freq */
 		mod_timer(&host->clk_timer, jiffies  + HZ/10);
 	else {
-		del_timer(&host->clk_timer);
+		del_timer_sync(&host->clk_timer);
 		mmc_omap_fclk_offdelay(slot);
 		mmc_omap_fclk_enable(host, 0);
 	}
-- 
2.53.0

