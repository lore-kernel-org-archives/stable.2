Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486043B6BF1;
	Sat, 10 Oct 2026 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791624166; cv=none; b=GtmqMUoIc39/paVnEOt0inFen3CutYlfVxNHEN6JLfx+d8nSs+aqY4stk73jckK8b8BQbtAQ6Un3ukMiSsZm5TC4q4+vzRsABw1BNzbfMKyyxECtP0+y0jZInlrn5WN6uys/PiN+Mfu/SxP5WADRJXgd0qESrJ/KS47OdOTbgak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791624166; c=relaxed/simple;
	bh=6/4qvDnaYM2Z85U+qehegp5waEtzX0dhCN/9J3t82TA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QYs331IJY02IEvKpoe3mvPoQ4UgL6vf76KPaMPQdaaridnjV87eo24xs3odZttYT+LESS8YOG20XKxNNOIWhi9GuxBY/j5bPmcm9YcAoj6/e32Tlx5/Z0mM1Q8WCX2gRKQUEtewgVGm4zbNlNBbR1LqSHYb9LaBsRQMhDzTJbww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EWUUlwtV; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EWUUlwtV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=Zg2aBdBdTLP9z/WGD5ND/M8stJfE0DaZc3MKIYs9Juo=;
	b=EWUUlwtV9OtfeaIR8NS/MuIGWzcVRH4txpOXC9Z4stjbe1SwQYy5zrUH5dHmyt
	uOOUGCUQLA07QNA19DRN8SqnrcqVfwB7NuhhV3fyKdc71OAe6OswZ4m4hheDvv1U
	yMVDNT/A9irq5BtIoJZHqySuURPvqkSQGQpr70dX4TrmQ=
Received: from lx2.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3n3qeA8pqnP+WDg--.44293S2;
	Sat, 10 Oct 2026 17:21:35 +0800 (CST)
From: Zijin Tao <taozj888@163.com>
To: theo.lebrun@bootlin.com
Cc: Zijin Tao <taozj888@163.com>,
	stable@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v5] net: macb: rate limit netdev error info print in the data path
Date: Sat, 10 Oct 2026 17:21:34 +0800
Message-Id: <20261010092134.130564-1-taozj888@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n3qeA8pqnP+WDg--.44293S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFWrAry3tw18ZF1rGr1xXwb_yoWrCryfpa
	yUC3s8Jw4kJr42yas7tr40vF1rZrn8tryUWrW8Gw13Xw15Xr98WFySgrya9FW8GayfA3WF
	yr1DZFZIka1kZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEBT5JUUUUU=
X-CM-SenderInfo: hwdr6yqyyyqiywtou0bp/xtbC+R81-GrKA583jQAA3p

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

Fixes: 4df95131ea80 ("net/macb: change RX path for GEM")
Cc: stable@vger.kernel.org
Signed-off-by: Zijin Tao <taozj888@163.com>
---

Changes since v1:

v5:

- Update the commit message for the target fix id to 4df95131ea80
which was indicated by Theo <theo.lebrun@bootlin.com> and Nicolai
<nb@tipi-net.de>
- Update the user name in the "From" part to Zijin Tao which is
the same as that of "Signed-off-by"

v4:

- Update the commit message for the target fix id to 89e5785fc8a6
as suggested by Nicolai Buchwitz<nb@tipi-net.de>
- Update the patch with the changelog added in the patch itself

v3:

- add this change log since v2 missing it
- drop the blank line between the assignment sentence and the commit
  info

v2:

- update the commit message with the reason why the unlimit prints would
  bother/delay booting process
- update the commit message with the Fix commit id provided which is
  suggested by Théo Lebrun<theo.lebrun@bootlin.com>
- update the commit message with what packet type would trigger the
  error printings more easily.

v1:

- initial commit

 drivers/net/ethernet/cadence/macb_main.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b8234ac4b602..c32d48d03008 100644
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
 
@@ -2511,7 +2513,8 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 		else
 			hdrlen = skb_tcp_all_headers(skb);
 		if (skb_headlen(skb) < hdrlen) {
-			netdev_err(bp->netdev, "Error - LSO headers fragmented!!!\n");
+			if (net_ratelimit())
+				netdev_err(bp->netdev, "Error - LSO headers fragmented!!!\n");
 			/* if this is required, would need to copy to single buffer */
 			return NETDEV_TX_BUSY;
 		}
-- 
2.34.1

