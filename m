Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E3C242D84
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604361; cv=none; b=TizavsF2diRqi7UMkQKFGxnGNwG8LF9Wa/PyISwpKTfvAtx8CJH74wb6L/UwMGXrCo2lJ51skO9YhMw4++5rdBWNCwQZZ7szRHfkd9QQh9MvkQkBhcr8GrnQpN39vL68Y9Z5upwPasJs7QSeS5eh5XQ3AarxHwgS/wLi4Mw2AbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604361; c=relaxed/simple;
	bh=4MNYroxBTnPLTLmQOVW5af/+/2opSvSxKTWjrqWeUlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/qbYOzQsycQj3e5XbCPG59HPI9HZ6Psfeebd+U9K0HLqq97huRc1JyklmrO3Hhf9vaej1rhsdhPUh/xG5yiQySphfFuqIV2UcuUpjkbYyXsTVyhzdd6ugDTeTptuHFJdVER4eXopEuozxL6MOyht8PS8/SEY5j4vToFuYiPOZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SplD7Sgw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SplD7Sgw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0141F000FF;
	Thu, 17 Sep 2026 00:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604359;
	bh=Xw1n0+1ws68XSHf8YLfblEYJpZn0ny3GPsfwPxTV2p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SplD7SgwJ0E617gtv2flzG8BwCpAlbV0JJidMl4z3hVIPL3fWDSA+z6VWBDnZ35BH
	 Y5A10GyAth5t+bhFwTbtyPco2vL0VrLOQErKK3Ju+5dlUJVK/j6wELHFWZaocWpN8f
	 xdtv2848VHSiU6oVHxKf1u6CV0Rk2keProjStr24o/1/Sr/nQxjDnDNQQ8+w25KmKC
	 T8BsF3UpFXFcSbcec6J0rh3zL1t+R78lepttwbAwqfN2hM/ZMA5iL6aqp/aVlGi4nG
	 p952b0LyJNhF7+BACPkXoLH8CJmIEbE+/Z25bjLZamp8THpA5eGK0qpd4RpogPplap
	 zZBfegcrBeF4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] net: macb: Use netif_napi_add_tx() instead of netif_napi_add() for TX NAPI
Date: Wed, 16 Sep 2026 20:19:15 -0400
Message-ID: <20260917001917.3360958-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917001917.3360958-1-sashal@kernel.org>
References: <2026091643-urethane-talon-e5b2@gregkh>
 <20260917001917.3360958-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Hao <haokexin@gmail.com>

[ Upstream commit c321b5676d0c41de9155c1966aa6af8b7ca35091 ]

The TX NAPI should be registered via netif_napi_add_tx() to avoid
unnecessarily polluting the napi_hash table.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Link: https://patch.msgid.link/20260403-macb-napi-tx-v1-1-08126a60c65e@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e1406330d70e ("net: macb: initialize PTP state before registering clock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 3665f5716a11a..3940d15ae8c92 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4240,7 +4240,7 @@ static int macb_init(struct platform_device *pdev)
 		queue->bp = bp;
 		spin_lock_init(&queue->tx_ptr_lock);
 		netif_napi_add(dev, &queue->napi_rx, macb_rx_poll);
-		netif_napi_add(dev, &queue->napi_tx, macb_tx_poll);
+		netif_napi_add_tx(dev, &queue->napi_tx, macb_tx_poll);
 		if (hw_q) {
 			queue->ISR  = GEM_ISR(hw_q - 1);
 			queue->IER  = GEM_IER(hw_q - 1);
-- 
2.53.0

