Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82191624D5
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101865; cv=none; b=aMQPzmVIBbV9Hvvp3XvGXvBab0BuKV8yY5t3SmlLvzEtHJ/ypMyAvEj1w2i+dBHS0r6HSnohUXYlDz/i5Bw+CzqCzbjv2TT30u0ttIBf8eudukXnaWX+miFLiU1s112sG7UVAmyfciOzh81YiRjj9tz5HNKpdW++H+5F1jCj1Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101865; c=relaxed/simple;
	bh=1y75AaMguH6uljQlPwJogg2vEQLAnlbiJ5276jKxMgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YC+dlmWxmknKPLoPkQTHLLJXtB/Bd+phIdvmsR55h59FniQ2Tg4uxm6sTnz9o5bF2zu4DvzB6BV0P0y7Bk5mtVxyi9+mKRFNKXQ6Cg08YigTpj6RYRoQxitKyO70g5TSF5gTf1LtXwP656s0uxr4cBShac1ozEIlMGrjvVUVeTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAh7sNDi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAh7sNDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3D91F000FF;
	Tue, 22 Sep 2026 18:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101863;
	bh=Ofvo7Bff1DRLmGpl73rBvyG1AP/Jp1wLiaQ+xWOI45Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jAh7sNDigz8aEKhF2YQHUmuCFBkIwPPIhDtTd/BzO2TgrX34XmVFyiBZ+54jvpl6G
	 XB0nBgOPQsweGHNB8ZWBHPlhTQ/6Jfrx8uqO67e5OHDPuA6zNr0STlB8q+7IZ+6aJ9
	 U3qe3/hP7UBM3gbm361t1iWrBpCA+7h9s1ELbktHgWjuh2NfXRTdNCHH1p0ie3FT5I
	 7B4UJfbRCNe+zRJ3/vIsx9mCArEuUgoKaGMjVg52vT90oYXUTc8oyGjiwHJ94xSEng
	 3JVoe+ps/F9GOIkTPy1eUvZ7kBvaU4M1Q2m9XKEA6RAMf3mLDiV7w4qoZZffxQmrd3
	 vS8lNGZY5YGCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] wifi: wcn36xx: Fix potential use-after-free in TX ack timer teardown
Date: Tue, 22 Sep 2026 14:31:01 -0400
Message-ID: <20260922183101.3660089-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092256-silk-bodacious-1e88@gregkh>
References: <2026092256-silk-bodacious-1e88@gregkh>
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
index d405a4c34059e..079ca09c7517e 100644
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

