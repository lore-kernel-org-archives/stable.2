Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793575508;
	b=R/nHHM8HiZP/J432bQkHhWKChbh5gzS6sCU89I0KjuvALPRsAPBnAdhLqgDpEfl8e1J+
	 +0KAFWQT8I8bBmk1Mdi4x/FaCTSRQmbzYLZmjZVG/NwuuNuuys8zdU1+q/UzdTsBTTXRw
	 49HiJBXjmZx0j1zIOqkP91KyfXfxe9IZF5O772jf8DQoeZ1tU4eRJIaxmCeFaoCaGVty6
	 FGO4n+8T0jhS/U/f+aj9W9CoM2c/OwW7mTchT+oMG3kzg+k/wJSxOdwAckwBjPKcDMRrk
	 dTQ1sj92P+tmaF9NE1WoGBpGiWYmfu5EVxWT3KZYxfszgmGrCe2y+EpzGQ6ySURlhfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793575508;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=UG8rsdKQKWtqfb7CnEJqSbG1l0IONjhXQyydvT12edk=;
	b=Kd+mGkWviYDYrLCjtU2Y5+rtaLPC+YVw7A917Tqu/Bt2OaTe9cxN91zQIN5dPIwC/9dn
	 uXJw9MR4wZfHWNbm7xxpRrBBs92eJgA/jybidzchGYMvqJclj4M0LOI+CTz7limqlUZJo
	 NgKEX7+JcciKEnmrfs0Hdhr92OM8SY0uDPqsjPrhPnbSKjVuWOYI55qbn1n/N9iAOjOQP
	 9RxUCRnkQHOcYIBnEYQKyfdXIPl0oZCE8z3kIJgDkZGe8xVNCtmt9ug+ltJssgMltubdV
	 yXVByOa7VNVRb0rZmQgJhi4HUS3mMXr9WAlWqTDrhk92D1rRrB0CpKzDSoNIS3h/5sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b="JoQgkD/S";
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40004606A324;
	Sun,  1 Nov 2026 23:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40004606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=JoQgkD/S
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=UG8rsdKQKWtqfb7CnEJqSbG1l0IONjhXQyydvT12edk=; b=JoQgkD/SwwR0VT3aJtB3CU0kK+
	NVRMDy4h0MBKe7FWmv73ft5Rw2hgeuFn5IWnoOPEPGeW2dIhDJ3m1zGQhctGbVbujkI4Z110f5BTV
	5jW/tsu2+B2WA4b+PpIwkJAK3BdgNiKeiiTKD3tlh9z4zyFgSkIAE2DUPQVzmilO9EzrUxiasDPfk
	gEUB48Gfh3oczcL37J66JZlaqdchqpS+TCtyqrG2s+tqj+O/subpl9RQV2fy7U+VRLfWwXz5kaZbx
	DakRQuapRThkVTNlqDiBH1IK2V2T0QW6Q+YxiJCxr5DmcMvtIRUU4ln8fuQS3+NzRYYQktF94gz79
	KwBYq9Bg==;
Received: from [151.115.150.205] (port=38008 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xNevC-00000004spB-0W58;
	Mon, 02 Nov 2026 00:25:05 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: qualcomm: rmnet: avoid stale VND access on TX drop
Date: Sun,  1 Nov 2026 23:23:54 +0000
Message-ID: <20261101232354.2047804-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

A struct rmnet_port stores a pointer to the most recently created
RMNET VND in port->rmnet_dev, but userspace can delete that VND while
the port still has another attached VND. When RMNET later sends a
buffered TX skb, a failure in __skb_linearize() makes rmnet_send_skb()
update the drop counter through that stale pointer, which causes a UAF.

The stale pointer can also be used by rmnet_unregister_bridge() when a
real device leaves bridge mode. In that case it is passed to
netdev_upper_dev_unlink(), which dereferences the freed VND and leaves
the actual bridge adjacency behind.

Account TX drops on the lower device and use the current bridge master
instead of port->rmnet_dev when unlinking. Remove the now useless
port->rmnet_dev.

Fixes: d939b6d30bea ("net: rmnet: fix bridge mode bugs")
Fixes: 64b5d1f8f2d1 ("net: qualcomm: rmnet: add tx packets aggregation")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---

Changes in v2:
 - Strengthen the UAF fix following review by Sashiko on the v1 (https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261031221052.1642262-1-Jeremy.Jean%40oss.cyber.gouv.fr)

v1: https://lore.kernel.org/all/20261031221052.1642262-1-Jeremy.Jean@oss.cyber.gouv.fr/

 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c   | 4 +---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h   | 1 -
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c | 5 +----
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index 61b04c6c0390..fb586514b41d 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -96,7 +96,6 @@ static void rmnet_unregister_bridge(struct rmnet_port *port)
 	if (port->rmnet_mode != RMNET_EPMODE_BRIDGE)
 		return;
 
-	rmnet_dev = port->rmnet_dev;
 	if (!port->nr_rmnet_devs) {
 		/* bridge device */
 		real_dev = port->bridge_ep;
@@ -113,6 +112,7 @@ static void rmnet_unregister_bridge(struct rmnet_port *port)
 		port->rmnet_mode = RMNET_EPMODE_VND;
 	}
 
+	rmnet_dev = netdev_master_upper_dev_get(bridge_dev);
 	netdev_upper_dev_unlink(bridge_dev, rmnet_dev);
 	rmnet_unregister_real_device(bridge_dev);
 }
@@ -163,7 +163,6 @@ static int rmnet_newlink(struct net_device *dev,
 		goto err2;
 
 	port->rmnet_mode = mode;
-	port->rmnet_dev = dev;
 
 	hlist_add_head_rcu(&ep->hlnode, &port->muxed_ep[mux_id]);
 
@@ -487,7 +486,6 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
 	slave_port = rmnet_get_port_rtnl(slave_dev);
 	slave_port->rmnet_mode = RMNET_EPMODE_BRIDGE;
 	slave_port->bridge_ep = real_dev;
-	slave_port->rmnet_dev = rmnet_dev;
 
 	port->rmnet_mode = RMNET_EPMODE_BRIDGE;
 	port->bridge_ep = slave_dev;
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
index 5adda0323dda..26c1d8bccc14 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
@@ -37,7 +37,6 @@ struct rmnet_port {
 	u8 rmnet_mode;
 	struct hlist_head muxed_ep[RMNET_MAX_LOGICAL_EP];
 	struct net_device *bridge_ep;
-	struct net_device *rmnet_dev;
 
 	/* Egress aggregation information */
 	struct rmnet_egress_agg_params egress_agg_params;
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index 39d6d084e73f..bd68d60b50d3 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -543,10 +543,7 @@ static void rmnet_send_skb(struct rmnet_port *port, struct sk_buff *skb)
 {
 	if (skb_needs_linearize(skb, port->dev->features)) {
 		if (unlikely(__skb_linearize(skb))) {
-			struct rmnet_priv *priv;
-
-			priv = netdev_priv(port->rmnet_dev);
-			this_cpu_inc(priv->pcpu_stats->stats.tx_drops);
+			dev_core_stats_tx_dropped_inc(port->dev);
 			dev_kfree_skb_any(skb);
 			return;
 		}
-- 
2.47.3

