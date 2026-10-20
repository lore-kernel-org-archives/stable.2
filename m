Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483062;
	b=nEY61gF21jtFFGRrCFT1rIvQ8l1lyysMVzh8R3lbw9nFyx3F8DOHtcGa2TFqlr8nvW6z
	 9Z6Jf8PgNa8gnJzyBBEsDOCuDnzI6mgIXHw3tAwUNk5kmHEvVDoYWsYjFB3jvKEfv4Qnk
	 bLMLJpWqMTQOt6ypw/K5yy5HfSUi02LdPAjTjusZdcwRMH6J9DcGLyYIsAI8zyVU32+tl
	 I0OBBDXR/xoRN5nEOxxuONztEjRoJkgCsFwgq/B5NInAQzVAIauRcydvouUXndLh2/vWA
	 W2LDiT53CILo+ny4JbuN6VPXX2gVQBg9xh5e+k4yVycpKP1VZ/zi/C8FR/RVfnl0JUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483062;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TSMUNBIMLq6k47P6585PC+8d39w6JNFD5duvSGlLkG4=;
	b=MC4n0+3p/yXOF5LizYlt0rjuHGITe/jt3guRNnu2/JPK9OvD8lF3gc/qDYv2I+3fcdk9
	 f/PXIJEnueUUWpjdnwv6Tbz/L8NsvLaadQqhH/O9/7Bd7tkbDVtB+bPClCxfVG0+swrF/
	 VPjuPCqXmb5JCkOoZgD6OedSVmhWTKOEzdCaJBmHVirEXONaHeW0H4+HME5azfIG5/Sm9
	 cMG5I0DrQd3aQ18POeBSJ9pv3T6hNrmxw8C+I29silUaZs6Ee+R1bcExdXOXOkMH7V37g
	 ke7leLepqL74AXVCkdU1tQmRyIHAdhcz8e4fLMfNKpH0j0ECgMzVfIFm7jtVzFkLRwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=Mbo+9Vgj;
	arc=none smtp.remote-ip=115.124.28.193
Received: from out28-193.mail.aliyun.com (out28-193.mail.aliyun.com [115.124.28.193])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D007E606A322;
	Tue, 20 Oct 2026 07:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D007E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=Mbo+9Vgj
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1792483051; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TSMUNBIMLq6k47P6585PC+8d39w6JNFD5duvSGlLkG4=;
	b=Mbo+9VgjcoaLP4hHnqsAykr40B9qmT9q2NUWY67g8LXl0etDOWx1mT4PeCEV1rnBZ8CN8Slp4PyfWUXT4kdT/GU8htxsLuRFAXvK/Q95mQFveT8V4Z9hJWvvGcRP9N5d/L1vNdOy041DBTe1O0Kj7yRPz1Es9znQhkDRa5C05hlSTKhOWhMGYdA4qrcWF2nWY9TxRp6/UF25w/ZyIWiCJUtoESKLhzwatfHyXgA4NgunVlSqmt6Fl3AvWigWaniFC2Sv32boeo5R/UOlb4LCwvExHNjAmYxrTvTJuT75ZoJnQ5FBE83kFF+3WCbnKmt01o8mzZxgK6XHoW5beVWnng==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436621|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0248096-0.00467838-0.970512;FP=594139034435604405|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083032240;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jlc4-op_1792483049;
Received: from galx..(mailfrom:chunyuzhiqiang@yinhe.ht fp:SMTPD_---.jlc4-op_1792483049 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 20 Oct 2026 15:57:30 +0800
From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org,
	linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	kernel@pengutronix.de,
	haibo.chen@oss.nxp.com,
	shawnguo@kernel.org,
	imx@lists.linux.dev,
	stable@vger.kernel.org,
	ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Subject: [PATCH v5] can: dev: can_fill_info(): don't wake up controller if interface is down
Date: Tue, 20 Oct 2026 15:53:40 +0800
Message-ID: <20261020075340.417899-1-chunyuzhiqiang@yinhe.ht>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018101744.93657-1-chunyuzhiqiang@yinhe.ht>
References: <20261018101744.93657-1-chunyuzhiqiang@yinhe.ht>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the interface is down, the CAN controller might be powered down, the
clock disabled, and/or its external reset asserted.

Don't call do_get_berr_counter() or do_get_auto_tdcv() to read the CAN
controller if the interface is down. This fixes a generic logic problem
that exists on all platforms.

As a result, IFLA_CAN_BERR_COUNTER and IFLA_CAN_TDC are no longer
reported for down interfaces. This is intentional: the counters are not
meaningful in that state, and calling into the driver can wake a
runtime-suspended controller or touch registers whose clocks are gated.

Fixes: ec56acfef2af1 ("can: flexcan: flexcan_get_berr_counter(): switch on clocks before accessing ecr register")
Cc: stable@vger.kernel.org
Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
---
v5:
 - Gate can_tdc_fill_info() on netif_running() for IFLA_CAN_TDC, as
   requested by Marc Kleine-Budde. This branch has no IFLA_CAN_XL_TDC
   definition or call path at all.
 - Keep the TDC part of can_get_size() consistent with can_fill_info(),
   without hiding the non-TDC data bittiming attributes.
 - Document that IFLA_CAN_BERR_COUNTER is no longer reported for down
   interfaces, and explain why this is acceptable for stable.
 - Clarify the Fixes: rationale.
---
 drivers/net/can/dev/netlink.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 6f83b87d54fc..66b37257b76b 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -548,8 +548,9 @@ static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
 	return size;
 }
 
-static size_t can_data_bittiming_get_size(struct data_bittiming_params *dbt_params,
-					  u32 tdc_flags)
+static size_t
+can_data_bittiming_get_size(struct data_bittiming_params *dbt_params,
+			    u32 tdc_flags, bool tdc_if_running)
 {
 	size_t size = 0;
 
@@ -560,7 +561,8 @@ static size_t can_data_bittiming_get_size(struct data_bittiming_params *dbt_para
 	if (dbt_params->data_bitrate_const)		/* IFLA_CAN_DATA_BITRATE_CONST */
 		size += nla_total_size(sizeof(*dbt_params->data_bitrate_const) *
 				       dbt_params->data_bitrate_const_cnt);
-	size += can_tdc_get_size(dbt_params, tdc_flags);/* IFLA_CAN_TDC */
+	if (tdc_if_running)
+		size += can_tdc_get_size(dbt_params, tdc_flags);/* IFLA_CAN_TDC */
 
 	return size;
 }
@@ -584,7 +586,7 @@ static size_t can_get_size(const struct net_device *dev)
 	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_STATE */
 	size += nla_total_size(sizeof(struct can_ctrlmode));	/* IFLA_CAN_CTRLMODE */
 	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_RESTART_MS */
-	if (priv->do_get_berr_counter)				/* IFLA_CAN_BERR_COUNTER */
+	if (priv->do_get_berr_counter && netif_running(dev))	/* IFLA_CAN_BERR_COUNTER */
 		size += nla_total_size(sizeof(struct can_berr_counter));
 	if (priv->termination_const) {
 		size += nla_total_size(sizeof(priv->termination));		/* IFLA_CAN_TERMINATION */
@@ -598,7 +600,8 @@ static size_t can_get_size(const struct net_device *dev)
 	size += can_ctrlmode_ext_get_size();			/* IFLA_CAN_CTRLMODE_EXT */
 
 	size += can_data_bittiming_get_size(&priv->fd,
-					    priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
+					    priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK,
+					    netif_running(dev));
 
 	return size;
 }
@@ -735,7 +738,7 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    nla_put(skb, IFLA_CAN_CTRLMODE, sizeof(cm), &cm) ||
 	    nla_put_u32(skb, IFLA_CAN_RESTART_MS, priv->restart_ms) ||
 
-	    (priv->do_get_berr_counter &&
+	    (priv->do_get_berr_counter && netif_running(dev) &&
 	     !priv->do_get_berr_counter(dev, &bec) &&
 	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||
 
@@ -764,7 +767,7 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		     sizeof(priv->bitrate_max),
 		     &priv->bitrate_max)) ||
 
-	    can_tdc_fill_info(skb, dev, IFLA_CAN_TDC) ||
+	    (netif_running(dev) && can_tdc_fill_info(skb, dev, IFLA_CAN_TDC)) ||
 
 	    can_ctrlmode_ext_fill_info(skb, priv)
 	    )
-- 
2.47.3

