Received: from out-182.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66299437474
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009962; cv=none; b=YR2cULo78zMr4/7XX8G1WTIe/MHPwRmvtIMY3z1zs9jMUh+i5xWCwTNDUksMQR0eml+74/aUWPZIVoSMtm2wqWF56PBiFX1Hmr5Q6O1qrF9JqIgXsMRnZ+w6YokxzYK373/Dhc9a6MWhtModS59kA21x0fCBvohcX4ODPS7fVQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009962; c=relaxed/simple;
	bh=wObnvPAv+vZwmPrRREErZi3YvA6ABerwh5TlF9DSF5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NC/NWpNkujvKtH0F6s1jMK5XUURoi3sjt6Yja3N39dLu5LWD70CkCPlWxGkEC/GbzFK01SQ+YLsVXsgNLr+2skr1boihPPguTiSko7OTmx58bx96T5LFUO9Hn0V6DWuNvDnfFGeKrW2oATCEBCvRsJxNc9VISeArDnA3uK3Ie0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qQfu9i1L; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qQfu9i1L"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786009955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SJpg/ra0FAfobqiE0jlVrfozkrsrnmT/pVP3sl7+CNs=;
	b=qQfu9i1Lt36q1fGz//3x5KjmRomAawIljG1eWwhQFhAF9fyxDJkgvwDV/UqykYmcKwz2Lv
	ZEYH1bIAd4bYiZJpSbDvIt8piQ5bytgTzFWLViOcUUsqshgmZm2+R8xpPwucUEyjEcYICr
	Vy/2r/PmUiu/iyeLq13MXVD+KgX5Yqo=
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
Subject: [PATCH net v3 2/2] net: ravb: serialize PTP clock teardown
Date: Thu,  6 Aug 2026 17:51:26 +0800
Message-ID: <20260806095126.57803-3-xuanqiang.luo@linux.dev>
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

ravb_get_ts_info() can run without RTNL while ravb_ptp_stop() unregisters
the PHC. The PTP interrupt handler can race with the same teardown, so both
paths may access the clock while it is being freed.

Protect the clock pointer with priv->lock, clear it before unregistering
the PHC, and unregister the detached clock outside the lock.

Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/renesas/ravb_main.c | 16 ++++++++++++----
 drivers/net/ethernet/renesas/ravb_ptp.c  | 17 +++++++++++++----
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 3a9d9f8718216..c2220a54a2bf4 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1765,8 +1765,13 @@ static int ravb_set_ringparam(struct net_device *ndev,
 static int ravb_get_ts_info(struct net_device *ndev,
 			    struct kernel_ethtool_ts_info *info)
 {
-	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *hw_info = priv->info;
+	const struct ravb_hw_info *hw_info;
+	struct ravb_private *priv;
+	struct ptp_clock *clock;
+	unsigned long flags;
+
+	priv = netdev_priv(ndev);
+	hw_info = priv->info;
 
 	if (hw_info->gptp || hw_info->ccc_gac) {
 		info->so_timestamping =
@@ -1779,8 +1784,11 @@ static int ravb_get_ts_info(struct net_device *ndev,
 			(1 << HWTSTAMP_FILTER_NONE) |
 			(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
 			(1 << HWTSTAMP_FILTER_ALL);
-		if (priv->ptp.clock)
-			info->phc_index = ptp_clock_index(priv->ptp.clock);
+		spin_lock_irqsave(&priv->lock, flags);
+		clock = priv->ptp.clock;
+		if (clock)
+			info->phc_index = ptp_clock_index(clock);
+		spin_unlock_irqrestore(&priv->lock, flags);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index eaf07cb8eadfa..530902a99d5ba 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -289,16 +289,17 @@ static const struct ptp_clock_info ravb_ptp_info = {
 void ravb_ptp_interrupt(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct ptp_clock *clock = priv->ptp.clock;
 	u32 gis = ravb_read(ndev, GIS);
 
 	gis &= ravb_read(ndev, GIC);
-	if (gis & GIS_PTCF) {
+	if ((gis & GIS_PTCF) && clock) {
 		struct ptp_clock_event event;
 
 		event.type = PTP_CLOCK_EXTTS;
 		event.index = 0;
 		event.timestamp = ravb_read(ndev, GCPT);
-		ptp_clock_event(priv->ptp.clock, &event);
+		ptp_clock_event(clock, &event);
 	}
 	if (gis & GIS_PTMF) {
 		struct ravb_ptp_perout *perout = priv->ptp.perout;
@@ -334,16 +335,24 @@ void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
 		clock = NULL;
 	}
 
+	spin_lock_irqsave(&priv->lock, flags);
 	priv->ptp.clock = clock;
+	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
 void ravb_ptp_stop(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct ptp_clock *clock;
+	unsigned long flags;
 
+	spin_lock_irqsave(&priv->lock, flags);
 	ravb_write(ndev, 0, GIC);
 	ravb_write(ndev, 0, GIS);
+	clock = priv->ptp.clock;
+	priv->ptp.clock = NULL;
+	spin_unlock_irqrestore(&priv->lock, flags);
 
-	if (priv->ptp.clock)
-		ptp_clock_unregister(priv->ptp.clock);
+	if (clock)
+		ptp_clock_unregister(clock);
 }
-- 
2.43.0
