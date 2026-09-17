Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE915B206
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 00:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604761; cv=none; b=SQPatVil6N/ivDkcYNrisJcjvRzWEuPPiJnERGPAUTpaxQWry3BVc0LbptmoSLpQz9xN5SXtal9UIwj1HGg0qqG/2gX8G15ILN8uvXc5vx+JWLYJJapJZzRkUEKgB/PSuvm1c2UkG8powypdbedv3z+TsIuUn3NbRVQkG784cC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604761; c=relaxed/simple;
	bh=RHlKwQQrIXCWv6MIqds2UR4DgQJsMBumFGte6Vap3Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5wFhwMuwgKU+a3kBvKttBwyE45wxcKF/fIcP6TmNrejjEs+MPTw4rzc6SG/Nz+uVkcrXxCPuzRds8XGyB6IU6Ni0nc0UmRgS4sMVVtdGHcDA6xXGlhoNPm4f0cZX1GEaUZIbDsQSj+A77HA7cl1p4M0TvKOvO1ODkPVaF2m0IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZ7mKgOx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZ7mKgOx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741341F000FF;
	Thu, 17 Sep 2026 00:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604759;
	bh=GKmhUndCmShb16ROutnXlbS9R3dv+aUS8osPbea8OVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NZ7mKgOx26ankLx6L21WJF2yiCnXUuznfC9S4vGKreO6lBDBgGkcg4cEyZF2lX96v
	 viMUP/a3G4p7fWhu40OD8F69U0xRVrQL+TaC5eVKPhQvZxe11a6wP5f3ND8pxu5YwL
	 gd6wRbbHTlp3GvECEdt9awWStdqMsTzkAvcvAbmwLUmAdHRYok8ededPj32ehHGxkE
	 mp5PJXfgMZ8uaMP6TMGtWNB4r188WD5mvO+vcyR99y16hsCoGF8aoapfd9ssWutJCG
	 JeY5N1E0dOv9Z3KZnxiFAewtMeDMe+bFtnb1pZjAdv8W08I8y9a1xunDhKnohwpz16
	 1BmIIu3FLt86Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] net: macb: Use netif_napi_add_tx() instead of netif_napi_add() for TX NAPI
Date: Wed, 16 Sep 2026 20:25:55 -0400
Message-ID: <20260917002557.3379520-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917002557.3379520-1-sashal@kernel.org>
References: <2026091645-winnings-facsimile-bba7@gregkh>
 <20260917002557.3379520-1-sashal@kernel.org>
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
index 249fd168c89d4..235baf9fef60c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4228,7 +4228,7 @@ static int macb_init(struct platform_device *pdev)
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

