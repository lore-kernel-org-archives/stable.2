Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229046;
	b=v9H0frF+vLGRP7gpof89H55lsITygYYpKSDSDfOt+77jkzx90Kr2XgycD4vIG236HkcC
	 KoxhpZcr8J/k10ZBV75eVlgESGZmAvzGQyQBK1n8m+rEwnsahsmbfNGH79PUhPw/3tQdP
	 aRXKBCZxCPxG88GhptPx5TSXW++uX+oUWi5MJJwQ6Noey87ZOVqv9Huuahu/qJTpLORZM
	 vkKdV/RXue7aayMaA8RThcj3tceXPqfeMXMWpWmNzI4MqHTrZZR48rVWfEGALOGGriFgk
	 Gy9xFHAWZRuvJGKE9kK742qTiTxS0rD2sDMPClczNXcVe4JcTTAfoxdyQLeL1vXexIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229046;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=decC6/EKFH5ygjGtgwveqkqNEtpd268ptmFddrXcQkE=;
	b=zmS7uYbS0LIzWWzmeoMvXwGBZKEHmfJKHNZGfCw3jaks5492/8rDW8QB1XAqeuVyOfID
	 SkxOiUJRrBz1EXjg4OXl5FmavR0cxq5zsUWu2PaDen6j3Y1/YFg8U0ZF9Px95z667LgRY
	 2QUavyGSLZABnXYyXIaAuqbQYfvf4S2yy7nc25q8zhcDs8Q8RcFW5f1CU1o+j96OJTW0a
	 CtvhV9GqzwmdvBfuuSivQfG/d69Ho4sCTN1ZKn3h7x8Xf6qN4+LTgVnj+TTSCF0RShcrV
	 UNtH9bECA8MoTBhTzBbTJv7BRoAg3OxxJ71FVvoD3UT7Qz5f3ZWyD2NxbVUWfpw0caQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=ag8NylaB;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A830E606A31C;
	Mon,  9 Nov 2026 12:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A830E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=ag8NylaB
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8E3A3A0021;
	Mon, 09 Nov 2026 13:57:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794229040; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=decC6/EKFH5ygjGtgwveqkqNEtpd268ptmFddrXcQkE=;
	b=ag8NylaBvFXAoooQLCb5KYvDCoc9EzouQ8vh15P+yAwFILO/BFMtvcoGG7E6kUb4KzfM+6
	/b5zYZo0WY2EkoE8N0dl7JOywH447CieFC6VTUhOkRTGUoB/UN11p5HLaLkYOlNGNFSnX0
	q47MQNI5eQpbjL4UqLZ9ZKEO7ae1UazeSKZLVqphslkAhmrMz5of8RlOj4hJJSgH9XJ8nw
	QA1rOrnrsDo5iPhRCOQRKwE3SOOJD0M+BKd3FUKB3rZptVWFKYSvE9kouVQEoWFiYFJpIh
	O2Rqo4lC52ywUYp/iecFdF06wWSNlxjWLF1Gy7jdAoFDKxnpH4O3RyBdG+dFSQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Mon, 09 Nov 2026 13:57:09 +0100
Subject: [PATCH 6.18.y] net: macb: wait for a running xmit before resetting
 BQL on close
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
Message-Id: <20261109-nb-macb-close-6-18-y-v1-1-51af4b20dffb@tipi-net.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0Q6CMAwAf4X02ZJ1SgV/xfjAZtUaHWRVIyH8u
 1Mf75K7GUyyisGumiHLS02HVIBWFcRLn86CeiwM3nkmch2mgPc+Boy3wQQZqcUJyXPn1hvfNLy
 Fko5ZTvr+bffANbX1BIe/t2e4Snx8n7AsH37+SbuAAAAA
X-Change-ID: 20261109-nb-macb-close-6-18-y-126903425567
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

macb_close() stops the queues without waiting for an xmit still
running on another CPU. That frame charges BQL after the reset and
never completes, so after the reopen the queue stays stopped with an
empty ring and the watchdog fires until the next close.

Seen on a Raspberry Pi CM5 with ethtool -G under load.

Upstream fixed this as part of the context swap rework in commit
dcc3288b9433a ("net: macb: use context swapping in .set_ringparam()"),
which is too large for stable.

Fixes: e6a532185daa ("net: cadence: macb: Implement BQL")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Fixes a close race in 6.18.y and 7.3.y. Older LTS kernels have no BQL
in macb and 7.4 has the fix through Théo's context swap series, so let's
keep the fix small instead of pulling that whole series in.

The stall was observed on a Raspberry Pi CM5 (2/30 close/open cycles under
load stalled), so it is worth fixing.
---
 drivers/net/ethernet/cadence/macb_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1eaf9be483153..422dd167187da 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3156,14 +3156,16 @@ static int macb_close(struct net_device *dev)
 	unsigned long flags;
 	unsigned int q;
 
-	netif_tx_stop_all_queues(dev);
-
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		napi_disable(&queue->napi_rx);
 		napi_disable(&queue->napi_tx);
-		netdev_tx_reset_queue(netdev_get_tx_queue(dev, q));
 	}
 
+	netif_tx_disable(dev);
+
+	for (q = 0; q < bp->num_queues; ++q)
+		netdev_tx_reset_queue(netdev_get_tx_queue(dev, q));
+
 	phylink_stop(bp->phylink);
 	phylink_disconnect_phy(bp->phylink);
 

---
base-commit: c3f63d70f236bb7685e6d11d1d9b5b351552e600
change-id: 20261109-nb-macb-close-6-18-y-126903425567

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

