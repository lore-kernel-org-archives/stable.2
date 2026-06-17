Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3662239BFEC;
	Wed, 17 Jun 2026 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687878; cv=none; b=sQ94aLM1pPmdIjWhCtSBVRe3y+QHGJ4+1bY4uto5JWxr9tbwltegTtJpX520JJmvTfJleGo6/TgFnYNh/8Eer4z5tzegxq0TeMweLlOZIIVHSPmNm15PoTYR+Pc8Owi0sLTnb3g9B4/b0J16Slioyb1nokWXBgh/4hLgEJGUpo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687878; c=relaxed/simple;
	bh=1jBDxYXWJq8oVg4cfwRSFslEeHBgkTsITO5M9rYbr1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gg2TryQ6nuLGD1euMOmC6cst+8sjKB1DEipsWzcpvfY9aa89gmWQASkOLIfF1cuGE1CWxNVd6HGOTuhZyBI8qnDn2kipwR1vM8nvItzLrwuCyFqzn0tIn9RpDA0PbTGM5RxPWbvgSsbw6ag1d9aAZsYCL0igsxxkax5wf/NpAqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qm0iVjU4; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qm0iVjU4"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 722B94E42F2C;
	Wed, 17 Jun 2026 09:17:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 46A8A601AA;
	Wed, 17 Jun 2026 09:17:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 804AA106CA350;
	Wed, 17 Jun 2026 11:17:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781687868; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=G9FpCeKi3Ynv/LOiUy9epKx2SW5IzmteIiDj38KugCY=;
	b=Qm0iVjU4OMdghsQmnsSO/ZVglUuAgnSWOLaEln7sLb0stSd5BiwNTG+skRE5W6v3NM36gN
	WIQOk93EJD4sv52sOkRdC9HVawr/X7IFU80SnCCXq1PazwZhwep1i9OgCmhKP2wFB1zGoc
	GB13r44Stdt2gEgUmPQ9q0Wc/7qHoUm4h4m7TiaNtiWtbj3eNC2ZzwF+EPWwbb8ePFfN8N
	qvNsINoO3ALOm5y1vsJVXflVV2fQT8s76IUjL/6eSGp0JF40a4ibAL/sMhj9QEPcn3N5yL
	O/b+AA+zriz0OkqoSBxJne3TuK/MHTD9n+4MLuAli8RdO4XGmVqJ6ApiAWzEfQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 17 Jun 2026 11:17:30 +0200
Subject: [PATCH net v3 2/2] net: macb: drop in-flight Tx SKBs on close
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-macb-drop-tx-v3-2-d4c7e57d890b@bootlin.com>
References: <20260617-macb-drop-tx-v3-0-d4c7e57d890b@bootlin.com>
In-Reply-To: <20260617-macb-drop-tx-v3-0-d4c7e57d890b@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Haavard Skinnemoen <hskinnemoen@atmel.com>, Jeff Garzik <jeff@garzik.org>, 
 Conor Dooley <conor.dooley@microchip.com>
Cc: Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

The MACB driver has since forever leaked the outgoing SKBs that
have not yet been marked as completed. They live in queue->tx_skb
which gets freed without remorse nor checking.

macb_free_consistent() gets called in a few codepaths, but only
close will trigger the added expressions. In macb_open() and
macb_alloc_consistent() failure cases, tx_skb just got allocated
and is empty.

Use the new macb_tx_unmap() prototype to report our error as
SKB_DROP_REASON_NOT_SPECIFIED rather than SKB_CONSUMED which makes it
sound like no error occurred. Equivalent to dev_kfree_skb_any().

Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 9caae1ef52b1..5a2500bd59a6 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2678,8 +2678,26 @@ static void macb_free_consistent(struct macb *bp)
 	dma_free_coherent(dev, size, bp->queues[0].rx_ring, bp->queues[0].rx_ring_dma);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		kfree(queue->tx_skb);
-		queue->tx_skb = NULL;
+		if (queue->tx_skb) {
+			unsigned int dropped = 0, tail;
+
+			for (tail = queue->tx_tail; tail != queue->tx_head;
+			     tail++) {
+				if (macb_tx_skb(queue, tail)->skb)
+					dropped++;
+				macb_tx_unmap(bp, macb_tx_skb(queue, tail), 0,
+					      SKB_DROP_REASON_NOT_SPECIFIED);
+			}
+
+			queue->stats.tx_dropped += dropped;
+			bp->dev->stats.tx_dropped += dropped;
+
+			kfree(queue->tx_skb);
+			queue->tx_skb = NULL;
+		}
+
+		queue->tx_head = 0;
+		queue->tx_tail = 0;
 		queue->tx_ring = NULL;
 		queue->rx_ring = NULL;
 	}

-- 
2.54.0

