Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545264;
	b=k5wPNvGEM2GngLhfLMDljWL6DtsqR4xTncyF1iAE4zCy9T2pnr40R0suhoP+IkJFertO
	 ZXIec/SaBAjnVMb5rBehew+1WiS7n9VwBJ1ZWDrS8agmiGlWQMmDJmibeq/vPjCyI4Q6h
	 4t4gXxIYxFr5dbZ3aRyTx7HkcgL4HFOErq/+dXAbfOVHTV9pXYZXd/lkYl2kfxpzE5uuG
	 ZD6Y1XfX8BtN66HePwQn8kZ4vqI06gemF2EBP5aKgo3vubCqzKqB11fw+YXQPDNbFjvFU
	 kljjYc47Jw/XTHqXImVNe4mqesHyHaCg/S80cHRuIDYojZmBA6A6QiIYBlJnR1o/Zsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545264;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=m1Szfjj2lZcypR8/1BGxa1fLvfYY4fpFjcYSWpTayI8=;
	b=Co2TJo2tcyWTofEOVnRNVz2ab26VEldp+PfPXpcbFg1sT/6rYb77oAb7l5IoH/HA4lkM
	 a5TuRlQ5ywGaxhKmOSEHuf5nAVu5N7gsEitn89YjRISxFyz/7LP9OT0tAAdMrdoDSwYK9
	 kg/2TqqAOF6td21JSZjJnHIMSMif45WMPc6FbnA28F/xNVXti/lUjS45IqvFnYuqcU95h
	 CQogCiYhqNWWzBiLUGHfi4CSuh3AR5e9bVm6TaJLoO+k3kG5Bc5nSbKbNt/2zMNmVwHkj
	 YkXDyZpymZ52XA6/lw7+7Vu6u9e4MtQtR4t8JSVZy4siD7gUElnGxpon2av4yMSLCWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JcKPozEv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD974606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JcKPozEv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10901F000CA;
	Tue, 24 Nov 2026 18:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795545264;
	bh=m1Szfjj2lZcypR8/1BGxa1fLvfYY4fpFjcYSWpTayI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JcKPozEvlMONY0NYL71kyqWmGQce0u0YL8XKLlMcfzhhJz67UggpJ4qfU+vIi0Wu3
	 JdUZuu20h0tgMOh2BzbLg709dRaO9mHAR5F/u/4+dz8GTx5n071+dGYFn6GPPugM1r
	 hwEpUdCC0UpLk68XL6DqqCBASn5vZN0rHt4kT79oPI8xjrJ7USGQaKME8Bah99Ci7s
	 3aAETSRWGsN21EG2onj/20UZKxph42t8JghvzhiDshgKklTAIPXKK33hpCiDsS6a/e
	 IRM4jTlln+qk69OX6aV4fw5b//Wh2H715gH445yFdN2iKRzejsJdWoQ6y23yX267sj
	 Jzh7qM16VgDuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mmc: omap: synchronize clock timer before disabling fclk
Date: Tue, 24 Nov 2026 13:34:21 -0500
Message-ID: <20261124183241.2371892-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112430-lemon-ranging-6009@gregkh>
References: <2026112430-lemon-ranging-6009@gregkh>
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
[ sashal: Adapted to the older timer API: del_timer()/del_timer_sync() are used in place of timer_delete()/timer_delete_sync(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/omap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index eb978b75d8e78..230253751b0ad 100644
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

