Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E94B368296
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607611; cv=none; b=OsCjOtFomLT6HJWwOz6yVXXtMXh8efbtaAlUDJbwjH99TlzOCIUHRrM/GSRIE+7WfDY5uMbhNeAjaG4gxorI5f9Fv5N/7dFubIVH74S3VlaE8unE9d4J73hIjGCMLS8MR2rZaTezXAKLmfpcvnGseZSgkayA0YleYZWPIgmmGDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607611; c=relaxed/simple;
	bh=EGp0qutEKOpY0akoAYW+Jw3Ra+vV7c/0ckiQBw2Z7po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFAmOfijT+gyhRi1ZNeaTa8kDAp5UKA2B2UPWIvxUPNWP9FgsD1my3EbPr060jqY00QuIbjOh0WN/e6Ijk9Ruf8PKrA4QshUzT8Ovp4QOz1hQY3T4+F0jVt//j5VlIV88FaYfo8Gm72trvHOUIwtvxo4k52qTAC+OK1jslVr4Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRKAbnjF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRKAbnjF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E0D1F0089E;
	Thu, 17 Sep 2026 01:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789607606;
	bh=ofNMmth0hJVtGH5iCwwAK3lla4ffqoVi5gJo+gutnME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eRKAbnjFGyhlIBQBcQJjjN2EshGLYkaw6pNAzBLGqFBJM6Qp/NkZ0i/OGB2W+QC0M
	 0+8RPOu+KiXzSR20QbGD2JaCNJrSuQry+pHlNulOoyr4H4O7Wu00N2YWm+jK19kd+8
	 5sUFYH5i9mLS5ocjyP5i/Vv2trkHBcmVh4fuswt5ZZqgv0H+jRR8EIoAS9AutzQvSK
	 /9qYmWU7cBWxZjpONVRNp90lPrfRIMmKAww1Ix/K6ox5gb4EATHCABc+vrT7R7AlKw
	 UgGW9JT+c/BDBIlwFN9moQbQgkuuM0zXIL4ilVIQ3zgCosC36UmPI7XYxGPKHLX4yk
	 v7iYKnFWvETcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] net: macb: Use netif_napi_add_tx() instead of netif_napi_add() for TX NAPI
Date: Wed, 16 Sep 2026 21:13:20 -0400
Message-ID: <20260917011322.3531179-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917011322.3531179-1-sashal@kernel.org>
References: <2026091646-swoop-cubical-81ce@gregkh>
 <20260917011322.3531179-1-sashal@kernel.org>
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
index d6dc6df66f1a5..d5a9def09e1dd 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4124,7 +4124,7 @@ static int macb_init(struct platform_device *pdev)
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

