Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D7E48F02F
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102451; cv=none; b=PWDXJSFO6kX3SM93CraSS2Wmw1/KGnlEkdGn9yLHxh1NHo51qb6EWbks10+tUI3cUqqdX8HHRscVIcyFlUnasZRTOIWQe6p1fxrPwl56suSYIpoOFz88SxvziCuYk58YUggqnQGqxsbdjUJRx3P5xbjF76aRSgdnhjiyWByoP+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102451; c=relaxed/simple;
	bh=cKt8VswxBxfYlu6pNq+iqQhxhtHwKEfC46NIFIwrhmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wb9zCwQZv/jXWw+s6pJHHvnYNSksF0xYPQZa5H+hnyjoA7eZ4iSz77LIc3Z753mLQbupDAPJJ5qSuu4B1zRbAQE19pmm81Il8lccUrnNzNsovyZEa05u8zKAgKeVgglkhY/pMfiKRegiXwGy3bplFJ1HDbXg5kE8ONZqRbeNyHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T94jVAhU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T94jVAhU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC681F00898;
	Tue, 22 Sep 2026 18:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790102449;
	bh=beBfvZjipTC+6sZaM3ukWFGtmgxLCucMdKK7nhfZw5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T94jVAhUpBDYSUZzJ7T0G7di5O/PQ1LthGEYRFJXVGbwQTkNPniR1VpZdAiuHpMjP
	 xeZUNacwB2jQcE1yn+Vep5IhYe9TXiqAZ05AuBRuPvxeFrq9Zvf7JRrwF2LfV2ROr1
	 bz21Q/J2iC1EeqEeFED3bbheefbUMcoa1AYC33oLLwB7J5hW+W6uz/jIFVYJLvhaQO
	 g6OwB0Qkvyfx6AA87B/g1ILgN174hNuX+7V103Z3lGVOOVHkKiMxTBxPcGX3lF3N9z
	 HlVwo2sx/H4Jfj7XvUqWZkdKmgji2J3NTyLPhiUvr+xQpHF3tTZuHEXcOABFi+uj8z
	 kvZII2vQ0bIcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] wifi: wcn36xx: Fix potential use-after-free in TX ack timer teardown
Date: Tue, 22 Sep 2026 14:40:47 -0400
Message-ID: <20260922184047.3744251-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092257-dyslexic-stinging-ab11@gregkh>
References: <2026092257-dyslexic-stinging-ab11@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit d9be5e75530772fc31637070d51e5717d6aeaa2a ]

wcn36xx_dxe_deinit() tears down the TX ack timer with timer_delete(),
which only dequeues the timer and does not wait for a callback that is
already executing; the preceding free_irq() calls synchronize the
interrupt handlers only. The callback, wcn36xx_dxe_tx_timer(), can
therefore be running past the teardown and use the wcn freed along
with the ieee80211_hw in wcn36xx_remove(): it takes wcn->dxe_lock,
reads wcn->tx_ack_skb and passes wcn->hw to
ieee80211_tx_status_irqsafe().

Fix this by using timer_shutdown_sync(), which waits for a running
callback and also prevents the timer from being rearmed again. The
timer is set up again by wcn36xx_dxe_init() on the next start, so the
start/stop cycle is unaffected.

This issue was found by an in-house static analysis tool.

Fixes: fdf21cc37149 ("wcn36xx: Add TX ack support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Link: https://patch.msgid.link/20260910020907.3353-1-fanwu01@zju.edu.cn
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
[ Adapted the patch to replace del_timer() instead of timer_delete(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/wcn36xx/dxe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index 9013f056eecb4..02e66839ab3ac 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -1055,7 +1055,7 @@ void wcn36xx_dxe_deinit(struct wcn36xx *wcn)
 
 	free_irq(wcn->tx_irq, wcn);
 	free_irq(wcn->rx_irq, wcn);
-	del_timer(&wcn->tx_ack_timer);
+	timer_shutdown_sync(&wcn->tx_ack_timer);
 
 	if (wcn->tx_ack_skb) {
 		ieee80211_tx_status_irqsafe(wcn->hw, wcn->tx_ack_skb);
-- 
2.53.0

