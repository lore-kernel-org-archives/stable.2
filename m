Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47883B777F
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 19:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761248; cv=none; b=kDx632dAoioQ9op29GFHlTaycgnjrR5+g0Ol27eQ9vFik4AMEE4+ZtHvoZaIeY7qXlIFaPV+q7J0jrhai4BepMo42WyHiz2VBSEsv5zgxeH0koKuXUTkvDbIyjFq4KWSelczDXSunRXskfTb4qg+WkVsCdSh3e6BpCV74aKDShg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761248; c=relaxed/simple;
	bh=YTLoOtzggd75ofadzNM5nLCuNcBYUHtNQkZ/LA7voDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z4hm1YQ1yq60jP2URM056J8kq/AvXJIQDtLQMwBtSg1wKHWA+goN/uEG4peqyM/qPmiI0nGLhm6oU97kzoPTuKKivDY20f4D3at+GkSgNpiS7+OA+1gcn0UMMvyRZwv8VDbIbS2mVZk1H7FIO/hSWHug+oH082eM45iIhDKdTPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1kJk8guF; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1kJk8guF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1B81F4E4087E;
	Fri, 18 Sep 2026 19:54:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C9CC960649;
	Fri, 18 Sep 2026 19:54:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8469C10329076;
	Fri, 18 Sep 2026 21:53:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789761238; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=6IAjsEyp5x75FpK9nj/qoLvJuAPfPki/nTpBi96TaeI=;
	b=1kJk8guFlBJDkB/L9sohlbO2Rq/0x41Ln8LWHUpBsdDbTv2CYzj3G/7QeyyPUXTi6NKWDs
	ovUg0G2XZMv/PCLYDm359C+ZkPPVAad1hDD1Plt9n7ZgoZcx6AvwdixVbcc6c7WYn2zqOi
	Az4EcL2xFLYAkW6cqiF2jUhM+hjANuO9XyHPpZuWVV6s/JBYpjZhbvCyjKUc89olu8GVph
	BbuYewh+sp8lxXPxMmsnAfthu5ccyzjXJ+9Vqdsotp5JPNhJifWrVxmDNwmZCmxUWVUEk8
	YJxuWmJc/MuH/gVzodQ0P1k8mzcVN78IpJuHgc+TAzgFEOAClnpgO7/GtyxSNA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 18 Sep 2026 21:53:52 +0200
Subject: [PATCH net] net: macb: fix dma_alloc_coherent() leak on
 macb_alloc() error paths
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260918-macb-alloc-leak-v1-1-aba9a3d4f6e3@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQ6CMBAFf4Xs2U0KRmz9FeOhLA9drYW0aEwI/
 27R40wys1BGUmQ6VQslvDXrGAvUu4rk5uMVrH1hakzTGldbfnrp2IcwCgf4B2PYW2ddaw5ypFJ
 NCYN+fsczRcx0+cv86u6QeXvRun4Bq1zbJHgAAAA=
X-Change-ID: 20260918-macb-alloc-leak-ef38989605c7
To: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Sean Anderson <sean.anderson@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Fix 3 leaks in macb_alloc() error paths:
- Tx buffer allocated but crossing a 4G boundary: Tx leaked.
- Rx buffer allocation fails: Tx leaked.
- Rx buffer allocated but crossing a 4G boundary: Tx & Rx leaked.

This is because our error handling calls macb_free(bp) which in turn
frees the buffers stored in bp->queues[0], but nothing has been stored
in there. Fix by storing allocated buffers into bp->queues[0] ASAP.

Fixes: 78d901897b3c ("net: macb: single dma_alloc_coherent() for DMA descriptors")
Cc: stable@vger.kernel.org
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b8234ac4b602..8e5c034dc3a4 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2749,14 +2749,24 @@ static int macb_alloc(struct macb *bp)
 
 	size = bp->num_queues * macb_tx_ring_size_per_queue(bp);
 	tx = dma_alloc_coherent(dev, size, &tx_dma, GFP_KERNEL);
-	if (!tx || upper_32_bits(tx_dma) != upper_32_bits(tx_dma + size - 1))
+	if (!tx)
+		goto out_err;
+	/* Record the buffer so that the error path frees it. */
+	bp->queues[0].tx_ring = tx;
+	bp->queues[0].tx_ring_dma = tx_dma;
+	if (upper_32_bits(tx_dma) != upper_32_bits(tx_dma + size - 1))
 		goto out_err;
 	netdev_dbg(bp->netdev, "Allocated %zu bytes for %u TX rings at %08lx (mapped %p)\n",
 		   size, bp->num_queues, (unsigned long)tx_dma, tx);
 
 	size = bp->num_queues * macb_rx_ring_size_per_queue(bp);
 	rx = dma_alloc_coherent(dev, size, &rx_dma, GFP_KERNEL);
-	if (!rx || upper_32_bits(rx_dma) != upper_32_bits(rx_dma + size - 1))
+	if (!rx)
+		goto out_err;
+	/* Record the buffer so that the error path frees it. */
+	bp->queues[0].rx_ring = rx;
+	bp->queues[0].rx_ring_dma = rx_dma;
+	if (upper_32_bits(rx_dma) != upper_32_bits(rx_dma + size - 1))
 		goto out_err;
 	netdev_dbg(bp->netdev, "Allocated %zu bytes for %u RX rings at %08lx (mapped %p)\n",
 		   size, bp->num_queues, (unsigned long)rx_dma, rx);

---
base-commit: 994db8ab9d90c64dd641b7ead6efe2eaea7a50dc
change-id: 20260918-macb-alloc-leak-ef38989605c7

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>

