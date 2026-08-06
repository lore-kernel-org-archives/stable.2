Received: from out-181.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA71437852;
	Thu,  6 Aug 2026 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009956; cv=none; b=gVfj+MPOFi2da01npBctL42G2SUmCGz3emJ3g+Fv6u6mkyUiKSITchcwBblEncMAc92AEIlp8qPM24JFHBnNsuO5yZzYTLylP5bOBc+80YWK7G5zMoMi7cxpuRJwCTpRiGq9M0vlkcVMeWuXLABRTsrHrSxUPHmv45FLqNN1jlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009956; c=relaxed/simple;
	bh=/uoYp1d+FBbvHWBxDFf8uEaOKT2JavIry4Hc8bM5vEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGWS3e8QO1zfsAYKV9TwWNipLjAcO/0YwlZSNYR/PhN10wd/PBw9WmCagXezJl7NnMkconaFgV4AYgcMxobpQJtBl1mmZ1epyrN7UUH3WqW8Bj385nLH6QaPipQXt74cpALgf7/TjGDAoGL0qv7KQTiIdDzCpPC57g4QtuSnCmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d0T4FsVf; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d0T4FsVf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786009949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bon45exIwKpMgBaXBJIpnGKTokj/skb1vKbdi9PYESo=;
	b=d0T4FsVfCuaxXwBOrIyWBvUVHyLSHnz0XFrmfKznADu9i19FjPwP1KnM7oNlpT/SD9GRKR
	VImV1/HfEBUBuyPFb2KKPfCpDZPpOcp1q08X1s10X9kuJ5kBRhtqhh4FerBZF3J8wQ3bmw
	ExqeB8NxwAT9wawuiWldyCJM5EUCpuE=
From: xuanqiang.luo@linux.dev
To: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	niklas.soderlund@ragnatech.se,
	kuba@kernel.org
Cc: paul@pbarker.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	masaru.nagai.vx@renesas.com,
	sergei.shtylyov@cogentembedded.com,
	luoxuanqiang@kylinos.cn,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/2] net: ravb: handle unavailable PTP clock
Date: Thu,  6 Aug 2026 17:51:25 +0800
Message-ID: <20260806095126.57803-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20260806095126.57803-1-xuanqiang.luo@linux.dev>
References: <20260806095126.57803-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

The PTP clock is registered by ravb_open(), not ravb_probe(). Therefore,
priv->ptp.clock is NULL between register_netdev() and the first open, and
ethtool -T triggers a NULL dereference in ptp_clock_index().

ptp_clock_register() may also return an error pointer, which can reach
ptp_clock_index() or ptp_clock_unregister().

Normalize registration errors to NULL and only query or unregister the
clock when it is present. Leave phc_index at -1 when no PHC is registered,
while preserving the static hardware timestamping capabilities.

Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/renesas/ravb_main.c |  3 ++-
 drivers/net/ethernet/renesas/ravb_ptp.c  | 12 ++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 5f88733094d0f..3a9d9f8718216 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1779,7 +1779,8 @@ static int ravb_get_ts_info(struct net_device *ndev,
 			(1 << HWTSTAMP_FILTER_NONE) |
 			(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
 			(1 << HWTSTAMP_FILTER_ALL);
-		info->phc_index = ptp_clock_index(priv->ptp.clock);
+		if (priv->ptp.clock)
+			info->phc_index = ptp_clock_index(priv->ptp.clock);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index 226c6c0ab945b..eaf07cb8eadfa 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -315,6 +315,7 @@ void ravb_ptp_interrupt(struct net_device *ndev)
 void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct ptp_clock *clock;
 	unsigned long flags;
 
 	priv->ptp.info = ravb_ptp_info;
@@ -327,7 +328,13 @@ void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
 	ravb_modify(ndev, GCCR, GCCR_TCSS, GCCR_TCSS_ADJGPTP);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	priv->ptp.clock = ptp_clock_register(&priv->ptp.info, &pdev->dev);
+	clock = ptp_clock_register(&priv->ptp.info, &pdev->dev);
+	if (IS_ERR(clock)) {
+		netdev_err(ndev, "failed to register PTP clock: %pe\n", clock);
+		clock = NULL;
+	}
+
+	priv->ptp.clock = clock;
 }
 
 void ravb_ptp_stop(struct net_device *ndev)
@@ -337,5 +344,6 @@ void ravb_ptp_stop(struct net_device *ndev)
 	ravb_write(ndev, 0, GIC);
 	ravb_write(ndev, 0, GIS);
 
-	ptp_clock_unregister(priv->ptp.clock);
+	if (priv->ptp.clock)
+		ptp_clock_unregister(priv->ptp.clock);
 }
-- 
2.43.0
