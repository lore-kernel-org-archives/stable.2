Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98CE35E956;
	Fri, 18 Sep 2026 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761591; cv=none; b=lGcXUfRSXMUi2C/0YgfGxhCIzKcCX9RUtQpXOWYibNobTFCZ5lJL3fhjpICVMvbVjnsYUcQJn0Qol9y/7hq2Gj20JAXCytIkP3iKI0xQHmqqK6GHhGBBUa+yrAn3V0juN28uIks+E70SapC2IEk1vBLwZTokXiQYzKDM6/FUaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761591; c=relaxed/simple;
	bh=X9XU9RNBrOVJynv+zAUP6Ketsd7FbbI4e+VigF5/FUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JQcF4sGAa+z3rsYNbxUcheNWPH8MV+nzIMIFbCKfVRP8d0T3b/0LU7URWJRt0bbUG2GfY//vZPm4ftphfUgk8HE+BpGdcPvOGdADRzfTblnVKmsW80iTCqQGNU5TAkvej1NttrpPnBQCu5KYy9KfZ7wihxt8VfLlJSbCfP4dLdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rYYVoP6H; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rYYVoP6H"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DDB474E4087E;
	Fri, 18 Sep 2026 19:59:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 926E560649;
	Fri, 18 Sep 2026 19:59:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC56010329075;
	Fri, 18 Sep 2026 21:59:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789761580; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=15bsGnenTWO9f3acWlYUaevEUJQ4D57tNbNdixb/HX4=;
	b=rYYVoP6HZ/kINjt3APcXnLuJqpawnWLKDB1V0qRK3Xqas5Ejw1IFJ6NIhtg2iZ+zzX35Dy
	JEL/neYba+PerObIJn1zO/k4ML5KbV1zMQTPjQVho57lL/kjJLszyzbOxKA4mjGeYnusY3
	Mz1RHbpix8RVFonFLdPwknzGmWm1decG68LShouuPCOWbo8tx5yF7JGuNuvD1PO4h8k/Z0
	RlRFm2ujIU3x6Y3iAE/bbGqMh35UQFo/nfNgluTLoB0QS9NtrA/qV6GOP2AE2jmPGfj4uI
	oKfJNNW5f2f7u9mfGh5TEoXfcVzXZS4+m8a+aSqm2d/VRN+Gj1MlfHEtuyRpDg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 18 Sep 2026 21:59:35 +0200
Subject: [PATCH net] net: macb: take bp->lock around NCR read-modify-writes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260918-macb-ncr-rmw-v1-1-30c3494f93cd@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM2wrCMBAFf6WcZxeSFuvlV6QPTTzVFRplU61Q+
 u9GfZyBmQWZpsw4VguML816TwX8pkK89ulC0XNh1K5u3cHvZexjkBRNbJwlcOubHVs3uICSPIy
 Dvn+7ExIndH+Zn+HGOH1HWNcPyMFciHUAAAA=
X-Change-ID: 20260918-macb-ncr-rmw-be5137e60f0b
To: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Antoine Tenart <atenart@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

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
---
 drivers/net/ethernet/cadence/macb_main.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b8234ac4b602..b58d3f01f2cc 100644
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

---
base-commit: 994db8ab9d90c64dd641b7ead6efe2eaea7a50dc
change-id: 20260918-macb-ncr-rmw-be5137e60f0b

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>

