Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5227B3AFD06
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767901; cv=none; b=Xf2r2wJZxCXF/+NiEVjxpJIGVHQsRacugls7mA76NepBBVQo+4KKb6pN34K8tI38shYAZ0yKb0n0esCWIjw3O4ERVAbqFD5HNvVUg6MXpn9dDcFzOayaODFJId1qXL9R8URq/lJCe6ChOejaueVGzZyQAOhmSiyJKv9gTdAHT0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767901; c=relaxed/simple;
	bh=WPUmm4x0j6sthZegG14XFdkTt4ANCL74A0r6femNKjE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sCjpXg+KkrTYWnPOIl6SdYd8k/6cEOWO9XRbzHnpS/D+ajE1ZYW0thiKiBUOOEpUWpDb9ho720SRnf428Ck5QOufvTvieNXQ3u2VwbYapNdTbXCrp03j8hToZnhrosKnfA93X+5e8+czjksJ094emtfObYTOsv1z1f+1+KI/RDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=R9Xj4S0T; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R9Xj4S0T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=TS
	hkSJ3EKVJ+nT+YZSx3ZP/36ZacHpx0Z8A5KjGt3WI=; b=R9Xj4S0Te9NVncurnV
	MyFn5bktq++uPMmccDUjFY7aTymp/lKufrdVqXT0Xuo13EdgjIcfW7OXvqIkzZnL
	zNmW8XFj8/KVhhKnj02L1SZc/mSCR4rkImsrYjkDjlmIPnvCLPmyWsGGkaO2Ok23
	tW1sgXn8f5MOwtKBFig/+R8Zk=
Received: from u2.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3X9sT87xqUk0VCA--.2041S2;
	Wed, 30 Sep 2026 19:31:32 +0800 (CST)
From: taozj888@163.com
To: taozj888@163.com
Cc: stable@vger.kernel.org
Subject: [PATCH net v2] net: macb: rate limit netdev error info print in the data path
Date: Wed, 30 Sep 2026 11:31:27 +0000
Message-Id: <20260930113127.388863-1-taozj888@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgD3X9sT87xqUk0VCA--.2041S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFWrAry3tw18ZF1rGr1xXwb_yoW5AF4Upa
	yUA398Ww4kJr47A3Z7try8Ar1rAr98Kry5WrWkK3W3Xw15Ar90gFyagryYkFW8Ga9xAw1S
	yw1UZayqkan3ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRQeOLUUUUU=
X-CM-SenderInfo: hwdr6yqyyyqiywtou0bp/xtbC3hTLk2q88xRpJgAA3s

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

