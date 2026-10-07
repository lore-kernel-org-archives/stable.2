Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B5035C6BA;
	Wed,  7 Oct 2026 05:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791351264; cv=none; b=FtaKWkLnSBfYouFkb3qsC7Zbsta6sn+zfmZeL3Gp+q14unYMNUCYTMlqyWnh4t8BPzOJ7nWA/AYb9vixQz3aY08O1rPBLLgsMnf9aaEm1mRSTKMjvi396sCQE+i0dK1xo3KQSqsevv1XpsibFy3JDHKLQAOUJpnjDWEg7sauFL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791351264; c=relaxed/simple;
	bh=xyjZnBApJh1Pg/RZkDZQCAwfYmoEf1X5Cjwmtu80k8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AW/KP/2HF3pGgoc18ZV/b/WsgigQk6rohsZ3R8rWXaYFFPiu8hmUFK6e0bHvlokMaa887C6ENLYhPpYogTUYF82Cch096qC3aZeXo1NhEAdsA+h9NdELpYgjUNepXxW7wJzwJHo5drQ+8PAdHkakuKKe1KCS3rRjNlRWwUmRhdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jG+OzBpU; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jG+OzBpU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=MQx9JXZA88cBn8283aVngoS/qRY5gYd6ZRe8OYcIRqk=;
	b=jG+OzBpUB8rPVauyQjjSGIYzhWjLKampbH21p3auWoWTFpMUKV/0IrL+JdTbzh
	u9GWTsZw3W1QVf9jFIO5SBO/WWHBluh6Z4023Z/X0My0UitHmqRSlDP3mh6Noqws
	Bp/s9Jg4AbkEAk4U9TJLSrV1Zg5S0jqIUoMjx4+HGEWso=
Received: from u2.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3xxp_2cVqlGm3Cw--.16818S2;
	Wed, 07 Oct 2026 13:32:48 +0800 (CST)
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
	Jeff Garzik <jeff@garzik.org>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v4] net: macb: rate limit netdev error info print in the data path
Date: Wed,  7 Oct 2026 05:32:11 +0000
Message-Id: <20261007053211.572073-1-taozj888@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3xxp_2cVqlGm3Cw--.16818S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFWrAry3tw18ZF1rGr1xXwb_yoWrJr1xpa
	yUA3s8Ww4kJr47Aas7tr10yF1rZr98tryUWrWkKw1Yqw15Zr90gFWagryY9FW8Gas3A3WF
	yF1UZFZFka1kZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziFoGJUUUUU=
X-CM-SenderInfo: hwdr6yqyyyqiywtou0bp/xtbC3gCiamrF2YBOBgAA3o

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
Changes since v1:

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

