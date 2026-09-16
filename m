Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2D552FE4D
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602822; cv=none; b=iELBbiKO/NI+3Wzl3CYC5Mz/f7h934bTA/fdhHLUdsZnSGp+3BXt79WxWOR7OTwBTgJBE9DFK8keFY0CaD7IAuj2iewuZd4+GNv1GwoS6x8WDGSStMAaL6MDG87EwlZP7ieaevhd2exNksmjIavGGqc/P17nQJ7OW5P+8vYg0ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602822; c=relaxed/simple;
	bh=6mAaNVNf06Hu0s05g79vMyATKwwRgdj1OTCHzSUbDKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugvLMx87woXZulYM7zOGExgzgMEOjwtiCY+47e7HUPHNU3UBEYPwm52X9adCmni5Typ4OvgJE2ztuv+JNAEzC8dKrjndf7N1xuPZ/F8jbmqXpL3nbjX1SJ6/8iNGaN8a06OKSQa8z/aSUqhoH880qcIMZczR04kN/Mw8EVT0B4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7MEFsNh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7MEFsNh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A551F00899;
	Wed, 16 Sep 2026 23:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602821;
	bh=MQmns15+urswIRQe5/0GYLnfcWGCM2wDMnmjQQTkGvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e7MEFsNhLR2JuYWyqWQfzJdEiRzZSLUIE+yb5H2ID8wJsblicuF5Yp6T6BcvPyG8l
	 hI1MuoRxXBdtyqyW/ZbUlw4lp34JS/f7EXWBHcT9MJiK9WtJHas9VGDB08mstIXtRN
	 ldUt9QFkscFGhXMcH++9MfPpmP+sP8kkAk/BCUKAJiOSiJxuEC8+K/WxGp7bUv27wT
	 UiDdA5rq31EIZbR3vyWF1FfZuUjenjUGqRHM/aEsJcoU8oXPkOKWNYLJGuRha/xnXh
	 T1a/fSwpj1NcQMRQDKZ6rJQQ3vaff3tngwa9Ia/JW+f4/dGXXOec4K2i/uD1WFLk6M
	 NPyZnot7/EQ6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] net: macb: Use netif_napi_add_tx() instead of netif_napi_add() for TX NAPI
Date: Wed, 16 Sep 2026 19:53:36 -0400
Message-ID: <20260916235338.3313589-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916235338.3313589-1-sashal@kernel.org>
References: <2026091642-wasting-vagueness-0a57@gregkh>
 <20260916235338.3313589-1-sashal@kernel.org>
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
index 71db2927b79ea..d0afcefb3e4c8 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4648,7 +4648,7 @@ static int macb_init(struct platform_device *pdev)
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

