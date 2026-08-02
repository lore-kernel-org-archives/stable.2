Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8941FBEA8
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785661733; cv=none; b=eEr+nDcSb3RbDFd4wHPHeVJtWjznhYj4m30RMRGIbf13tEJnYe5/J6ao9mqaoy2hMXnHhQUAeJ87hoOT03iEGenYeQzMBBolMF2UbB2dJSRDoIosYvm3UiVwHlVclR0ReolFr/Te4Q8G6J9VKUG40dyqdfSzNCF+APFu0my7/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785661733; c=relaxed/simple;
	bh=vr5FieNul6v7aRMe8t9C2BRz6zj3XBvfRH/3YlYbbF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r3q5wwvalYHazHkvAVtvq8hytipGFtp2KGp0e3vQMe0aTv7OnevosWWmNsPAFK2dP/K0g5mHeF19oh5oOEZoyFw3al8TRAboTET5RkLdGcdch842E6fBWXkmb61WyT/1SQRh0N5JXBrjNZxh34jXoyIuOc3TRpwX58UqGpEr/gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gcdE+efX; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gcdE+efX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785661727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w/T6K2mr9ZSprKOtfnrHuagF6NEudX+Bfq+aCHaPNTw=;
	b=gcdE+efXOo+j4B5xKS5sAKWtH2ogsR4KzGgNZuedRbMlyHMxYLBRqEveEsdpR4Od4/Z+be
	7DphTSfNWMDVmMWpt8lRpDdx73ULxdoWSVaCaet4PoI76bAe+Z+WFr8SJnHNY1wa92P3o6
	kHjHrpytQGn6V2cZ3P+JnLq6TElYR5M=
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: niklas.soderlund@ragnatech.se,
	paul@pbarker.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	masaru.nagai.vx@renesas.com,
	sergei.shtylyov@cogentembedded.com,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: ravb: fix use-after-free in ravb_get_ts_info
Date: Sun,  2 Aug 2026 17:07:50 +0800
Message-ID: <20260802090750.116215-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

The PHC is registered by ravb_open() and unregistered by ravb_close().
However, ravb_ptp_stop() leaves priv->ptp.clock pointing at the freed
clock. Since the netdev remains registered after ndo_stop, get_ts_info
can still pass the dangling pointer to ptp_clock_index(), resulting in a
use-after-free.

Clear the pointer after unregistering the clock and only advertise hardware
timestamping support when a PHC is available.

Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
v2:
- Only advertise hardware timestamping support when a PHC is available
  (Niklas Söderlund).

v1: https://lore.kernel.org/all/20260731063254.71260-1-xuanqiang.luo@linux.dev/

 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 drivers/net/ethernet/renesas/ravb_ptp.c  | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 5f88733094d0..f22cff05ba35 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1768,7 +1768,7 @@ static int ravb_get_ts_info(struct net_device *ndev,
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *hw_info = priv->info;
 
-	if (hw_info->gptp || hw_info->ccc_gac) {
+	if ((hw_info->gptp || hw_info->ccc_gac) && priv->ptp.clock) {
 		info->so_timestamping =
 			SOF_TIMESTAMPING_TX_SOFTWARE |
 			SOF_TIMESTAMPING_TX_HARDWARE |
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index 226c6c0ab945..fc8c601ed3a5 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -337,5 +337,8 @@ void ravb_ptp_stop(struct net_device *ndev)
 	ravb_write(ndev, 0, GIC);
 	ravb_write(ndev, 0, GIS);
 
-	ptp_clock_unregister(priv->ptp.clock);
+	if (priv->ptp.clock) {
+		ptp_clock_unregister(priv->ptp.clock);
+		priv->ptp.clock = NULL;
+	}
 }
-- 
2.51.0

