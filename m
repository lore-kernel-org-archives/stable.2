Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF2047F2FA
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790103077; cv=none; b=uzLEK5l2H5uxDltZANAjEBVhuMKOtFm5iXScQQ+zXO19g7Jnf93UzSaESrTWDPjsa2NOab68S6aOMftzWdUZHOWSy3TjR0oz8BeffjC1l84+eJH4gBxBwOPhTCumHGczCkYaKzVMjB1Klr9njVvdLtTnmGqeASiuD/DpBUIURD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790103077; c=relaxed/simple;
	bh=rZSABKGKRQY+ttCNpmJ5xu7pDZVqPkyHfjh4h2+F9CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOjokvOFX8jPWP0nv1JwGBZaNxz9cLDem9gbscnxqRNC1nUXRJ8FqBuEQNKlmcIo/ye53fME4mBOfDD2n0LOqRpew4B8AX4GNUmhBwDEOF+mO71GiJn/VWDWZHeX20CdPEdaWO15TcnymjX6iLEXC5xj31L3T+g8RoVhtqyZYmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+PfvSSE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+PfvSSE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCA81F00898;
	Tue, 22 Sep 2026 18:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790103075;
	bh=wAnTzVdhLbzWb07n6ZQaJVXUOJvVSfqMqPZZJNYCALs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n+PfvSSEs9JI2wkTV0MiNyKoCNK/3mwFoIvhzF6lgkU9Rp1HGYfCfqHyU5J4k6BqU
	 nlH89ouusPKlO4FGeValdSvSmN0P1R5FAN4MnPOkssVWriCSk96F+ChmOiPnMRI5Hu
	 rh4sPzdzB4FlFnsYPOuIkrUNNOMa7HOo2Ji8h1KAMxS7l2VqyJCybXEGbNZPcCYrRJ
	 RfrG+QE3vzU3v18BegzH7QKBXvhb63lOjuiBfpbTi4lVuQrGdw0TXbJv8l2mLgERL9
	 oT7VdfhOohjpGdpQqX0mBLJqEw3N/tkj9gi2svFLVXWFdNdfLSKhdFk0aUIimEgdWg
	 OOt3MEPkpVd6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] wifi: wcn36xx: Fix potential use-after-free in TX ack timer teardown
Date: Tue, 22 Sep 2026 14:51:13 -0400
Message-ID: <20260922185113.3837747-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092259-deface-ethics-a18f@gregkh>
References: <2026092259-deface-ethics-a18f@gregkh>
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
index e1a35c2eadb6c..f3d850edbdbc7 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -1007,7 +1007,7 @@ void wcn36xx_dxe_deinit(struct wcn36xx *wcn)
 
 	free_irq(wcn->tx_irq, wcn);
 	free_irq(wcn->rx_irq, wcn);
-	del_timer(&wcn->tx_ack_timer);
+	timer_shutdown_sync(&wcn->tx_ack_timer);
 
 	if (wcn->tx_ack_skb) {
 		ieee80211_tx_status_irqsafe(wcn->hw, wcn->tx_ack_skb);
-- 
2.53.0

