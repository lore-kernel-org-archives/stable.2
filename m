Received: from sg-2-2.ptr.blmpb.com (sg-2-2.ptr.blmpb.com [71.18.227.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4013A3D565D
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788466572; cv=none; b=RVh2KIab9K8RkKM0NyqKjATk15ePrjB5fdCgACJEkGnOYk+8p4O5Xgtj7UeY1c8su2BI5w0oW+P8epQGpxASJKZyZBVrbdrsDdPSxbglyq/6TcSPEzDJ5vUZSKaoSvXE7h9GmyPAFiYq82QUuCqZhUosP7rB22OgloALVKPgCHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788466572; c=relaxed/simple;
	bh=MnX38husahtb+5jlsjHaZHaRb+oO4cDjSxx1UtgTSJ0=;
	h=References:Date:Mime-Version:Content-Type:In-Reply-To:Cc:From:
	 Subject:Message-Id:To; b=FVdM3kEu8YWCwnT1yDlgn/GF4Z6WHc8zytdAjMDrzTYOO6Lj6Jg6BhnVj4s1ZsCzG8I2dBw9qjzyJcV89h+iTUT9I195nw8Njbj0ex9NHWQEqHh+WOqGQ64dcj1zXHqI1V+4fO3LsGqLWraPnAgY3vmFmoNnkAFyqGkGECxMctA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=f2Um+nh4; arc=none smtp.client-ip=71.18.227.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="f2Um+nh4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1788466553; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ay+UdxR5B/j0GDEDWbydnqfmebpHc2uhIh4YQv8+mkU=;
 b=f2Um+nh4Wnby9Be3MeLdP6jOKt0z+euSfhstaS6G9IVDsVCTUftx3f56Fu7oxYmnhNrDiM
 LNkxgX/xb7HyGDhXwvbaw2NFRH6Uvlhogf67f3Iu8VY19gjGPWUmqvdWE4chNJWb5+5NAz
 sA+6lWO97f3u9WI6GJeawyOuHOS8UMJ1WKWmq4lnuTvJ3pGgmK3m/bmfsafZpRlGqneYoR
 qVjO8Wy/GDgdizdJVAGE9GkejnU5viFfhHytLHoYvWSeTbkRuyA7w66T6ABtvkU4xOvI3t
 U54u8X82RHySZmMjgfD29yBxGtLeE33dcyjUuVgkpH2HpfT5a9/A86C5k7Zeug==
References: <20260904-fec-ptp-pps-event-uaf-v1-0-9af446be4a11@cherr.cc>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a99d578+838a22+vger.kernel.org+me@cherr.cc>
Date: Fri, 04 Sep 2026 04:15:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20260904-fec-ptp-pps-event-uaf-v1-0-9af446be4a11@cherr.cc>
Cc: <imx@lists.linux.dev>, <netdev@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Received: from [192.168.9.107] ([111.42.148.30]) by smtp.feishu.cn with ESMTPS; Fri, 04 Sep 2026 04:15:51 +0800
From: "Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH net 1/2] net: fec: don't leave a stale PTP clock pointer after unregister
Message-Id: <20260904-fec-ptp-pps-event-uaf-v1-1-9af446be4a11@cherr.cc>
To: "Wei Fang" <wei.fang@nxp.com>, "Frank Li" <frank.li@nxp.com>, 
	"Shenwei Wang" <shenwei.wang@nxp.com>, 
	"Andrew Lunn" <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, 
	"Richard Cochran" <richardcochran@gmail.com>, 
	"Troy Kisky" <troy.kisky@boundarydevices.com>, 
	"Fugang Duan" <fugang.duan@nxp.com>, 
	"Lucas Stach" <l.stach@pengutronix.de>, 
	"Fugang Duan" <B38611@freescale.com>
X-Mailer: b4 0.16.0

fec_drv_remove() calls fec_ptp_stop() before unregister_netdev(), and
fec_ptp_stop() leaves fep->ptp_clock set after ptp_clock_unregister().
An ethtool -T issued while the netdev is still registered then reaches
fec_enet_get_ts_info(), which passes the stale pointer to
ptp_clock_index() after the clock structure has been freed.

Query the PHC index through ptp_clock_index_by_dev() instead.  The lookup
holds a reference to the matching PTP class device while reading its index,
so concurrent unregister cannot free it underneath the lookup.  It returns
-1 once no clock is registered.  Clear fep->ptp_clock after unregistering
it as well, so the driver state no longer retains the invalid pointer.

Fixes: 32cba57ba74b ("net: fec: introduce fec_ptp_stop and use in probe fail path")
Cc: stable@vger.kernel.org
Assisted-by: GLM:5.3
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
 drivers/net/ethernet/freescale/fec_main.c | 3 +--
 drivers/net/ethernet/freescale/fec_ptp.c  | 4 +++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 794ec427b0ee..0606559d495c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3337,8 +3337,7 @@ static int fec_enet_get_ts_info(struct net_device *ndev,
 					SOF_TIMESTAMPING_TX_HARDWARE |
 					SOF_TIMESTAMPING_RX_HARDWARE |
 					SOF_TIMESTAMPING_RAW_HARDWARE;
-		if (fep->ptp_clock)
-			info->phc_index = ptp_clock_index(fep->ptp_clock);
+		info->phc_index = ptp_clock_index_by_dev(&fep->pdev->dev);
 
 		info->tx_types = (1 << HWTSTAMP_TX_OFF) |
 				 (1 << HWTSTAMP_TX_ON);
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 56801c2009d5..0036549974fd 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -861,6 +861,8 @@ void fec_ptp_stop(struct platform_device *pdev)
 
 	cancel_delayed_work_sync(&fep->time_keep);
 	hrtimer_cancel(&fep->perout_timer);
-	if (fep->ptp_clock)
+	if (fep->ptp_clock) {
 		ptp_clock_unregister(fep->ptp_clock);
+		fep->ptp_clock = NULL;
+	}
 }

-- 
2.47.3
