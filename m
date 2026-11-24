Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541094;
	b=38IlVBmprxtrGdEn4gWPnDMngCOVbm2gjY6p2y40AFnWgFagkSnJPBmqhSxn8oAtc2MA
	 MVsdwQ+fFM6P2utgzXpsZo+5J9keODIQQ0nd00rqscSEbqUjLcscN9mI+uLmJ1OH0fOp9
	 wq1M2HdZ94XUZJTc29ANQUJwVms8yQWTvZ2gkk4TAtQaURrpjn+UiV1s/B0JWA21n4+4O
	 M+BBnW/Ux65MPsnIhaV0wRgb0Wz8rOsVKxzzaYnTrnL593Dh8ThA7Fe2EJgvm6eFy91Jy
	 oRks9mYuKxHkS3v0AMxwyiKcJwhsPkB+ti3r4EONbjl/XMluTxXZWR9OiaN5xYIYDYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541094;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=d2IlFjgLlL/O2Ig7KglICCdIKyyxi9NbGgxCln75shQ=;
	b=euxFhq3KjBn7xijVJKWJCInJ+uMXdhKzYNxUkab89gMwuaC3sLsAIDmSGkvZNurZ08Kf
	 92lX2eirMBP+XQdkPbZJp//0PizMCKBHai+N+p4vXF0EsJqT0zyNz5VOwiQUj2XGI8qx9
	 dEZCHIfy3bK5I4uKXpUcRKmI4AKzgu5IOVANctwboUp/WkI6UxQ1LXnU0hmWwbgxypA91
	 CalEL1rPmLgi8P5vO8ChlUwnY50k9SHfuYemWdLoxo5lhd3UMpAE9byudlQhv9M+2nEMl
	 6XxjIv8xFfv2MuFXnd50YTQ/fnuTypTtlZCqBaiyCgl6wQ642ouXMUh1mphqbQgmJOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=URsUMq6x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A4606A331
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=URsUMq6x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977491F000C6;
	Tue, 24 Nov 2026 17:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795541094;
	bh=d2IlFjgLlL/O2Ig7KglICCdIKyyxi9NbGgxCln75shQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=URsUMq6xL23G3CKYrPA5gOkxxJBwpdv8EDhLpqNuefraHdXrlqmhPYfrZA+APX2ph
	 LzyZdf6cUjmr8EZLV570zE0//LjSLUR4wlOzAXM8FTsMV4Q6UmC4q/WTUpi17srAuN
	 I/h6qBFfWCv+2K+wJNhpxXYOUHABa+xbcoqXFtfaK31pkF2FNr9RU5ruU5AFmX0Z9F
	 y1a/rZe+0Q1E9kQvX/jpE3ocnot0pCuYZoj7U+F9+TCXyx6JMBYjROj/fGe9EILC8l
	 jCMHvC2hMcwsAGoOe5IBEU9KIDYpnZGzMolHRr3WD2GvxHN/HR/RgKHpm3Ux2O9FzP
	 kIJR7OXW+13Rw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mmc: omap: synchronize clock timer before disabling fclk
Date: Tue, 24 Nov 2026 12:24:52 -0500
Message-ID: <20261124172343.1984185-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112429-daintily-sanding-7cf9@gregkh>
References: <2026112429-daintily-sanding-7cf9@gregkh>
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
[ sashal: Adapted to the older timer API, using del_timer()/del_timer_sync() in place of timer_delete()/timer_delete_sync(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/omap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 0293a4dbe7e01..afe94b1e3266e 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -215,7 +215,7 @@ static void mmc_omap_select_slot(struct mmc_omap_slot *slot, int claimed)
 	host->mmc = slot->mmc;
 	spin_unlock_irqrestore(&host->slot_lock, flags);
 no_claim:
-	del_timer(&host->clk_timer);
+	del_timer_sync(&host->clk_timer);
 	if (host->current_slot != slot || !claimed)
 		mmc_omap_fclk_offdelay(host->current_slot);
 
@@ -274,7 +274,7 @@ static void mmc_omap_release_slot(struct mmc_omap_slot *slot, int clk_enabled)
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

