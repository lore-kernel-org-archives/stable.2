Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824465;
	b=gmkudDRgCVAAGyhRSHHbQiZUSrfBvfLYXQF2pYSj/9n+ZYeOoZelqGox+pztcmF+lfRn
	 CYlwCcQca2R23wfL3jaoFB4B4bn6HJjxIgmgKASAAVzCBYGYz0cOToX5ExxjlMTQIv3RL
	 aiRfw9Pu+MjlU4NP7/HE1lhQ4uBrEm0Q/AAUiZRKRhCoavv7XwyvTTXxiQEzc6OUGslBB
	 REbH1QEhGKlgzBA3+jp3dfkuiFPCTpCNVceAj/PxRhdOvis34IlH1u4Qzm1/JkcPLju0P
	 W7dFkOyfPf1EjBpI9Mgxa54lIHd4WPMTjs3e+Zee0zfa1jgy9dJdtLe/CBh+XB7cvKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824465;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PODueEbuV8yQIK2sk6E9OJLlqXL1eOnZsVPrULsCgVw=;
	b=ZH7Q6ZPMMbnUVhhodlPu5zvLbJVcoYMJrDW2/NJrlF+OkLhw/EAeYVcjqstK4TMyWuph
	 uA5LNVnDJjNxXp6fv+Wd4bNCxqNIh2co2lIMvK08dh7XUJp+uc4pEbV4tSyw73Gi3s0YL
	 YTN7EEKbybBdL+mHStIMMNjkR4LPjWXIhJ2HuFNUzfmaZYmqa5eEk66xI7B5lzrr19AdV
	 B9DxxI1qpJh67M1bBQUNtm8JfEKY+nG4e2CgtfW2R4E/8LbVSSJV9I+sy5l9pTsECjhO0
	 T8WsUblijHn90gRlptClriglaBFAZ7qFrYzPzdBNstuAse/n6/VUr7Tkk3uOA2ESXkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mi5+MsfS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF56606A338;
	Mon, 16 Nov 2026 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mi5+MsfS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A111C1F000C4;
	Mon, 16 Nov 2026 10:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794824465;
	bh=PODueEbuV8yQIK2sk6E9OJLlqXL1eOnZsVPrULsCgVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mi5+MsfSg1uL7Fjfs9BWNfnhXaeY2PLIrvq+cKL9rs13lUOZ9SWIn2/qpJnBETq3V
	 g/XZI4xSwhN7dQ2hQ2lVXbCj7k2hrWyvma5PpUVkhfjlG+LryS7EpbQ8NmtGeWAvTa
	 Wb71OxoQTWRgRiHNpTCNHzOLsiPdSEk8U62FPU+GEOVBjhueiAsVznsAPVzQTdP7QS
	 O0tfWbyXQL6nRy92H3umyimes7joHJDHt7w5a8JFr0C+aIh/gAAnf//IQzLBPoxX3j
	 8YlLsgX/8eUdR0RUwVXcwq51z2SjTLCrX54R4cTbXPZmYNlJcN0wmvD1HvRDusgeMd
	 nG5r4w/8u6OxA==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net 2/2] net: sgi: ioc3-eth: fix IRQ lifetime against netdev teardown
Date: Mon, 16 Nov 2026 11:19:34 +0100
Message-ID: <20261116101934.25910-3-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116101934.25910-1-kaloz@kernel.org>
References: <20261116101934.25910-1-kaloz@kernel.org>
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

The shared IRQ is requested before the lock and timer its handler
uses are initialized, and stays registered past free_netdev() on the
probe error paths and in remove, so the handler can run on freed
memory.

Reproduced with CONFIG_DEBUG_SHIRQ=y and slub_debug=P and tested on
an SGI Fuel.

Fixes: 0ce5ebd24d25 ("mfd: ioc3: Add driver for SGI IOC3 chip")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/179473760071.2199510.16065103101920438822@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index ee284a4f75ff..e322a588d5c4 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -870,16 +870,16 @@ static int ioc3eth_probe(struct platform_device *pdev)
 		goto out_free;
 	}
 
-	if (devm_request_irq(&pdev->dev, dev->irq, ioc3_interrupt,
-			     IRQF_SHARED, "ioc3-eth", dev)) {
+	spin_lock_init(&ip->ioc3_lock);
+	timer_setup(&ip->ioc3_timer, ioc3_timer, 0);
+
+	if (request_irq(dev->irq, ioc3_interrupt, IRQF_SHARED, "ioc3-eth",
+			dev)) {
 		dev_err(&pdev->dev, "Can't get irq %d\n", dev->irq);
 		err = -ENODEV;
 		goto out_free;
 	}
 
-	spin_lock_init(&ip->ioc3_lock);
-	timer_setup(&ip->ioc3_timer, ioc3_timer, 0);
-
 	ioc3_stop(ip);
 
 	/* Allocate rx ring.  4kb = 512 entries, must be 4kb aligned */
@@ -951,6 +951,7 @@ static int ioc3eth_probe(struct platform_device *pdev)
 	return 0;
 
 out_stop:
+	free_irq(dev->irq, dev);
 	timer_delete_sync(&ip->ioc3_timer);
 	if (ip->rxr)
 		dma_free_coherent(ip->dma_dev, RX_RING_SIZE, ip->rxr,
@@ -969,6 +970,7 @@ static void ioc3eth_remove(struct platform_device *pdev)
 	struct ioc3_private *ip = netdev_priv(dev);
 
 	unregister_netdev(dev);
+	free_irq(dev->irq, dev);
 	timer_delete_sync(&ip->ioc3_timer);
 
 	dma_free_coherent(ip->dma_dev, RX_RING_SIZE, ip->rxr, ip->rxr_dma);
-- 
2.47.3

