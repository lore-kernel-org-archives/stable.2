Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4E848EC85
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106915; cv=none; b=u9+KvB/2Dw5dMfdRzcjE6v31/wXJ2GzYOXFzaj1bg1lEVZAUIZgEf0N0ArPbztwkOuquH6Vl4xtNyZXZpSJNIqYlgCa+8mK7p23ruyruIv9TZbCDOTofwzCdXlwRmY46BD39fhqVzZsE7s+Xxa+q3TMa3XKP+E+ni5vfWWnQclA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106915; c=relaxed/simple;
	bh=0wwaazxq/qhhb2Tb4wepWC/Nw3ZW6mcXdGzCoNzSQGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMiEsN9TW3vULmCZjkj4hQjNwTXWHlAhCUx3Kk6a0h0/pLyTCg+mV1uDoRX6MX/JlRj29uHoBCRyCNtgA6TjbRcYncSU6La4dZsNTKeQ79NnL+YSoE33mvRHpL1kzRqz5l69WkWQcm49MQ7mmeuXrQUdboeKifyma7PVPk5AKfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjIwyxt3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjIwyxt3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3985B1F00893;
	Tue, 22 Sep 2026 19:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790106912;
	bh=0+0s0ufhwsFh78N13EQa2IO/DW7t6XXWYB2dZKGiH9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cjIwyxt344E058zgI0IqvncI6bAEbdx+cOXFQCI/IM/IufJDpgTrL2Hc9VEZX5iDX
	 K3z3FloV2g6+C+cWvF+6PGS87kv+EwFb5CkSo6ittOxD9SyK2aJLsHfLGFPWMs7UfC
	 N3QIXHh3TekbFBfwSgI4E/twyN4nJlQuwgdx3GyGGAGT3C4wgY39QLnb0Q4/Ur/Qvp
	 CABIjAErFStLs36YV0vtwjxdz1pcbWE3FiNlWdO/S2mc5RV6rxQoTzKJMy8oPGuvH/
	 3kOuhst7uO8fUvis/JrK3HwrKFTpi7CzmPSYg4d8GjyxktUW5gwisxr8XBshZ9kNI+
	 2VgMzKxgUtLGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] wifi: wcn36xx: Fix potential use-after-free in TX ack timer teardown
Date: Tue, 22 Sep 2026 15:55:10 -0400
Message-ID: <20260922195510.136523-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092200-humiliate-detract-e1be@gregkh>
References: <2026092200-humiliate-detract-e1be@gregkh>
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
[ Replaced unavailable timer_shutdown_sync() with timer_delete_sync(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/wcn36xx/dxe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index 6c62ffc799a2b..6840aca0dd3ec 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -1007,7 +1007,7 @@ void wcn36xx_dxe_deinit(struct wcn36xx *wcn)
 
 	free_irq(wcn->tx_irq, wcn);
 	free_irq(wcn->rx_irq, wcn);
-	del_timer(&wcn->tx_ack_timer);
+	timer_delete_sync(&wcn->tx_ack_timer);
 
 	if (wcn->tx_ack_skb) {
 		ieee80211_tx_status_irqsafe(wcn->hw, wcn->tx_ack_skb);
-- 
2.53.0

