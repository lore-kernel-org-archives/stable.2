Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879773EC803
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337274; cv=none; b=qd+0T1Zl7ogydbODsAQD2Bk9P+0PML1zKnr+kzqFITg7gWq35zgaW24P5WNFLoMOfyih12W1SjBb6OY1kdWjVHe99huK5rJZKugl8MhVDEEJCuI916h9TkdTrMlCsv/ynPMZegoOHV3HtIBVQSNPp77ZS7x/zc1n2MUL8tIaPEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337274; c=relaxed/simple;
	bh=HNSgvV5Qlhfx8zhy8MJr7+GxHLQOGKZEEnSGDp0oWHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e09SciwyPBnuAouss7Y/mYdrs/1Bwx/YewadnXtgL2by1Owj2Hpqt1BeElmLna6w70dkG4WtD4uFn5xslg9SxqQ/pb2gvhXX2coCufU2cZ81M6VrT8r98ga8nvToHb6wS/UFoAew5i73RELg4zdf1TjSY7uTLW1KQXr4VnC0sPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=Xu6l1p/E; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="Xu6l1p/E"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1785337264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qntCaPvK/cEPEmnSN8zaGLKfguhu9sPiOkOp9T2YV64=;
	b=Xu6l1p/EQ1Lw3RBnGqmOXkUYZR4r1KR21ZWAqLZLPDCZ/Wk/+A/0mS7cHAKspdRnrGBBUK
	1lYnoi0W/tb58hAMllZ3RS3B+5Gbf5KypdJyK2HjlD23G6NggaZBVNy73VkPsr9HTJQq+D
	Zhmvdkg5CIGfdDJUSL1A5CEWfgJFv7ehHhPq/Fa8P+OWnamcrO6exE3J8alcO18nH2eqwC
	fpNQsPp4JXwn9gOv7ozKi+k8PvkfDGCE165ZFUO05xIFvcp8HtOKrnevtgOCWo2gaF3EEz
	9oYABGyS4V5fK/p+fbhbQZR+wNsH9AoFTWuwViNa8xqHme4vMwvwyZBGYL7ufw==
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: stable@vger.kernel.org
Cc: nbd@nbd.name
Subject: [PATCH 5.15.y] wifi: mt76: mt7615: drop TXRX_NOTIFY on non-mmio buses
Date: Wed, 29 Jul 2026 08:00:56 -0700
Message-ID: <20260729150056.49369-1-lucid_duck@justthetip.ca>
In-Reply-To: <2026072914-convent-flame-f173@gregkh>
References: <2026072914-convent-flame-f173@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

commit 39afc46c0243d10b7795e6e6cf4ae91f41732120 upstream.

PKT_TYPE_TXRX_NOTIFY is an mmio-only event, but mt7615_rx_check() and
mt7615_queue_rx_skb() dispatch it to mt7615_mac_tx_free() on every bus.
mt7615_mac_tx_free() cleans the DMA tx queues with
mt76_queue_tx_cleanup(), which calls queue_ops->tx_cleanup(). Only the
mmio queue ops implement that callback; on the mt7663 USB and SDIO
buses it is NULL, so a TXRX_NOTIFY there calls a NULL pointer in the RX
worker. Same defect as the mt7921 and mt7925 patches in this series.

Drop the event on non-mmio buses via mt76_is_mmio(), as in
commit 5683e1488aa9 ("wifi: mt76: connac: do not check WED status for
non-mmio devices").

Fixes: eb99cc95c3b6 ("mt76: mt7615: introduce mt7663u support")
Cc: stable@vger.kernel.org
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Link: https://patch.msgid.link/20260627191336.20223-4-lucid_duck@justthetip.ca
Signed-off-by: Felix Fietkau <nbd@nbd.name>
[ No mt7615_rx_check() on this tree, so only the mt7615_queue_rx_skb()
  hunk applies, and mt7615_mac_tx_free() takes the skb rather than
  (data, len), so the guard frees it here. ]
---
Compile-tested on v5.15.212; mt7615-common, mt7615e and mt7663u build.
Not runtime-tested, I have no MT7663 and that is the only chip that
reaches this path.

 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 2f0ba8a75..ee90ec27f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1601,6 +1601,10 @@ void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 		dev_kfree_skb(skb);
 		break;
 	case PKT_TYPE_TXRX_NOTIFY:
+		if (!mt76_is_mmio(mdev)) {
+			dev_kfree_skb(skb);
+			break;
+		}
 		mt7615_mac_tx_free(dev, skb);
 		break;
 	case PKT_TYPE_RX_EVENT:
-- 
2.55.0

