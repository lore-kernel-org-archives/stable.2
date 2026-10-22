Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661951;
	b=1J+u6sftvcW4TmqgXPBNx84kMvzeNXk4rkbAVVj1fK8tKEHfYEboWNucbfjdyj8XzZo4
	 Mw9NCi9ZTOIoRVTGpgJVwE1tgIQBitK01hd03mPRsYffacsc30ZOwOQOJhdNsWlAqZvVH
	 PILZZDJtqFtvCfCITvpXGjwzseulGn2X+SdoOeGK+PAuakANEw90FjQ0EYMOvojffbMob
	 Vy4Sy5d2lhXU9ZQMr2gTl/Htorcg30cIKG0ld4+UeLM9tXSQMKiyj5oUnP0BRIaB+2NrV
	 aHskaqT+T1tspUsANOknbvXg2F4myfDwT3LoWLtbNShJ035waYySVA3XXsxQc1a+2gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661951;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Rspamd-Queue-Id;
	bh=n8VLqU8X1/rvJlMP8QTqyuejzFMpUVHeeiGzG9y9yC8=;
	b=OjeGRTh+PyljnSf09RhQatTeQ2dsgpSYKFWDgxd7tJx9tJuythaul5Q4Gd594Bj9BANk
	 Eeqy+ABEaJNQ5wvSivC5W7bFobOX6qjzz72u/yhY2KwKiXKjpLACwy/G3IoGLWJYAPBFt
	 fFT9zRV//expdheGr0NdVv9ALGUM/vOYSEMCN63fUs4+urwB7XNwBRV7pFD589AZnIT0n
	 KZOrbL/QnkhUBoJZwnH4aWRGql/ayc7if0s8wewcbuOhjyhqLAKiSchAApAT7XLjudKmT
	 34WJCpHtOBEILd1TvI+9Mf2naujTeJYDRP5PcpUV3BwyhPINeuWSUrV7FQQUpN0KymQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=steffen.cc;
	spf=pass smtp.mailfrom=steffen.cc;
	dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=vnFKD6Zo;
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C9860A2622;
	Thu, 22 Oct 2026 09:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69C9860A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=vnFKD6Zo
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4j9Lh558qKz8v0b;
	Thu, 22 Oct 2026 11:39:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1792661941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n8VLqU8X1/rvJlMP8QTqyuejzFMpUVHeeiGzG9y9yC8=;
	b=vnFKD6ZoZXIGOFHK4r+eYFOu5U8S1za/28aieN54KmhIDjzob0MeFMGcjieL5DKYaTz8MG
	+tc5ksZVpwvMIrSoWEzHgphAnLrtWh8y2kLpOh83k0hqXXBkB5Za770LRPCBkDybUbBeaw
	juB1SzZJVJxxX0rsgU15wQC3mHKlgalJeLZLf61lpzwNY4l9wAk8rE5CtS9OjaBLQbrqYR
	d+dUJixtlkqB2PctOvkz/JYyNxwpaOUOrlHTwiSkRp0G9aJk6P2uNYq4yb8QOamSlCFg8E
	sZ6jjAGJHXd3exFfktgiUb7u1n29RhntosvELNfQOci/KbIe6oDLNIvFPjCDlg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Thu, 22 Oct 2026 11:38:46 +0200
Subject: [PATCH RFC net 1/6] net: macb: take bp->lock around NCR
 read-modify-writes
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-std-macb-v14-send-v1-1-9187bc545bf6@beckhoff.com>
References: <20261022-std-macb-v14-send-v1-0-9187bc545bf6@beckhoff.com>
In-Reply-To: <20261022-std-macb-v14-send-v1-0-9187bc545bf6@beckhoff.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Kevin Hao <haokexin@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Andrea della Porta <andrea.porta@suse.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792661936; l=3510;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=JAFcJ/X0rEVHNId3QslLF0CCZGplzoClBUV8j/p/9fk=;
 b=mReO/ATBuedMrogAYTppWW+7skEJ++GIjWGJaR2eRPRENi46qDxSf7JZc+pdRtu/FuWpPYA1E
 gO05pO+HB+WBxz0hnBa0TNHvzQMzKpDLVqRmLcCCzFGb80xR3bp/IGh
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4j9Lh558qKz8v0b

From: Théo Lebrun <theo.lebrun@bootlin.com>

NCR is read-modify-written from many contexts:

 - macb_mac_link_down() clears RE|TE,
 - macb_mac_link_up() sets RE|TE|PTPUNI,
 - macb_hresp_error_task() clears then re-sets RE|TE,
 - macb_start_xmit() / macb_tx_restart() / macb_tx_error_task() set
   TSTART (already under bp->lock),
 - macb_interrupt() might toggle RE (also under bp->lock).

The first three risk concurrent RMW with anyone from the list as they
don't grab bp->lock.

Theoretical bugfix only, it has never reproduced on hardware. Also note
it does *not* take the lock hoping to protect against full races
inbetween BH scheduling concurrently. We only want to ensure consistent
NCR RMW operations.

Fixes: 7897b071ac3b ("net: macb: convert to phylink")
Cc: stable@vger.kernel.org
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 261a7e87520a..4b5037867537 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -777,6 +777,7 @@ static void macb_mac_link_down(struct phylink_config *config, unsigned int mode,
 	struct net_device *netdev = to_net_dev(config->dev);
 	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue;
+	unsigned long flags;
 	unsigned int q;
 	u32 ctrl;
 
@@ -786,8 +787,10 @@ static void macb_mac_link_down(struct phylink_config *config, unsigned int mode,
 				     bp->rx_intr_mask | MACB_TX_INT_FLAGS | MACB_BIT(HRESP));
 
 	/* Disable Rx and Tx */
+	spin_lock_irqsave(&bp->lock, flags);
 	ctrl = macb_readl(bp, NCR) & ~(MACB_BIT(RE) | MACB_BIT(TE));
 	macb_writel(bp, NCR, ctrl);
+	spin_unlock_irqrestore(&bp->lock, flags);
 
 	netif_tx_stop_all_queues(netdev);
 }
@@ -940,11 +943,13 @@ static void macb_mac_link_up(struct phylink_config *config,
 	}
 
 	/* Enable Rx and Tx; Enable PTP unicast */
+	spin_lock_irqsave(&bp->lock, flags);
 	ctrl = macb_readl(bp, NCR);
 	if (gem_has_ptp(bp))
 		ctrl |= MACB_BIT(PTPUNI);
 
 	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
+	spin_unlock_irqrestore(&bp->lock, flags);
 
 	netif_tx_wake_all_queues(netdev);
 }
@@ -1995,6 +2000,7 @@ static void macb_hresp_error_task(struct work_struct *work)
 	struct macb *bp = from_work(bp, work, hresp_err_bh_work);
 	struct net_device *netdev = bp->netdev;
 	struct macb_queue *queue;
+	unsigned long flags;
 	unsigned int q;
 	u32 ctrl;
 
@@ -2003,9 +2009,11 @@ static void macb_hresp_error_task(struct work_struct *work)
 					 MACB_TX_INT_FLAGS |
 					 MACB_BIT(HRESP));
 	}
+	spin_lock_irqsave(&bp->lock, flags);
 	ctrl = macb_readl(bp, NCR);
 	ctrl &= ~(MACB_BIT(RE) | MACB_BIT(TE));
 	macb_writel(bp, NCR, ctrl);
+	spin_unlock_irqrestore(&bp->lock, flags);
 
 	netif_tx_stop_all_queues(netdev);
 	netif_carrier_off(netdev);
@@ -2022,8 +2030,10 @@ static void macb_hresp_error_task(struct work_struct *work)
 			     MACB_TX_INT_FLAGS |
 			     MACB_BIT(HRESP));
 
-	ctrl |= MACB_BIT(RE) | MACB_BIT(TE);
-	macb_writel(bp, NCR, ctrl);
+	spin_lock_irqsave(&bp->lock, flags);
+	ctrl = MACB_BIT(RE) | MACB_BIT(TE);
+	macb_writel(bp, NCR, macb_readl(bp, NCR) | ctrl);
+	spin_unlock_irqrestore(&bp->lock, flags);
 
 	netif_carrier_on(netdev);
 	netif_tx_start_all_queues(netdev);

-- 
2.56.0

