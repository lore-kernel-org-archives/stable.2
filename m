Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D0F318146;
	Wed, 30 Sep 2026 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768262; cv=none; b=H5djOMHFaH3O0pWg3qt+ROxajg+YEfH/J275TaFtD1/DwyNEcUlqkPzZPzCXynD5erMr4GuktfIOXDR4Gv/DujPeHOC/GyJz2VRsNGSM4sjeatEUJ3loaOC07aaV4aeytVfk8ly50qMWekAuMbhcGFIKt7h4eosjWv1sRvonvpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768262; c=relaxed/simple;
	bh=WPUmm4x0j6sthZegG14XFdkTt4ANCL74A0r6femNKjE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IF+sJwIaWKaGQ/3YMK1GTpKFux0c1C+qZyjxDCJ8q4e1epTnwdXJ1SrTnYqrniivSCXciDD5RpJHbFnuuvCYiyBoEgYv47AyhXncY41k9NhYv0VX1cN0wpHDZ2gSqqb7aTbv96+gKy9AG4EFVAu/RseciN3LJwKSW/x4QdgFcCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oKIrs53u; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oKIrs53u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=TS
	hkSJ3EKVJ+nT+YZSx3ZP/36ZacHpx0Z8A5KjGt3WI=; b=oKIrs53un0fYOrSZfZ
	QzoJQseUe+CplqQS0WsJ/4//yhj/SRQ/z5Zv/vupEQg+Ygn/1GN5BLB2gFlW2NZk
	QI/EfmdNrmj2VPvMhTVQbsFwi+VmX9GtFLvDxARyKRw/XkYb+XQrddSHTxc8+3W4
	qCXPjP1T8nDUCxkF+p0IbsWvI=
Received: from u2.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCHVcgu9Lxqu8AVCA--.1276S2;
	Wed, 30 Sep 2026 19:36:15 +0800 (CST)
From: taozj888@163.com
To: theo.lebrun@bootlin.com
Cc: taozijin <taozj888@163.com>,
	stable@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Jeff Garzik <jeff@garzik.org>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] net: macb: rate limit netdev error info print in the data path
Date: Wed, 30 Sep 2026 11:35:20 +0000
Message-Id: <20260930113520.392025-1-taozj888@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCHVcgu9Lxqu8AVCA--.1276S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFWrAry3tw18ZF1rGr1xXwb_yoW5AF4Upa
	yUA398Ww4kJr47A3Z7try8Ar1rAr98Kry5WrWkK3W3Xw15Ar90gFyagryYkFW8Ga9xAw1S
	yw1UZayqkan3ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zES_MDUUUUU=
X-CM-SenderInfo: hwdr6yqyyyqiywtou0bp/xtbC3g8S2Wq89C9-gAAA3o

From: taozijin <taozj888@163.com>

Now the MACB ethernet driver print the netdev error information
directly by netdev_err(), which would lead to a large number of
error information print if there was a significant number of
error or just jumbo packets exceeding the MTU received when booting.
For example, it would print a large number of:

macb PHYT0036:00 eth0: not whole frame pointed by descriptor
macb PHYT0036:00 eth0: not whole frame pointed by descriptor
...

in gem_rx() by received a large number of packets without
RX_EOF flag set, especially with unknown packet
type that would penetrate the hardware offload for the IP packets.

The unlimited prints here would greatly bother and delay
the system booting process unless the source stop sending
packets since they occupy the console output bandwidth and
other processes have to wait for the completion of printing those
messages.

So rate limit the netdev error information print in the receive
and transmit data path.

Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
Cc: stable@vger.kernel.org

Signed-off-by: Zijin Tao <taozj888@163.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 8e5c034dc3a4..ca60960bec36 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1617,16 +1617,16 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		count++;
 
 		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF))) {
-			netdev_err(bp->netdev,
-				   "not whole frame pointed by descriptor\n");
+			if (net_ratelimit())
+				netdev_err(bp->netdev, "not whole frame pointed by descriptor\n");
 			bp->netdev->stats.rx_dropped++;
 			queue->stats.rx_dropped++;
 			break;
 		}
 		skb = queue->rx_skbuff[entry];
 		if (unlikely(!skb)) {
-			netdev_err(bp->netdev,
-				   "inconsistent Rx descriptor chain\n");
+			if (net_ratelimit())
+				netdev_err(bp->netdev, "inconsistent Rx descriptor chain\n");
 			bp->netdev->stats.rx_dropped++;
 			queue->stats.rx_dropped++;
 			break;
@@ -1829,7 +1829,8 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 		unsigned long flags;
 		u32 ctrl;
 
-		netdev_err(bp->netdev, "RX queue corruption: reset it\n");
+		if (net_ratelimit())
+			netdev_err(bp->netdev, "RX queue corruption: reset it\n");
 
 		spin_lock_irqsave(&bp->lock, flags);
 
@@ -2102,7 +2103,8 @@ static int macb_interrupt_misc(struct macb_queue *queue, u32 status)
 
 	if (status & MACB_BIT(HRESP)) {
 		queue_work(system_bh_wq, &bp->hresp_err_bh_work);
-		netdev_err(netdev, "DMA bus error: HRESP not OK\n");
+		if (net_ratelimit())
+			netdev_err(netdev, "DMA bus error: HRESP not OK\n");
 		macb_queue_isr_clear(bp, queue, MACB_BIT(HRESP));
 	}
 
-- 
2.34.1

