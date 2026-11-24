Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795544251;
	b=Ef0oGoWr/UOaZvn2kFjw66n0OVrkH6DMNXe0NPMSFLtZ7Z/cmOe/hYntHHoGVE7sJPYP
	 nv7TpDSjgJ/DkaODG/XewVMTL/i+ooowABJNd47cmgUPcuonoesLErd8q4Il/3T7SoqYY
	 bC+MDKhGbb7OHtxycdgfGXUVpYDmpzuZ4urIpAePM4ElpzZoqL5MiDQh4GAufsGbSPWvJ
	 HnaPxqSrg6XOt0PGXgkGmuOSnrp8ON0N/LI+iUlKgtB1B5T6yYfZmvvrybHod7A5EK2K8
	 PuGqmOkEmcgua/Kx5ixbNQA3zc7vrXOTurMi18fK8Oz0aPM/XL/uvrjE0paqcP7raxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544251;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BNEiY3ylin3Y/C06b+l/sYwKsdUC9X2WdP7GMgxRhwE=;
	b=rC9XVK9rvnTDfetaO6DLWk71hiXIggFMGeb0T1fPXmYp7mMrPaQLefijQUn9n079Xg+s
	 jNDGXm0TdjOLSE+GXRk8z+DqpoKAl3HoDz1/a06ealkAV7MED9UIQ0QRpuCtweVRWO5rP
	 IJM9XrmrQdi7YobdlazVeRzriOn3EPlEE8WnN5nGFAvGhbFNsqaovVMGPS60VAzyAErF2
	 hfwekkNxIxoXHzhCyK8Qj06sc5yffsCA96xgCqc+EW8HyvtXeoRlvtzZKWkSRLfMMss04
	 QB4nWnWKmrV+/G/UoOsA/POfNaIJE9GdxrEcMVkIeULRFflagIYod1hRuaxy0E5aToA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YkhNZDoi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C36F606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YkhNZDoi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54ED31F000C6;
	Tue, 24 Nov 2026 18:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795544250;
	bh=BNEiY3ylin3Y/C06b+l/sYwKsdUC9X2WdP7GMgxRhwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YkhNZDoi81YFAnbOpL1MCeKkNi8z0Px/XOLkG7YeRzrd0BAS2nyxy0tIvgEdd5/QE
	 a/u69H7U5CClpb2LLt/88MWz0/UdgqdnOfE7hGsaaqtFnNwoGwjea3loIilbeMhvai
	 OW7ZrBbTTu3nFZUIqKb5uDeVl+iZTLNXl4MQpSwJBBHCPwUlw32SZgdVEDfoDykqJT
	 8Wa8TwzbTDgc6POpYE/2cR+52fTj6IKWAxY+YG76A/GL8gP67+1uGiU9NcPX/Vp6fO
	 6DZiTwwQQgfASD6PuiSTsGXRkdM5oI+HAcMz2w/3maZRDThTft5QFnJb/LtY0RCDo1
	 Y1bFRmKCeeJ6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mmc: omap: synchronize clock timer before disabling fclk
Date: Tue, 24 Nov 2026 13:17:29 -0500
Message-ID: <20261124181654.2305018-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112429-handgun-idealist-1f47@gregkh>
References: <2026112429-handgun-idealist-1f47@gregkh>
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
[ sashal: Replaced timer_delete()/timer_delete_sync() calls with the older del_timer()/del_timer_sync() API names. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/omap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index ecf2a68d0e846..5871eb4afad65 100644
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

